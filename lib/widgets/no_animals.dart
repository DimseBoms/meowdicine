import 'package:flutter/material.dart';

class NoAnimals extends StatelessWidget {
  const NoAnimals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Du har ingen dyr registrert. ',
              style: Theme.of(context).textTheme.headlineSmall),
          Text('Trykk på (+) knappen nederst til høyre for å legge til et.',
              style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
