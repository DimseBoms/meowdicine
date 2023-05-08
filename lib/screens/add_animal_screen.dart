import 'package:flutter/material.dart';
import 'package:meowdicine/objects/animal.dart';

class AddAnimalScreen extends StatefulWidget {
  const AddAnimalScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AddAnimalScreen> createState() => _AddAnimalScreenState();
}

class _AddAnimalScreenState extends State<AddAnimalScreen> {
  DateTime _selectedDate = DateTime.now();

  Widget _showInputDatePickerFormField() {
    return InputDatePickerFormField(
      firstDate: DateTime(1900),
      lastDate: _selectedDate,
      initialDate: _selectedDate,
      onDateSubmitted: (DateTime value) {
        setState(() {
          _selectedDate = value;
        });
      },
    );
  }

  void _showDatePickerDialog() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: _selectedDate,
      initialDate: _selectedDate,
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Legg til nytt dyr',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Navn',
                  ),
                ),
                TextField(
                  controller: _speciesController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Art',
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(
                            text: _selectedDate.toString()),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Fødselsdato',
                        ),
                        readOnly: true,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _showDatePickerDialog();
                      },
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
