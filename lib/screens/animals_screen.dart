import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../objects/animal.dart';
import '../widgets/sidebar.dart';
import '../http/backend_api.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  String _token = '';
  List<Animal> _animals = [];

  @override
  initState() {
    super.initState();
    _initCredentials();
  }

  _initCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      setState(() {
        _token = token;
      });
      final response = await BackendApi.getAnimals(token);
      if (response.statusCode == 200) {
        final animals = jsonDecode(response.body)['animals'];
        if (animals != null) {
          for (var animal in animals) {
            setState(() {
              _animals.add(Animal.fromJson(animal));
            });
          }
        }
      }
    }
  }

  bool _isLoggedIn() {
    return _token != '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: const Sidebar(
          title: "Dyr",
        ),
        body: Stack(
          children: <Widget>[
            _buildNoAnimals(context),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          focusColor: Colors.blue,
          onPressed: () {
            Navigator.pushNamed(context, '/add_animal', arguments: {
              'token': _token,
            });
          },
          tooltip: 'Legg til dyr',
          child: const Icon(Icons.add),
        ));
  }

  Widget _buildAnimalsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(4, (index) {
        return Center(
          child: Text(
            'Dyr $index',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        );
      }),
    );
  }

  Align _buildNoAnimals(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Text(
          'Trykk på pluss-knappen for å legge til et dyr.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
