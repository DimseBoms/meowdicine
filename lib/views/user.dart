import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  String _welcomeMessage = 'User';
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
