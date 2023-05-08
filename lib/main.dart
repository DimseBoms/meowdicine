import 'package:flutter/material.dart';

import 'package:meowdicine/screens/home_screen.dart';
import 'package:meowdicine/screens/calendar_screen.dart';
import 'package:meowdicine/screens/animals_screen.dart';
import 'package:meowdicine/screens/auth_gate_screen.dart';
import 'package:meowdicine/screens/add_animal_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.pink,
        ),
      ),
      home: const AuthGateScreen(title: "Bruker"),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(
                builder: (context) => const HomeScreen(
                      title: "Hjem",
                    ));
          case '/animals':
            return MaterialPageRoute(
                builder: (context) => const AnimalsScreen(
                      title: "Dyr",
                    ));
          case '/auth_gate':
            return MaterialPageRoute(
                builder: (context) => const AuthGateScreen(
                      title: "Bruker",
                    ));
          case '/add_animal':
            return MaterialPageRoute(
                builder: (context) => const AddAnimalScreen(
                      title: "Legg til dyr",
                    ));
          default:
            return MaterialPageRoute(
                builder: (context) => const AuthGateScreen(title: "Bruker"));
        }
      },
    );
  }
}
