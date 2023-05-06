import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    // return a widget that represents your home screen
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'User',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
