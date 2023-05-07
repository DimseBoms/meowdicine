import 'package:flutter/material.dart';
import 'package:meowdicine/objects/prescription.dart';

class Animal {
  String name;
  DateTime birthday;
  String species;
  List<Prescription> prescriptions;
  Map<DateTime, List<Prescription>> prescriptionHistory;
  List<Map<TimeOfDay, Prescription>> dailyPrescriptions;

  Animal(
      {required this.name,
      required this.birthday,
      required this.species,
      this.prescriptions = const <Prescription>[],
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

  void addPrescription(Prescription prescription) {
    prescriptions.add(prescription);
  }

  void removePrescription(Prescription prescription) {
    prescriptions.remove(prescription);
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
        prescriptions: json['prescriptions']
            .map<Prescription>(
                (prescription) => Prescription.fromJson(prescription))
            .toList(),
        prescriptionHistory: json['prescription_history']
            .map<DateTime, List<Prescription>>((key, value) => MapEntry(
                DateTime.parse(key),
                value
                    .map<Prescription>(
                        (prescription) => Prescription.fromJson(prescription))
                    .toList())),
        dailyPrescriptions: json['daily_prescriptions']
            .map<Map<TimeOfDay, Prescription>>((key, value) => MapEntry(
                TimeOfDay.fromDateTime(DateTime.parse(key)),
                value
                    .map<Prescription>((prescription) => Prescription.fromJson(prescription))
                    .toList())));
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthday': birthday.toIso8601String(),
      'species': species,
      'prescriptions':
          prescriptions.map((prescription) => prescription.toJson()).toList(),
      'prescription_history': prescriptionHistory.map((key, value) => MapEntry(
          key.toIso8601String(),
          value.map((prescription) => prescription.toJson()).toList())),
      'daily_prescriptions': dailyPrescriptions.map((key, value) => MapEntry(
          key.toString(),
          value.map((prescription) => prescription.toJson()).toList()))
    };
  }
}
