import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  String _welcomeMessage = 'Calendar';
  String _popupMessage = 'Hello, popup!';

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

  @override
  Widget build(BuildContext context) {
    // return a widget that represents your home screen
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _welcomeMessage,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ElevatedButton(
              onPressed: _showPopupMessage, child: const Text('Popup')),
        ],
      ),
    );
  }
}
