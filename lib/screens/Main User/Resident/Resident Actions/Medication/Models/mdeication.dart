class Medication {
  String? id;
  String? status;
  String? time;
  String? addedBy;
  String? medication;
  String? strength;
  String? pharmacyName;
  String? routeOfAdministration;
  String? dateIssued;
  String? dateExpire;
  String? directionForUse;
  String? dosage;
  String? savedBy;
  String? amountReceived;
  String? residentId;
  String? rx;
  bool? isActive;
  bool? isPrn;
  bool? controlledMedication;

  Medication({
    this.id,
    this.status,
    this.time,
    this.routeOfAdministration,
    this.addedBy,
    this.residentId,
    this.dateExpire,
    this.dateIssued,
    this.directionForUse,
    this.dosage,
    this.medication,
    this.savedBy,
    this.strength,
    this.rx,
    this.isActive,
    this.amountReceived,
    this.isPrn,
    this.controlledMedication,
    this.pharmacyName,
  });

  Medication.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.time = map['taskingTime'];
    this.status = map['status'];
    this.addedBy = map['addedBy'];
    this.routeOfAdministration = map['routeOfAdministration'];
    this.dateIssued = map['dateIssued'];
    this.dateExpire = map['dateExpired'];
    this.medication = map['medication'];
    this.directionForUse = map['directionOfUse'];
    this.residentId = map['residentId'];
    this.rx = map['rx'];
    this.pharmacyName = map['pharmacyName'];
    this.dosage = map['dosage'];
    this.amountReceived = map['amountReceived'];
    this.savedBy = map[''] ?? '';
    this.strength = map['strength'];
    this.isActive = map['isActive'];
    this.isPrn = map['isPrn'];
    this.controlledMedication = map['isControlledMedication'];
  }
}
