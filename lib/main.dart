import 'package:flutter/material.dart';

import 'package:meowdicine/screens/home_screen.dart';
import 'package:meowdicine/screens/calendar_screen.dart';
import 'package:meowdicine/screens/animals_screen.dart';
import 'package:meowdicine/screens/auth_gate_screen.dart';

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
      home: const HomeScreen(title: 'Hjem'),
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
          default:
            return MaterialPageRoute(
                builder: (context) => const HomeScreen(
                      title: "Hjem",
                    ));
        }
      },
    );
  }
}
