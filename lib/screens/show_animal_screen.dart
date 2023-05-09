import 'package:flutter/material.dart';

import '../objects/animal.dart';

class ShowAnimal extends StatefulWidget {
  const ShowAnimal({Key? key, required this.animal}) : super(key: key);

  final Animal animal;

  @override
  State<ShowAnimal> createState() => _ShowAnimalState();
}

class _ShowAnimalState extends State<ShowAnimal> {
  final double fieldFormPadding = 8.0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  DateTime _selectedDate = _getInitialDate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.animal.name),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.33,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 12.0, right: 12.0, bottom: 8),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.asset(
                        'assets/images/placeholder_cat.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(fieldFormPadding),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Navn',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.badge),
                    ),
                    controller: TextEditingController(text: widget.animal.name),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(fieldFormPadding),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Art',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.pets),
                    ),
                    controller:
                        TextEditingController(text: widget.animal.species),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(fieldFormPadding),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Bursdag',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.cake),
                    ),
                    controller: TextEditingController(
                        text: widget.animal.birthday.toString().split(' ')[0]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static DateTime _getInitialDate() {
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}
