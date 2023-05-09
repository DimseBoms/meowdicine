import 'package:flutter/material.dart';

import '../styles/styles.dart';

class AnimalForm extends StatefulWidget {
  AnimalForm(
      {Key? key,
      required this.nameController,
      required this.speciesController,
      required this.selectedDate})
      : super(key: key);

  final TextEditingController nameController;
  final TextEditingController speciesController;
  DateTime selectedDate;

  @override
  State<AnimalForm> createState() => _AnimalFormState();
}

class _AnimalFormState extends State<AnimalForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: CardStyles.cardTitlePadding,
          child: Text(
            'Nytt dyr',
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
