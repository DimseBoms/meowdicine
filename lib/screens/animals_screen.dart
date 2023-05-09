import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meowdicine/widgets/animal_form.dart';
import 'package:meowdicine/widgets/animals_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../objects/animal.dart';
import '../styles/styles.dart';
import '../widgets/sidebar.dart';
import '../http/backend_api.dart';
import '../widgets/no_animals.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  String _token = '';
  String _username = '';
  List<Animal> _animals = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  DateTime _selectedDate = _getInitialDate();

  @override
  initState() {
    super.initState();
    _fetchData();
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
        body: _animals.isNotEmpty
            ? AnimalsGrid(
                animals: _animals,
              )
            : const NoAnimals(),
        floatingActionButton: FloatingActionButton(
          focusColor: Colors.blue,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: AnimalForm(
                      nameController: _nameController,
                      speciesController: _speciesController,
                      selectedDate: _selectedDate,
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          final Animal animal = Animal(
                            name: _nameController.text,
                            species: _speciesController.text,
                            birthday: _selectedDate,
                            id: -1,
                          );
                          _createAnimal(context, animal);
                          _clearFormFields();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: const Padding(
                          padding: CardStyles.buttonTextPadding,
                          child: Text('Legg til'),
                        ),
                      ),
                    ],
                  );
                });
          },
          tooltip: 'Legg til dyr',
          child: const Icon(Icons.add),
        ));
  }

  _fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final username = prefs.getString('username');
    if (token != null && username != null) {
      setState(() {
        _token = token;
        _username = username;
      });
      final response = await BackendApi.getAnimals(token, username);
      if (response.statusCode == 200) {
        final animals = jsonDecode(response.body)['animals'];
        if (animals != null) {
          setState(() {
            _animals = animals
                .map<Animal>((animal) => Animal.fromJson(animal))
                .toList();
          });
        }
      } else {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Feil'),
                content: Text('Kunne ikke hente dyr: ${response.body}'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } else {
      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/auth_gate',
          (Route<dynamic> route) => false,
        );
      }
    }
  }

  void _createAnimal(BuildContext context, Animal animal) async {
    try {
      final response = await BackendApi.addAnimal(_token, _username, animal);
      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.pop(context);
          _fetchData();
        }
      } else {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: const [
                    Text('Feil'),
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    )
                  ],
                ),
                content: const Text('Kunne ikke legge til dyr'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Feil'),
                Icon(
                  Icons.error,
                  color: Colors.red,
                )
              ],
            ),
            content: const Text('Klarte ikke opprette dyr'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  static DateTime _getInitialDate() {
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  void _clearFormFields() {
    _nameController.clear();
    _speciesController.clear();
    _selectedDate = _getInitialDate();
  }
}
