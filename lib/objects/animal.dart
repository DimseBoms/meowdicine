import 'package:flutter/material.dart';
import 'package:meowdicine/objects/prescription.dart';

class Animal {
  String name;
  DateTime birthday;
  String species;
  Map<DateTime, List<Prescription>> prescriptionHistory;
  List<Map<TimeOfDay, Prescription>> dailyPrescriptions;

  Animal(
      {required this.name,
      required this.birthday,
      required this.species,
      this.prescriptionHistory = const <DateTime, List<Prescription>>{},
      this.dailyPrescriptions = const <Map<TimeOfDay, Prescription>>[]});

  void setName(String name) {
    this.name = name;
  }

  void setBirthday(DateTime birthday) {
    this.birthday = birthday;
  }

  void setSpecies(String species) {
    this.species = species;
  }

  void addPrescriptionToHistory(Prescription prescription, DateTime date) {
    if (prescriptionHistory.containsKey(date)) {
      prescriptionHistory[date]!.add(prescription);
    } else {
      prescriptionHistory[date] = [prescription];
    }
  }

  void removePrescriptionFromHistory(Prescription prescription, DateTime date) {
    if (prescriptionHistory.containsKey(date)) {
      prescriptionHistory[date]!.remove(prescription);
    }
  }

  @override
  String toString() {
    return 'Animal{name: $name, birthday: $birthday, species: $species}';
  }

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
        name: json['name'],
        birthday: DateTime.parse(json['birthday']),
        species: json['species'],
        prescriptionHistory: json['prescriptionHistory'],
        dailyPrescriptions: json['dailyPrescriptions']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthday': birthday.toString(),
      'species': species,
      'prescriptionHistory': prescriptionHistory,
      'dailyPrescriptions': dailyPrescriptions
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'birthday': birthday.toString(),
      'species': species,
      'prescriptionHistory': prescriptionHistory,
      'dailyPrescriptions': dailyPrescriptions
    };
  }
}
