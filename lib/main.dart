import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert'; // For jsonDecode

import 'package:meowdicine/screens/home_screen.dart';
import 'package:meowdicine/screens/animals_screen.dart';
import 'package:meowdicine/screens/auth_gate_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  final darkThemeStr =
      await rootBundle.loadString('assets/appainter_theme_dark.json');
  final darkThemeJson = jsonDecode(darkThemeStr);
  final darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson)!;

  runApp(MyApp(theme: theme, darkTheme: darkTheme));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  final ThemeData darkTheme;

  const MyApp({Key? key, required this.theme, required this.darkTheme})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system, // Follow system preference
      home: const AuthGateScreen(title: "Bruker"),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(
                builder: (context) => const HomeScreen(
                      key: Key('Home'),
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
                builder: (context) => const AuthGateScreen(title: "Bruker"));
        }
      },
    );
  }
}
