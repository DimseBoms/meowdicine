import 'dart:convert';

import 'package:meowdicine/controllers/user_controller.dart';
import 'package:meowdicine/objects/animal.dart';

import '../http/backend_api.dart';

class AnimalsController {
  static Future<List<Animal>> fetchAnimals() async {
    try {
      String token = await UserController.getToken();
      String username = await UserController.getUsername();
      final response = await BackendApi.getAnimals(token, username);
      if (response.statusCode == 200) {
        final animals = jsonDecode(response.body)['animals'];
        if (animals != null) {
          return animals
              .map<Animal>((animal) => Animal.fromJson(animal))
              .toList();
        }
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> addAnimal(Animal animal) async {
    String token = await UserController.getToken();
    String username = await UserController.getUsername();
    final response = await BackendApi.addAnimal(token, username, animal);
    if (response.statusCode == 200) {
      final animal = jsonDecode(response.body)['animal'];
      if (animal != null) {
        return true;
      }
    }
    return false;
  }

  static Future<bool> updateAnimal(Animal animal) async {
    final response = await BackendApi.updateAnimal(animal);
    if (response.statusCode == 200) {
      final animal = jsonDecode(response.body)['animal'];
      if (animal != null) {
        return true;
      }
    }
    return false;
  }

  static Future<void> deleteAnimal(String token, Animal animal) async {}
}
