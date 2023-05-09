import 'package:flutter/material.dart';
import 'package:meowdicine/screens/show_animal_screen.dart';

import '../objects/animal.dart';

class AnimalsGrid extends StatelessWidget {
  const AnimalsGrid({Key? key, required this.animals}) : super(key: key);

  final List<Animal> animals;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width > 500 ? 4 : 2,
      children: animals.map((animal) {
        return Padding(
          padding: EdgeInsets.all(
              MediaQuery.of(context).size.width > 500 ? 16.0 : 8.0),
          child: Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowAnimal(animal: animal),
                  ),
                );
              },
              child: Column(
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
            ),
          ),
        );
      }).toList(),
    );
  }
}
