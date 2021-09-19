class Property {
  String? id;
  String? propertyName;
  String? address;
  String? city;
  String? zipCode;
  String? businessName;
  String? contactNumber;
  String? contactPerson;
  String? state;
  String? propertyStatus;

  Property({
    required this.id,
    required this.propertyName,
    required this.address,
    required this.businessName,
    required this.city,
    required this.contactNumber,
    required this.contactPerson,
    required this.propertyStatus,
    required this.zipCode,
    required this.state,
  });

  Property.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.propertyStatus = map['status'];
    this.businessName = map['businessName'];
    this.propertyName = map['propertyName'];
    this.address = map['address'];
    this.city = map['city'];
    this.state = map['state'];
    this.zipCode = map['zipCode'];
    this.contactNumber = map['contactNo'];
    this.contactPerson = map['contactPerson'];
  }
}
