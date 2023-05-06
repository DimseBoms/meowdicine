import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meowdicine/database/database_helper.dart';

import 'package:meowdicine/views/home.dart';
import 'package:meowdicine/views/calendar.dart';
import 'package:meowdicine/views/animals.dart';
import 'package:meowdicine/views/auth_gate.dart';

import 'objects/user.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = DatabaseHelper().initializeDatabase();
  // Check if the user is logged in.
  User user = await DatabaseHelper().getUser();
  print('User: $user');
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const AppRoot(title: 'Medisinpåminner'),
    );
  }
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  int _navigationIndex = 0;

  void _navigateTo(int index) {
    setState(() {
      _navigationIndex = index;
    });
  }

  _activePageTitle() {
    switch (_navigationIndex) {
      case 0:
        return const Text('Hjem');
      case 1:
        return const Text('Kalender');
      case 2:
        return const Text('Dyr');
      case 3:
        return const Text('Bruker');
      default:
        return const Text('Hjem');
    }
  }

  _activePage() {
    switch (_navigationIndex) {
      case 0:
        return const Home(title: 'Hjem');
      case 1:
        return const Calendar(title: 'Kalender');
      case 2:
        return const Animals(title: 'Dyr');
      case 3:
        return const AuthGate(title: 'Bruker');
      default:
        return const Home(title: 'Hjem');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: _activePageTitle(),
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Hjem'),
              onTap: () {
                _navigateTo(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Kalender'),
              onTap: () {
                _navigateTo(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.pets),
              title: const Text('Dyr'),
              onTap: () {
                _navigateTo(2);
                Navigator.pop(context);
              },
            ),
            const Divider(
              height: 30,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Bruker'),
              onTap: () {
                _navigateTo(3);
                Navigator.pop(context);
              },
            ),
          ],
        )),
        body: _activePage());
  }
}
