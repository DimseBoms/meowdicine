import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:meowdicine/http/backend_api.dart';
import 'package:meowdicine/objects/user.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    // Widget containing text fields and buttons for logging in
    // or registering a new user
    return LoginWidget();
  }
}

class LoginWidget extends StatelessWidget {
  LoginWidget({
    super.key,
  });

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get username => _usernameController.text;
  String get password => _passwordController.text;

  void _login(BuildContext context) async {
    print('Logging in with username: $username and password: $password');
    final response = await BackendApi.login(username, password);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      final token = jsonDecode(response.body)['token'];
      prefs.setString('token', token);
      prefs.setString('username', username);
      print('Successfully saved token to shared preferences');
      print(prefs.getString('token'));
      print(prefs.getString('username'));
    }
  }

  void _register(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Brukernavn',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Passord',
            ),
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _register(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text('Registrer'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _login(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text('Logg inn'),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
