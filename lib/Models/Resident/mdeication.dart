class Medication {
  String? id;
  String? time;
  String? medication;
  String? strength;
  String? dateIssued;
  String? dateExpire;
  String? directionForUse;
  String? dosage;
  String? addedBy;
  String? savedBy;
  bool? isActive;

  Medication({
    this.id,
    this.addedBy,
    this.time,
    this.dateExpire,
    this.dateIssued,
    this.directionForUse,
    this.dosage,
    this.medication,
    this.savedBy,
    this.strength,
    this.isActive,
  });
}
