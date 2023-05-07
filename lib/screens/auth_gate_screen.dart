import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:meowdicine/http/backend_api.dart';

class AuthGateScreen extends StatefulWidget {
  const AuthGateScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AuthGateScreen> createState() => _AuthGateScreenState();
}

class _AuthGateScreenState extends State<AuthGateScreen> {
  @override
  Widget build(BuildContext context) {
    // Widget containing text fields and buttons for logging in
    // or registering a new user
    return LoginWidget();
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    super.key,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String _username = '';
  String _token = '';

  @override
  void initState() {
    super.initState();
    _initCredentials();
  }

  void _initCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final username = prefs.getString('username');
    if (token != null && username != null) {
      setState(() {
        _username = username;
        _token = token;
      });
    }
  }

  bool _isLoggedIn() {
    return _token != '' && _username != '';
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get username => _usernameController.text;
  String get password => _passwordController.text;

  void _login(BuildContext context) async {
    try {
      final response = await BackendApi.login(username, password);
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        final token = jsonDecode(response.body)['token'];
        prefs.setString('token', token);
        prefs.setString('username', username);
        // Show success popup message
        setState(() {
          _token = token;
          _username = username;
        });
      } else {
        // Show error popup message
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Klarte ikke å logge inn'),
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ],
                ),
                content: const Text(
                    'Feil brukernavn eller passord. Sjekk at du har skrevet riktig.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text('OK'),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Klarte ikke å logge inn'),
                  Icon(
                    Icons.wifi_off,
                    color: Colors.yellow,
                  )
                ],
              ),
              content: const Text(
                  'Klarte ikke å koble til server. Sjekk internettforbindelsen din.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text('OK'),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _register(BuildContext context) async {
    try {
      final response = await BackendApi.register(username, password);
      if (response.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        final token = jsonDecode(response.body)['token'];
        prefs.setString('token', token);
        prefs.setString('username', username);
        // Show success popup message
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Suksess'),
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                  ],
                ),
                content: const Text('Du er nå registrert!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _token = token;
                        _username = username;
                      });
                      // Navigate to home page
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Show error popup message
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Klarte ikke å registrere bruker'),
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ],
                ),
                content: const Text(
                    'Brukernavnet er allerede i bruk. Velg et annet brukernavn.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text('OK'),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Klarte ikke å registrere bruker'),
                  Icon(Icons.wifi_off, color: Colors.yellow),
                ],
              ),
              content: const Text(
                  'Klarte ikke å koble til server. Sjekk internettforbindelsen din.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text('OK'),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('username');
    setState(() {
      _token = '';
      _username = '';
    });
  }

  Widget _buildLogin(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logg inn'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text('Logg inn eller registrer deg for å fortsette',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
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
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAccount(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konto'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Du er logget inn som $_username',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                username,
                style: const TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                onPressed: () {
                  _logout(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text('Logg ut'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn() ? _buildAccount(context) : _buildLogin(context);
  }
}
