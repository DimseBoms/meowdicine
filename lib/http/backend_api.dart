import 'dart:convert';

import 'package:http/http.dart' as http;

class BackendApi {
  static const String _baseUrl = 'http://localhost:5000';

  static Future<http.Response> login(String username, String password) async {
    return http.post(
      Uri.parse('$_baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );
  }

  static Future<http.Response> register(
      String username, String password) async {
    return http.post(
      Uri.parse('$_baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );
  }

  static Future<http.Response> logout(String sessionId) async {
    return http.post(
      Uri.parse('$_baseUrl/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'sessionId': sessionId}),
    );
  }

  static Future<http.Response> getAnimals(String sessionId) async {
    return http.post(
      Uri.parse('$_baseUrl/animals'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'sessionId': sessionId}),
    );
  }

  static Future<http.Response> addAnimal(
      String sessionId, String name, String species) async {
    return http.post(
      Uri.parse('$_baseUrl/addAnimal'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'sessionId': sessionId,
        'name': name,
        'species': species
      }),
    );
  }

  static Future<http.Response> deleteAnimal(
      String sessionId, String animalId) async {
    return http.post(
      Uri.parse('$_baseUrl/deleteAnimal'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'sessionId': sessionId, 'animalId': animalId}),
    );
  }

  static Future<http.Response> getMedicines(String sessionId) async {
    return http.post(
      Uri.parse('$_baseUrl/medicines'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'sessionId': sessionId}),
    );
  }
}
