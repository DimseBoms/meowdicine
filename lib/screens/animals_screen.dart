import 'package:flutter/material.dart';

import '../widgets/sidebar.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const Sidebar(
        title: "Dyr",
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Dyr',
            ),
          ],
        ),
      ),
    );
  }
}
