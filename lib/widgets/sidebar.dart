import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meowdicine/http/backend_api.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String _username = '';

  @override
  initState() {
    super.initState();
    _initUsername();
  }

  void _initUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    if (username != null) {
      setState(() {
        _username = username;
      });
    }
  }

  String _createBannerText() {
    return 'Velkommen, $_username';
  }

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final username = prefs.getString('username');
    if (token != null && username != null) {
      try {
        await BackendApi.logout(token, username);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    prefs.remove('token');
    prefs.remove('username');
    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/auth_gate',
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(_createBannerText(),
                style: const TextStyle(
                  color: Colors.white,
                )),
          ),
          ListTile(
            selected: widget.title == 'Hjem',
            leading: const Icon(Icons.home),
            title: const Text('Hjem'),
            onTap: () {
              Navigator.pop(context);
              if (widget.title != 'Hjem') {
                Navigator.pushNamed(context, '/home');
              }
            },
          ),
          ListTile(
            selected: widget.title == 'Dyr',
            leading: const Icon(Icons.pets),
            title: const Text('Dyr'),
            onTap: () {
              Navigator.pop(context);
              if (widget.title != 'Dyr') {
                Navigator.pushNamed(context, '/animals');
              }
            },
          ),
          const Divider(
            height: 48,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logg ut'),
            onTap: () {
              _logout(context);
            },
          ),
        ],
      ),
    );
  }
}
