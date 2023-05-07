import 'package:flutter/material.dart';

import 'package:meowdicine/widgets/medicine_calendar.dart';
import 'package:meowdicine/objects/animal.dart';
import 'package:meowdicine/objects/prescription.dart';

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

  // Generate test animal
  Animal _testArne = Animal(
    name: 'Arne',
    birthday: DateTime.now().subtract(const Duration(days: 365 * 15)),
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

  @override
  Widget build(BuildContext context) {
    // return a widget that represents your home screen
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: MedicineCalendar(
            title: 'Medisinkalender',
            animal: _testArne,
          ),
        ),
      ],
    );
  }
}
