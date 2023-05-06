import 'package:flutter/material.dart';

import '../widgets/medicine_calendar.dart';
import '../objects/animal.dart';
import '../objects/prescription.dart';


class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _pageTitle = 'Medisinkalender';
  String _popupMessage = 'Hello, popup!';
  DateTime _selectedDateTime = DateTime.now();
  Animal _testArne = Animal(
    name: 'Arne',
    birthday: DateTime.now().subtract(const Duration(days: 365*15)),
    species: 'Katt',
    prescriptions: [
      Prescription(
        name: 'Apelka',
        dosage: '0.5',
        unit: 'ml',
        frequency: '2',
      ),
    ],
  );

  void _showPopupMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Popup'),
          content: Text(_popupMessage),
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

  void _refreshSelectedDate(DateTime date) {
    setState(() {
      _selectedDateTime = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return a widget that represents your home screen
    return Scaffold(
      body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_pageTitle, style: Theme.of(context).textTheme.headlineMedium),
            Text(_selectedDateTime.toString()),
            MedicineCalendar(title: 'Medisinkalender', animal: _testArne),
          ],
        ),
      ),
    );
  }
}