import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Meowdicine',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            selected: title == 'Hjem',
            leading: const Icon(Icons.home),
            title: const Text('Hjem'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            selected: title == 'Dyr',
            leading: const Icon(Icons.pets),
            title: const Text('Dyr'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/animals');
            },
          ),
          const Divider(
            height: 48,
            thickness: 1,
          ),
          ListTile(
            selected: title == 'Bruker',
            leading: const Icon(Icons.person),
            title: const Text('Bruker'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/auth_gate');
            },
          ),
        ],
      ),
    );
  }
}
