import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert'; // For jsonDecode

import 'package:meowdicine/screens/home_screen.dart';
import 'package:meowdicine/screens/calendar_screen.dart';
import 'package:meowdicine/screens/animals_screen.dart';
import 'package:meowdicine/screens/auth_gate_screen.dart';
import 'package:meowdicine/screens/add_animal_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp({Key? key, required this.theme}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
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
