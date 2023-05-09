import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meowdicine/http/backend_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  static Future<void> checkCredentials(BuildContext? context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final username = prefs.getString('username');
    if (token == null || username == null) {
      if (context != null && context.mounted) {
        logout(context);
      } else {
        logout(null);
      }
    }
  }

  static Future<bool> register(String username, String password) async {
    final response = await BackendApi.register(username, password);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', jsonDecode(response.body)['token']);
      prefs.setString('username', username);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> login(String username, String password) async {
    final response = await BackendApi.login(username, password);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', jsonDecode(response.body)['token']);
      prefs.setString('username', username);
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getToken() {
    final prefs = SharedPreferences.getInstance();
    return prefs.then((value) => value.getString('token') ?? '');
  }

  static Future<String> getUsername() {
    final prefs = SharedPreferences.getInstance();
    return prefs.then((value) => value.getString('username') ?? '');
  }

  static void logout(BuildContext? context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('username');
    if (context != null && context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/auth_gate',
        (Route<dynamic> route) => false,
      );
    }
  }
}
