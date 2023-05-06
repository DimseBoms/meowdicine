import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    // return a login page if the user is not logged in
    // return a user page if the user is logged in
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('AuthGate'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('Logg inn'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: const Text('Registrer'),
          ),
        ],
      ),
    );
  }
}
