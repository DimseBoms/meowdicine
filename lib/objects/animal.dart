import 'dart:ffi';

import 'package:meowdicine/objects/prescription.dart';

class Animal {
  String name;
  DateTime birthday;
  String species;
  List<Prescription> prescriptions;

  Animal(
    {required this.name,
    required this.birthday,
    required this.species,
    this.prescriptions = const <Prescription>[]});

  void setName(String name) {
    this.name = name;
  }

  void setBirthday(DateTime birthday) {
    this.birthday = birthday;
  }

  void setSpecies(String species) {
    this.species = species;
  }

  @override
  String toString() {
    return 'Animal{name: $name, birthday: $birthday, species: $species}';
  }
}