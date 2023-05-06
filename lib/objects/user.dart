import 'package:meowdicine/objects/animal.dart';

class User {
  final String name;
  final String email;
  final String password;
  List<Animal> animals = [];

  User({required this.name, required this.email, required this.password});
}
