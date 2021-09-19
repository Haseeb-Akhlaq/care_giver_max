class CareGiverUser {
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? initial;
  String? address;
  String? cellPhone;
  String? homePhone;
  String? workPhone;
  String? hireDate;
  String? ssl;
  String? dateOfBirth;
  String? employeeStatus;
  List<String>? propertiesIds;
  List<String>? roles;
  String? documentName;
  String? documentLink;

  CareGiverUser({
    this.id,
    this.workPhone,
    this.cellPhone,
    this.homePhone,
    this.initial,
    this.address,
    this.firstName,
    this.dateOfBirth,
    this.employeeStatus,
    this.hireDate,
    this.lastName,
    this.middleName,
    this.ssl,
    this.propertiesIds,
    this.roles,
    this.documentName,
    this.documentLink,
  });

  CareGiverUser.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.firstName = map['firstName'];
    this.middleName = map['middleName'];
    this.lastName = map['lastName'];
    this.initial = map['initial'];
    this.address = map['address'];
    this.cellPhone = map['cellPhone'];
    this.homePhone = map['homePhone'];
    this.workPhone = map['workPhone'];
    this.hireDate = map['hireDate'];
    this.ssl = map['ssl'] ?? '';
    this.dateOfBirth = map['dateOfBirth'];
    this.employeeStatus = map['employeeStatus'];
    this.propertiesIds = [...map['properties']];
    this.roles = [...map['roles'] ?? ''];
    this.documentName = map['documentName'];
    this.documentLink = map['documentLink'];
  }
}
