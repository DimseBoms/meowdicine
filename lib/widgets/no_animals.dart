import 'package:flutter/material.dart';

class NoAnimals extends StatelessWidget {
  const NoAnimals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Du har ingen dyr registrert.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  'Trykk på (+) knappen nederst til høyre for å legge til et.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
          ],
        ),
      ),
    );
  }
}
