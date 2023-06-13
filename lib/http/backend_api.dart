import 'dart:convert';

import 'package:http/http.dart' as http;

import '../controllers/user_controller.dart';
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

  static Future<http.Response> logout(String token, String username) async {
    return http.post(
      Uri.parse('$_baseUrl/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'token': token, 'username': username}),
    );
  }

  static Future<http.Response> getAnimals(String token, String username) async {
    return http.get(
      Uri.parse('$_baseUrl/animals?token=$token&username=$username'),
    );
  }

  static Future<http.Response> addAnimal(
      String token, String username, Animal animal) async {
    return http.post(
      Uri.parse('$_baseUrl/animals/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'token': token,
        'username': username,
        'name': animal.name,
        'species': animal.species,
        'birthday': dateTimeToDateString(animal.birthday),
      }),
    );
  }

  static Future<http.Response> updateAnimal(Animal animal) async {
    String token = await UserController.getToken();
    String username = await UserController.getUsername();
    return http.put(
      Uri.parse('$_baseUrl/animals/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'token': token,
        'username': username,
        'name': animal.name,
        'species': animal.species,
        'birthday': dateTimeToDateString(animal.birthday),
        'animalId': animal.id,
      }),
    );
  }

  static Future<http.Response> deleteAnimal(
      String token, String username, String animalId) async {
    return http.post(
      Uri.parse('$_baseUrl/deleteAnimal'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': token,
        'username': username,
        'animalId': animalId
      }),
    );
  }

  static Future<http.Response> getMedicines(
      String token, String username) async {
    return http.post(
      Uri.parse('$_baseUrl/medicines'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'token': token, 'username': username}),
    );
  }

  static String dateTimeToDateString(DateTime dateTime) {
    String year = dateTime.year.toString().padLeft(4, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
}
