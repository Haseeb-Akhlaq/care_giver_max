import 'package:caregiver_max/screens/User/Model/care_giver_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:nanoid/async.dart';

class AddNewUserProvider extends ChangeNotifier {
  CareGiverUser? careGiverUser;

  initializeUser() {
    careGiverUser = CareGiverUser(
      firstName: '',
      ssl: '',
      employeeStatus: 'Non Active',
      dateOfBirth: '',
      homePhone: '',
      hireDate: '',
      address: '',
      workPhone: '',
      cellPhone: '',
      initial: '',
      id: '',
      lastName: '',
      middleName: '',
      propertiesIds: [],
      roles: [],
      documentName: '',
      documentLink: '',
    );
  }

  setFirstName(String value) {
    careGiverUser?.firstName = value;
  }

  setMiddleName(String value) {
    careGiverUser?.middleName = value;
  }

  setLastName(String value) {
    careGiverUser?.lastName = value;
  }

  setInitial(String value) {
    careGiverUser?.initial = value;
  }

  setAddress(String value) {
    careGiverUser?.address = value;
  }

  setCellphoneNumber(String value) {
    careGiverUser?.cellPhone = value;
  }

  setHomePhoneNumber(String value) {
    careGiverUser?.homePhone = value;
  }

  setWorkPhoneNumber(String value) {
    careGiverUser?.workPhone = value;
  }

  setHireDate(String value) {
    careGiverUser?.hireDate = value;
  }

  setSSl(String value) {
    careGiverUser?.ssl = value;
  }

  setDateOfBirth(String value) {
    careGiverUser?.dateOfBirth = value;
  }

  setEmployeeStatus(String? value) {
    careGiverUser?.employeeStatus = value;
  }

  addProperties(String propertyId) {
    careGiverUser?.propertiesIds!.add(propertyId);
    print(careGiverUser!.propertiesIds);
  }

  removeProperties(String propertyId) {
    careGiverUser?.propertiesIds!.remove(propertyId);
    print(careGiverUser!.propertiesIds);
  }

  addUserRole(String role) {
    careGiverUser?.roles!.add(role);
    print(careGiverUser!.roles);
  }

  removeUserRole(String role) {
    careGiverUser?.roles!.remove(role);
    print(careGiverUser!.roles);
  }

  setDocumentName(String name) {
    careGiverUser?.documentName = name;
  }

  setDocumentLink(String link) {
    careGiverUser?.documentLink = link;
  }

  getUser() {
    return careGiverUser;
  }

  upLoadUserToFirebase() async {
    String id = await customAlphabet('1234567890', 10);

    FirebaseFirestore.instance.collection('careGiverUsers').doc(id).set({
      'id': id,
      'firstName': careGiverUser!.firstName,
      'middleName': careGiverUser!.middleName,
      'lastName': careGiverUser!.lastName,
      'initial': careGiverUser!.initial,
      'address': careGiverUser!.address,
      'cellPhone': careGiverUser!.cellPhone,
      'homePhone': careGiverUser!.homePhone,
      'workPhone': careGiverUser!.workPhone,
      'hireDate': careGiverUser!.hireDate,
      'ssl': careGiverUser!.ssl,
      'dateOfBirth': careGiverUser!.dateOfBirth,
      'employeeStatus': careGiverUser!.employeeStatus,
      'properties': careGiverUser!.propertiesIds,
      'roles': careGiverUser!.roles,
      'documentName': careGiverUser!.documentName,
      'documentLink': careGiverUser!.documentLink,
    });
  }
}
