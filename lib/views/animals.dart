import 'package:flutter/material.dart';

class Animals extends StatefulWidget {
  const Animals({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Animals> createState() => _AnimalsState();
}

class _AnimalsState extends State<Animals> {
  @override
  Widget build(BuildContext context) {
    // return a widget that represents your home screen
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Animals',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
