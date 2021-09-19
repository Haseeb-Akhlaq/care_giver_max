import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/screens/Resident/ResidentDetails/PerosnalInformation/pharmacy_expansion_tile.dart';
import 'package:caregiver_max/screens/Resident/ResidentDetails/PerosnalInformation/reiligous_expansion_tile.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'denist_expansion_tile.dart';
import 'funeral_expansion_tile.dart';
import 'hospital_expansion_tile.dart';
import 'insurance_expantion_tile.dart';
import 'physical_exam_tile.dart';
import 'physician_expantion_tile.dart';

class PersonalInformationDetails extends StatefulWidget {
  final Resident? resident;
  const PersonalInformationDetails({Key? key, this.resident}) : super(key: key);

  @override
  State<PersonalInformationDetails> createState() =>
      _PersonalInformationDetailsState();
}

class _PersonalInformationDetailsState
    extends State<PersonalInformationDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? statusDropDown;
  String? propertyDropDownName;

  //
  String? admissionDate = '';
  String? dateOfBirth = '';

  String? admissionDateDisplay = '';
  String? dateOfBirthDisplay = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController primaryLanguageController = TextEditingController();
  TextEditingController admissionFormController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController raceController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController martialStatusController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController socialSecurityController = TextEditingController();
  TextEditingController medicareController = TextEditingController();
  TextEditingController medicaidController = TextEditingController();

  setInitialValues() {
    statusDropDown = widget.resident!.status;
    propertyDropDownName = widget.resident!.property;

    admissionDate = widget.resident!.admissionDate;
    admissionDateDisplay = DateFormat.yMd()
        .format(DateTime.parse(widget.resident!.admissionDate!));

    dateOfBirth = widget.resident!.dateOfBirth;
    dateOfBirthDisplay =
        DateFormat.yMd().format(DateTime.parse(widget.resident!.dateOfBirth!));

    nameController.text = widget.resident!.residentName!;
    primaryLanguageController.text = widget.resident!.primaryLanguage!;
    admissionFormController.text = widget.resident!.admissionForm!;
    occupationController.text = widget.resident!.occupation!;
    placeOfBirthController.text = widget.resident!.placeOfBirth!;
    addressController.text = widget.resident!.address!;
    telephoneController.text = widget.resident!.telephone!;
    raceController.text = widget.resident!.telephone!;
    ageController.text = widget.resident!.age!;
    sexController.text = widget.resident!.sex!;
    martialStatusController.text = widget.resident!.martialStatus!;
    heightController.text = widget.resident!.height!;
    weightController.text = widget.resident!.weight!;
    socialSecurityController.text = widget.resident!.socialSecurity!;
    medicaidController.text = widget.resident!.medicaid!;
    medicareController.text = widget.resident!.medicare!;
  }

  //////////////////////////SETTINGS EXPANSION TILES VALUES//////////////

  //<-----------///////////Religion EXPANSION TILE//////////////----------->
  String? religion = '';
  String? clergyMan = '';
  String? churchSynagogue = '';
  String? telephoneChurch = '';
  String? addressChurch = '';

  setReligionTileValues(String rel, String clergy, String synagague,
      String telephone, String address) {
    religion = rel;
    clergyMan = clergy;
    churchSynagogue = synagague;
    telephoneChurch = telephone;
    addressChurch = address;
  }

  //<-----------///////////Religion EXPANSION TILE//////////////----------->

  //<-----------///////////INSURANCE EXPANSION TILE//////////////----------->
  String? insurance = '';
  String? insurancePolicy = '';
  String? insuranceGroup = '';
  String? telephoneInsurance = '';
  String? addressInsurance = '';
  String? insuranceGroupNo = '';

  setInsuranceTileValues(String insu, String policy, String group,
      String telephone, String address, String groupNo) {
    insurance = insu;
    insurancePolicy = policy;
    insuranceGroup = group;
    telephoneInsurance = telephone;
    addressInsurance = address;
    insuranceGroupNo = groupNo;
  }

  //<-----------///////////INSURANCE EXPANSION TILE//////////////----------->

  //<-----------///////////Hospital EXPANSION TILE//////////////----------->
  String? hospitalPreference = '';
  String? hospitalTelephone = '';
  String? hospitalEmail = '';

  setHospitalTileValues(String preference, String telephone, String email) {
    hospitalPreference = preference;
    hospitalTelephone = telephone;
    hospitalEmail = email;

    print(hospitalPreference);
  }
  //<-----------///////////Hospital EXPANSION TILE//////////////----------->

  //<-----------///////////Funeral Tile//////////////----------->
  String? funeralHomePreference = '';
  String? funeralTelephone = '';

  setFuneralTileValues(String preference, String telephone) {
    funeralHomePreference = preference;
    funeralTelephone = telephone;
  }
  //<-----------///////////Funeral Tile//////////////----------->

  //<-----------///////////pharmacyTile//////////////----------->
  String? pharmacyPreference = '';
  String? pharmacyTelephone = '';

  setPharmacyTileValues(String preference, String telephone) {
    pharmacyPreference = preference;
    pharmacyTelephone = telephone;
  }
  //<-----------///////////pharmacy Tile//////////////----------->

  //<-----------///////////dentist Tile//////////////----------->
  String? dentist = '';
  String? dentistTelephone = '';

  setDentistTileValues(String den, String telephone) {
    dentist = den;
    dentistTelephone = telephone;
  }

  //<-----------///////////dentist Tile//////////////----------->
  //<-----------///////////physician Tile//////////////----------->
  String? physician = '';
  String? physicianAddress = '';
  String? physicianTelephone = '';

  setPhysicianTileValues(String name, String address, String telephone) {
    physician = name;
    physicianAddress = address;
    physicianTelephone = telephone;
  }

  //<-----------////////// physician Tile//////////////----------->
  //<-----------///////////Physical Exam Tile//////////////----------->
  String? dateOfLastPhysicalExam = '';
  String? physicalExamYearlyPhysicalDue = '';
  String? physicalExamDiagnosis = '';
  String? physicalExamAllergies = '';

  setPhysicalExamTileValues(String lastPhysicalExam, String yearlyDue,
      String diagnosis, String allergies) {
    dateOfLastPhysicalExam = lastPhysicalExam;
    physicalExamYearlyPhysicalDue = yearlyDue;
    physicalExamDiagnosis = diagnosis;
    physicalExamAllergies = allergies;
  }
  //<-----------////////// Physical Exam Tile//////////////----------->

  updateResident() {
    if (statusDropDown == null) {
      Fluttertoast.showToast(msg: 'Please Select Status');
      return;
    }

    if (propertyDropDownName == null) {
      Fluttertoast.showToast(msg: 'Please Select Property');
      return;
    }

    if (nameController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Resident Name');
      return;
    }

    FirebaseFirestore.instance
        .collection('residents')
        .doc(widget.resident!.id)
        .update({
      'status': statusDropDown,
      'property': propertyDropDownName,
      'name': nameController.text,
      'admissionDate': admissionDate,
      'primaryLanguage': primaryLanguageController.text,
      'admissionForm': admissionFormController.text,
      'occupation': occupationController.text,
      'placeOfBirth': placeOfBirthController.text,
      'address': addressController.text,
      'telephone': telephoneController.text,
      'race': raceController.text,
      'age': ageController.text,
      'dateOfBirth': dateOfBirth,
      'sex': sexController.text,
      'martialStatus': martialStatusController.text,
      'height': heightController.text,
      'weight': weightController.text,
      'socialSecurity': socialSecurityController.text,
      'religion': religion,
      'clergyman': clergyMan,
      'churchSynagogue': churchSynagogue,
      'telephoneChurch': telephoneChurch,
      'addressChurch': addressChurch,
      'medicare': medicareController.text,
      'medicaid': medicaidController.text,
      'insurance': insurance,
      'insurancePolicy': insurancePolicy,
      'insuranceGroup': insuranceGroup,
      'insuranceTelephone': telephoneInsurance,
      'insuranceAddress': addressInsurance,
      'insuranceGroupNo': insuranceGroupNo,
      'hospitalPreference': hospitalPreference,
      'hospitalTelephone': hospitalTelephone,
      'hospitalEmail': hospitalEmail,
      'funeralHomePreference': funeralHomePreference,
      'funeralTelephone': funeralTelephone,
      'pharmacyPreference': pharmacyPreference,
      'pharmacyTelephone': pharmacyTelephone,
      'dentist': dentist,
      'dentistTelephone': dentistTelephone,
      'physician': physician,
      'physicianAddress': physicianAddress,
      'physicianTelephone': physicianTelephone,
      'dateOfLastPhysicalExam': dateOfLastPhysicalExam,
      'physicalExamYearlyPhysicalDue': physicalExamYearlyPhysicalDue,
      'physicalExamDiagnosis': physicalExamDiagnosis,
      'physicalExamAllergies': physicalExamAllergies,
    });

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    setInitialValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Person Information'),
        backgroundColor: Color(0xff788B91),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20, right: 10),
                        focusColor: Theme.of(context).primaryColor,
                        hintText:
                            statusDropDown == null ? 'Status' : statusDropDown!,
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      items: ['Active', 'Non Active'].map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(
                          () {
                            statusDropDown = val.toString();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              ////////////////////////////////////////////Status
              SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Property',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20, right: 10),
                        focusColor: Theme.of(context).primaryColor,
                        hintText: propertyDropDownName == null
                            ? 'Property'
                            : propertyDropDownName!,
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      items: [
                        'Family Choice',
                        'RNC Data',
                        'Bhall LLC',
                        'Talco House',
                      ].map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(
                          () {
                            propertyDropDownName = val.toString();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              ////////////////////////////////////////////Property
              SizedBox(height: 20),
              ////////////////////////////////////////////Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),
              ////////////////////////////////////////////Admission Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admission Date',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(Duration(days: 10)),
                          lastDate: DateTime.now().add(Duration(days: 60)));

                      setState(() {
                        admissionDate = date.toString();
                        admissionDateDisplay = DateFormat.yMd().format(date!);
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Text('$admissionDateDisplay'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ////////////////////////////////////////////Primary Language
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Primary Language',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: primaryLanguageController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Language Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ////////////////////////////////////////////Admission Form
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admission Form',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Admission Form Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),

              ////////////////////////////////////////////Occupation
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Occupation',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: occupationController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Occupation Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),

              ////////////////////////////////////////////Place of Birth
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Place of birth',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: placeOfBirthController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Place of birth Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ////////////////////////////////////////////Address
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Address',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        maxLines: 3,
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Address';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ////////////////////////////////////////////Telephone
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Telephone',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: telephoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),

              ////////////////////////////////////////////Race
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Race',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: raceController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),
              ////////////////////////////////////////////Age
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Age',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Telephone Number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ////////////////////////////////////////////Date of birth
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date of Birth',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2030));

                      setState(() {
                        dateOfBirth = date.toString();
                        dateOfBirthDisplay = DateFormat.yMd().format(date!);
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Text('$dateOfBirthDisplay'),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),

              ////////////////////////////////////////////Sex
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sex',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: sexController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              //////////////////////////////////////////// Martial Status
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Martial Status',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: martialStatusController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),

              ////////////////////////////////////////////Height
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Height',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Height';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),

              ////////////////////////////////////////////Weight
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weight',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Weight';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              //////////////////////////////////////////// Social Security
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Social Security',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: socialSecurityController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Social Security';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Container(
                width: double.infinity,
                child: Text(
                  'Medication',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 25),
              //////////////////////////////////////////// Medicare
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medicare',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: medicareController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Medicare';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              //////////////////////////////////////////// Medicaid
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medicaid',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextFormField(
                        controller: medicaidController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ReligiousExpansionTile(
                resident: widget.resident,
                setReligionTileValues: setReligionTileValues,
              ),
              SizedBox(height: 25),
              InsuranceExpansionTile(
                  resident: widget.resident,
                  setInsuranceTileValues: setInsuranceTileValues),
              SizedBox(height: 25),
              HospitalExpansionTile(
                  resident: widget.resident,
                  setHospitalTileValues: setHospitalTileValues),
              SizedBox(height: 25),
              FuneralExpansionTile(
                resident: widget.resident,
                setFuneralTileValues: setFuneralTileValues,
              ),
              SizedBox(height: 25),
              PharmacyExpansionTile(
                  resident: widget.resident,
                  setPharmacyTileValues: setPharmacyTileValues),
              SizedBox(height: 25),
              DentistExpansionTile(
                  resident: widget.resident,
                  setDentistTileValues: setDentistTileValues),
              SizedBox(height: 25),
              PhysicianExpansionTile(
                resident: widget.resident,
                setPhysicianTileValues: setPhysicianTileValues,
              ),
              SizedBox(height: 25),
              PhysicalExamExpansionTile(
                resident: widget.resident,
                setPhysicalExamTileValues: setPhysicalExamTileValues,
              ),
              SizedBox(height: 50),
              AppButton(
                title: 'Update',
                onTap: () {
                  updateResident();
                },
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
