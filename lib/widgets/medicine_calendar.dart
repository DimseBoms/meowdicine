import 'package:flutter/material.dart';

class MedicineCalendar extends StatefulWidget {
  const MedicineCalendar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MedicineCalendar> createState() => _MedicineCalendarState();
}

class _MedicineCalendarState extends State<MedicineCalendar> {
  String _currentMonthPretty(int month) {
    final monthNames = {
      1: 'Januar',
      2: 'Februar',
      3: 'Mars',
      4: 'April',
      5: 'Mai',
      6: 'Juni',
      7: 'Juli',
      8: 'August',
      9: 'September',
      10: 'Oktober',
      11: 'November',
      12: 'Desember',
    };
    return monthNames[month] ?? 'Ukjent';
  }

  _currentDatePretty() {
    final dayNames = {
      1: 'Mandag',
      2: 'Tirsdag',
      3: 'Onsdag',
      4: 'Torsdag',
      5: 'Fredag',
      6: 'Lørdag',
      7: 'Søndag',
    };
    final dayNumber = DateTime.now().day;
    final monthName = _currentMonthPretty(DateTime.now().month);
    final dayOfWeek = dayNames[DateTime.now().weekday] ?? 'Ukjent';
    return '$dayOfWeek, den $dayNumber. $monthName ${DateTime.now().year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(
          maxWidth: 800,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(_currentDatePretty(),
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 730)),
                lastDate: DateTime.now(),
                onDateChanged: (DateTime value) {
                  // Do something with the new date
                },
              ),
            ),
          ],
        ));
  }
}
