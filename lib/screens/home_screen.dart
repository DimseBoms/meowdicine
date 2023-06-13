import 'package:flutter/material.dart';

import 'package:meowdicine/widgets/medicine_calendar.dart';

import '../widgets/sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _pageTitle = 'Hjem';

  @override
  Widget build(BuildContext context) {
    // return a widget that represents your home screen
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle),
      ),
      drawer: Sidebar(
        title: _pageTitle,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MedicineCalendar(
              title: 'Medisinkalender',
            ),
          ],
        ),
      ),
    );
  }
}
