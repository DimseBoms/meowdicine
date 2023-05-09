import 'package:flutter/material.dart';
import 'package:meowdicine/controllers/animals_controller.dart';

import '../objects/animal.dart';
import '../widgets/animal_form.dart';
import '../styles/styles.dart';

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
  final DateTime _selectedDate = _getInitialDate();

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
            child: SingleChildScrollView(
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Image.asset(
                          'assets/images/placeholder_cat.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  AnimalForm(
                    nameController: _nameController,
                    speciesController: _speciesController,
                    selectedDate: _selectedDate,
                    animal: widget.animal,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: CardStyles.buttonPadding,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiary,
                          ),
                          child: const Padding(
                            padding: CardStyles.buttonTextPadding,
                            child: Text('Del tilgang'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: CardStyles.buttonPadding,
                        child: ElevatedButton(
                          onPressed: () {
                            updateAnimal();
                          },
                          child: const Padding(
                            padding: CardStyles.buttonTextPadding,
                            child: Text('Bekreft endringer'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateAnimal() async {
    try {
      final Animal animal = Animal(
        id: widget.animal.id,
        name: _nameController.text,
        species: _speciesController.text,
        birthday: _selectedDate,
      );
      bool animalUpdated = await AnimalsController.updateAnimal(animal);
      if (animalUpdated) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Suksess'),
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  ],
                ),
                content: Text('${widget.animal.name} ble oppdatert.'),
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
      } else {
        throw Exception('Klarte ikke oppdatere');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Feil'),
                Icon(
                  Icons.wifi_off,
                  color: Theme.of(context).colorScheme.error,
                )
              ],
            ),
            content: const Text(
                'Klarte ikke oppdatere. Sjekk nettverksinstillingene dine og prøv igjen.'),
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
}
