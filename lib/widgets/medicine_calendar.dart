import 'package:flutter/material.dart';

import '../objects/animal.dart';

class MedicineCalendar extends StatefulWidget {
  const MedicineCalendar({Key? key, required this.title, required this.animal}) : super(key: key);

  final String title;
  final Animal animal;

  @override
  State<MedicineCalendar> createState() => _MedicineCalendarState();
}

class _MedicineCalendarState extends State<MedicineCalendar> {
  String _pageTitle = 'Medisinkalender';
  DateTime _selectedDateTime = DateTime.now();

  void _refreshSelectedDate(DateTime date) {
    setState(() {
      _selectedDateTime = date;
    });
  }


  Widget _buildCalendarRow(DateTimeRange week) {
    return Row(
      children: [
        Text(week.start.toString()),
        Text(week.end.toString()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: (_selectedDateTime.month == 2)
            ? 4
            : ((_selectedDateTime.month % 2 == 0) ? 5 : 6),
        itemBuilder: (BuildContext context, int index) {
          DateTimeRange week = DateTimeRange(
            start: DateTime(
              _selectedDateTime.year,
              _selectedDateTime.month,
              (index * 7) + 1,
            ),
            end: DateTime(
              _selectedDateTime.year,
              _selectedDateTime.month,
              (index * 7) + 7,
            ),
          );
          if (week.end.month != _selectedDateTime.month) {
            week = DateTimeRange(
              start: week.start,
              end: DateTime(
                _selectedDateTime.year,
                _selectedDateTime.month,
                DateTime(_selectedDateTime.year, _selectedDateTime.month + 1, 0).day,
              ),
            );
          }
          return _buildCalendarRow(week);
        },
      ),
    );
  }
}