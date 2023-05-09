import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meowdicine/styles/styles.dart';
import 'package:meowdicine/http/backend_api.dart';

// TODO: Refactor this screen to take use of the new UserController

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
    return const LoginWidget();
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
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
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
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/home');
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
                  children: [
                    const Text('Klarte ikke å logge inn'),
                    Icon(
                      Icons.error,
                      color: Theme.of(context).colorScheme.error,
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
                children: [
                  const Text('Klarte ikke å logge inn'),
                  Icon(
                    Icons.wifi_off,
                    color: Theme.of(context).colorScheme.error,
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
      if (response.statusCode == 200) {
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
                  children: [
                    const Text('Suksess'),
                    Icon(
                      Icons.check_circle_outline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                content: const Text('Du er nå registrert!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(context, '/home');
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
                  children: [
                    const Text('Klarte ikke å registrere bruker'),
                    Icon(
                      Icons.error,
                      color: Theme.of(context).colorScheme.error,
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
                children: [
                  const Text('Klarte ikke å registrere bruker'),
                  Icon(Icons.wifi_off,
                      color: Theme.of(context).colorScheme.error),
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

  Widget _buildLogin(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logg inn'),
      ),
      body: Center(
        child: Card(
          margin: CardStyles.cardPadding,
          shape: const RoundedRectangleBorder(
            borderRadius: CardStyles.cardBorderRadius,
          ),
          elevation: CardStyles.cardElevation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: CardStyles.cardTitlePadding,
                child: Text('Logg inn',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: CardStyles.maxFormWidth),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: CardStyles.formInputFieldPadding,
                        child: TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Brukernavn',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      Padding(
                        padding: CardStyles.formInputFieldPadding,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Passord',
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: CardStyles.buttonPadding,
                              child: ElevatedButton(
                                onPressed: () {
                                  _register(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.tertiary,
                                ),
                                child: const Padding(
                                  padding: CardStyles.buttonTextPadding,
                                  child: Text('Registrer'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: CardStyles.buttonPadding,
                              child: ElevatedButton(
                                onPressed: () {
                                  _login(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                child: const Padding(
                                  padding: CardStyles.buttonTextPadding,
                                  child: Text('Logg inn'),
                                ),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildLogin(context);
  }
}
