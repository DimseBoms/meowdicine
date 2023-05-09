import 'package:flutter/material.dart';
import 'package:meowdicine/objects/animal.dart';

import '../styles/styles.dart';

class AnimalForm extends StatefulWidget {
  AnimalForm(
      {Key? key,
      required this.nameController,
      required this.speciesController,
      required this.selectedDate,
      required this.animal})
      : super(key: key);

  final TextEditingController nameController;
  final TextEditingController speciesController;
  final Animal? animal;
  DateTime selectedDate;

  @override
  State<AnimalForm> createState() => _AnimalFormState();
}

class _AnimalFormState extends State<AnimalForm> {
  @override
  initState() {
    super.initState();
    if (widget.animal != null) {
      widget.nameController.text = widget.animal!.name;
      widget.speciesController.text = widget.animal!.species;
      widget.selectedDate = widget.animal!.birthday;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: CardStyles.cardTitlePadding,
          child: Text(
            widget.animal == null ? 'Nytt dyr' : 'Rediger',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: CardStyles.maxFormWidth,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: CardStyles.formInputFieldPadding,
                child: TextField(
                  controller: widget.nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Navn',
                    prefixIcon: Icon(Icons.badge),
                  ),
                ),
              ),
              Padding(
                padding: CardStyles.formInputFieldPadding,
                child: TextField(
                  controller: widget.speciesController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Art',
                    prefixIcon: Icon(Icons.pets),
                  ),
                ),
              ),
              Padding(
                padding: CardStyles.formInputFieldPadding,
                child: TextField(
                  controller:
                      TextEditingController(text: _dateAsStringWithoutTime()),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Fødselsdato',
                    prefixIcon: IconButton(
                        onPressed: () {
                          _showDatePickerDialog();
                        },
                        icon: const Icon(Icons.calendar_today)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDatePickerDialog() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: widget.selectedDate,
    );
    if (pickedDate != null) {
      _setDate(pickedDate);
    }
  }

  void _setDate(DateTime date) {
    setState(() {
      widget.selectedDate = DateTime(date.year, date.month, date.day);
    });
  }

  String _dateAsStringWithoutTime() {
    return widget.selectedDate.toString().split(' ')[0];
  }
}
