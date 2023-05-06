class Prescription {
  String name;
  String description;
  String dosage; // TODO: Change to Int
  String unit;
  String frequency; // TODO: Change to Int

  Prescription(
      {required this.name,
      this.description = '',
      required this.dosage,
      required this.unit,
      required this.frequency});

  void setName(String name) {
    this.name = name;
  }

  void setDescription(String description) {
    this.description = description;
  }

  void setDosage(String dosage) {
    this.dosage = dosage;
  }

  void setUnit(String unit) {
    this.unit = unit;
  }

  void setFrequency(String frequency) {
    this.frequency = frequency;
  }

  @override
  String toString() {
    return 'Prescription{name: $name, description: $description, dosage: $dosage, unit: $unit, frequency: $frequency}';
  }
}