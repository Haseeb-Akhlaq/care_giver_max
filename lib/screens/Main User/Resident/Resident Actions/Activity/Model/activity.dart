class Activity {
  String? id;
  String? date;
  String? time;
  String? madeBy;
  String? type;
  String? observation;
  String? residentId;

  Activity({
    this.observation,
    this.madeBy,
    this.date,
    this.id,
    this.time,
    this.type,
    this.residentId,
  });

  Activity.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.date = map['date'];
    this.time = map['time'];
    this.madeBy = map['madeBy'];
    this.type = map['type'];
    this.observation = map['observation'];
    this.residentId = map['residentId'];
  }
}
