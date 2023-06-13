import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarOverview extends StatefulWidget {
  const CalendarOverview({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CalendarOverview> createState() => _CalendarOverviewState();
}

class _CalendarOverviewState extends State<CalendarOverview> {
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
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          TableCalendar(
            firstDay: DateTime.utc(2021, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: DateTime.now(),
          ),
        ],
      ),
    );
  }
}
