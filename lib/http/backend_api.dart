import 'dart:convert';

import 'package:http/http.dart' as http;

import '../objects/animal.dart';

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

  static Future<http.Response> logout(String token) async {
    return http.post(
      Uri.parse('$_baseUrl/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'token': token}),
    );
  }

  static Future<http.Response> getAnimals(String token) async {
    return http.post(
      Uri.parse('$_baseUrl/animals'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'token': token}),
    );
  }

  static Future<http.Response> addAnimal(String token, Animal animal) async {
    print('Trying to add animal: $animal on url: $_baseUrl/animals/create');
    return http.post(
      Uri.parse('$_baseUrl/animals/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'token': token,
        'name': animal.name,
        'species': animal.species,
        'birthday': animal.birthday.toIso8601String(),
      }),
    );
  }

  static Future<http.Response> deleteAnimal(
      String token, String animalId) async {
    return http.post(
      Uri.parse('$_baseUrl/deleteAnimal'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'token': token, 'animalId': animalId}),
    );
  }

  static Future<http.Response> getMedicines(String token) async {
    return http.post(
      Uri.parse('$_baseUrl/medicines'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'token': token}),
    );
  }
}
