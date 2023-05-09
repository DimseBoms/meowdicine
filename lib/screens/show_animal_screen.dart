import 'package:flutter/material.dart';

import '../objects/animal.dart';

class ShowAnimal extends StatelessWidget {
  const ShowAnimal({Key? key, required this.animal}) : super(key: key);

  final Animal animal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/placeholder_cat.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              animal.name,
              style: MediaQuery.of(context).size.width > 400
                  ? Theme.of(context).textTheme.bodyLarge
                  : Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
