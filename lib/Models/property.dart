class Property {
  String? id;
  String? address;
  String? city;
  String? zipCode;
  String? businessName;
  String? contactNumber;
  String? contactPerson;
  String? state;
  bool? statusActive;

  Property({
    required this.id,
    required this.address,
    required this.businessName,
    required this.city,
    required this.contactNumber,
    required this.contactPerson,
    required this.statusActive,
    required this.zipCode,
    required this.state,
  });
}
