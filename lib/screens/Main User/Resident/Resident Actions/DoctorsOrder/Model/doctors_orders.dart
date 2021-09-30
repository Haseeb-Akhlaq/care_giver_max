class DoctorsOrder {
  String? id;
  String? date;
  String? mr;
  String? physician;
  String? clinicalFindings;
  String? order;
  bool? sn;
  bool? hha;
  bool? pt;
  bool? msw;
  bool? patient;
  bool? other;
  String? otherText;

  DoctorsOrder({
    this.date,
    this.id,
    this.physician,
    this.clinicalFindings,
    this.hha,
    this.mr,
    this.msw,
    this.order,
    this.other,
    this.patient,
    this.pt,
    this.sn,
    this.otherText,
  });

  DoctorsOrder.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.date = map['date'];
    this.mr = map['mr'];
    this.physician = map['physician'];
    this.clinicalFindings = map['clinicalFinding'];
    this.order = map['order'];
    this.sn = map['sn'];
    this.hha = map['hha'];
    this.pt = map['pt'];
    this.patient = map['patient'];
    this.msw = map['msw'];
    this.other = map['other'];
    this.otherText = map['otherText'];
  }
}
