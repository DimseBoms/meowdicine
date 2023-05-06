import 'package:meowdicine/objects/prescription.dart';

class Animal {
  String name;
  DateTime birthday;
  String species;
  List<Prescription> prescriptions;
  Map<DateTime, List<Prescription>> prescriptionHistory;

  Animal(
      {required this.name,
      required this.birthday,
      required this.species,
      this.prescriptions = const <Prescription>[],
      this.prescriptionHistory = const <DateTime, List<Prescription>>{}});

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
}
