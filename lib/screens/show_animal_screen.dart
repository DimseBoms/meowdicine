import 'package:flutter/material.dart';
import 'package:meowdicine/controllers/animals_controller.dart';

import '../objects/animal.dart';
import '../widgets/animal_form.dart';
import '../styles/styles.dart';
import '../widgets/message_dialog.dart';

class ShowAnimal extends StatefulWidget {
  const ShowAnimal({Key? key, required this.animal, required this.updateAnimal})
      : super(key: key);

  final Animal animal;
  final void Function(Animal animal) updateAnimal;

  @override
  State<ShowAnimal> createState() => _ShowAnimalState();
}

class _ShowAnimalState extends State<ShowAnimal> {
  final double fieldFormPadding = 8.0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  final DateTime _selectedDate = _getInitialDate();

  @override
  initState() {
    super.initState();
    _nameController.text = widget.animal.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rediger ${_nameController.text}'),
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
          setState(() {
            _nameController.text = animal.name;
          });
          widget.updateAnimal(animal);
          MessageDialog.showMessageDialog(
              context: context,
              type: MessageType.success,
              title: 'Suksess',
              message: '${_nameController.text} ble oppdatert.',
              buttonText: 'ok',
              onPressed: () {
                Navigator.of(context).pop();
              });
        }
      } else {
        throw Exception('Klarte ikke oppdatere');
      }
    } catch (e) {
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

  static DateTime _getInitialDate() {
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}
