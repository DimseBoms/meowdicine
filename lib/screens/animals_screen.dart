import 'package:flutter/material.dart';
import 'package:meowdicine/controllers/animals_controller.dart';
import 'package:meowdicine/controllers/user_controller.dart';
import 'package:meowdicine/widgets/animal_form.dart';
import 'package:meowdicine/widgets/animals_grid.dart';

import '../objects/animal.dart';
import '../styles/styles.dart';
import '../widgets/message_dialog.dart';
import '../widgets/sidebar.dart';
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
            ? AnimalsGrid(animals: _animals, updateAnimal: _updateAnimal)
            : const NoAnimals(),
        floatingActionButton: FloatingActionButton(
          focusColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: AnimalForm(
                        nameController: _nameController,
                        speciesController: _speciesController,
                        selectedDate: _selectedDate,
                        animal: null),
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
    UserController.checkCredentials(context);
    try {
      List<Animal> fetchedAnimals = await AnimalsController.fetchAnimals();
      if (fetchedAnimals.isNotEmpty) {
        setState(() {
          _animals = fetchedAnimals;
        });
      }
    } catch (e) {
      if (context.mounted) {
        MessageDialog.showMessageDialog(
            context: context,
            type: MessageType.networkError,
            title: 'Nettverksfeil',
            message:
                'Klarte ikke å koble til server. Sjekk internettforbindelsen din.',
            buttonText: 'ok',
            onPressed: () {
              Navigator.of(context).pop();
            });
      }
    }
  }

  void _updateAnimal(Animal animal) {
    setState(() {
      _animals[_animals.indexWhere((a) => a.id == animal.id)] = animal;
    });
  }

  void _createAnimal(BuildContext context, Animal animal) async {
    try {
      bool createdAnimal = await AnimalsController.addAnimal(animal);
      if (createdAnimal) {
        _fetchData();
        if (context.mounted) {
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          MessageDialog.showMessageDialog(
              context: context,
              type: MessageType.error,
              title: 'Feil',
              message: 'Klarte ikke opprette dyr. Prøv igjen.',
              buttonText: 'ok',
              onPressed: () {
                Navigator.of(context).pop();
              });
        }
      }
    } catch (e) {
      if (context.mounted) {
        MessageDialog.showMessageDialog(
            context: context,
            type: MessageType.networkError,
            title: 'Nettverksfeil',
            message:
                'Klarte ikke å koble til server. Sjekk internettforbindelsen din.',
            buttonText: 'ok',
            onPressed: () {
              Navigator.of(context).pop();
            });
      }
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
