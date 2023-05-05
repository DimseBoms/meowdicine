import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Popup'),
          content: const Text('Hello, popup!'),
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

  void _showDatePickerDialog(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 730)),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      _showDialog("You picked $pickedDate");
    }
  }

  @override
  Widget build(BuildContext context) {
    // return a widget that represents your home screen
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            _showDatePickerDialog(context);
          },
          child: const Text('Open Date Picker'),
        ),
      ),
    );
  }
}
