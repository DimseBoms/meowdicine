import 'package:flutter/material.dart';
import 'package:meowdicine/screens/show_animal_screen.dart';

import '../objects/animal.dart';

class AnimalsGrid extends StatefulWidget {
  const AnimalsGrid({Key? key, required this.animals}) : super(key: key);

  final List<Animal> animals;

  @override
  _AnimalsGridState createState() => _AnimalsGridState();
}

class _AnimalsGridState extends State<AnimalsGrid> {
  int crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          crossAxisCount = 5;
        } else if (constraints.maxWidth >= 900) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth >= 600) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 2;
        }
        return GridView.count(
          shrinkWrap: true,
          crossAxisCount: crossAxisCount,
          children: widget.animals.map((animal) {
            return Padding(
              padding: EdgeInsets.all(
                crossAxisCount >= 4 ? 16.0 : 8.0,
              ),
              child: Card(
                elevation: 4,
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
                        child: Padding(
                          padding: crossAxisCount >= 4
                              ? const EdgeInsets.only(
                                  top: 16.0, left: 16.0, right: 16.0)
                              : const EdgeInsets.only(
                                  top: 10.0, left: 10.0, right: 10.0),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            child: Image.asset(
                              'assets/images/placeholder_cat.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          animal.name,
                          style: crossAxisCount >= 4
                              ? Theme.of(context).textTheme.bodyLarge
                              : Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
