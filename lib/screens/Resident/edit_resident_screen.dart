import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class EditResidentScreen extends StatefulWidget {
  final Resident? resident;

  const EditResidentScreen({this.resident});

  @override
  State<EditResidentScreen> createState() => _EditResidentScreenState();
}

class _EditResidentScreenState extends State<EditResidentScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? statusDropDown;
  String? propertyDropDownName;
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
  TextEditingController religionController = TextEditingController();
  TextEditingController clergyManController = TextEditingController();
  TextEditingController churchSynagogueController = TextEditingController();
  TextEditingController telephoneReligionController = TextEditingController();
  TextEditingController addressReligionController = TextEditingController();
  TextEditingController medicareController = TextEditingController();
  TextEditingController medicaidController = TextEditingController();

  setInitialParameters() {
    statusDropDown = widget.resident!.status;
    propertyDropDownName = widget.resident!.property;

    admissionDate = widget.resident!.admissionDate;
    dateOfBirth = widget.resident!.dateOfBirth;

    admissionDateDisplay = DateFormat.yMd()
        .format(DateTime.parse(widget.resident!.admissionDate!));

    dateOfBirthDisplay =
        DateFormat.yMd().format(DateTime.parse(widget.resident!.dateOfBirth!));

    nameController.text = widget.resident!.residentName!;
    primaryLanguageController.text = widget.resident!.primaryLanguage!;
    admissionFormController.text = widget.resident!.admissionForm!;
    occupationController.text = widget.resident!.occupation!;
    placeOfBirthController.text = widget.resident!.placeOfBirth!;
    addressController.text = widget.resident!.address!;
    telephoneController.text = widget.resident!.telephone!;
    raceController.text = widget.resident!.race!;
    ageController.text = widget.resident!.age!;
    sexController.text = widget.resident!.sex!;
    martialStatusController.text = widget.resident!.martialStatus!;
    heightController.text = widget.resident!.height!;
    weightController.text = widget.resident!.weight!;
    socialSecurityController.text = widget.resident!.socialSecurity!;
    religionController.text = widget.resident!.religion!;
    clergyManController.text = widget.resident!.clergyMan!;
    churchSynagogueController.text = widget.resident!.churchSynagogue!;
    telephoneReligionController.text = widget.resident!.telephoneChurch!;
    addressReligionController.text = widget.resident!.addressChurch!;
    medicareController.text = widget.resident!.medicare!;
    medicaidController.text = widget.resident!.medicaid!;
  }

  updateResident() async {
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
      'religion': religionController.text,
      'clergyman': clergyManController.text,
      'churchSynagogue': churchSynagogueController.text,
      'telephoneChurch': telephoneReligionController.text,
      'addressChurch': addressReligionController.text,
      'medicare': medicareController.text,
      'medicaid': medicaidController.text,
    });

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    setInitialParameters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add New Resident'),
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
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Race Name';
                          }
                          return null;
                        },
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
                  'Religious',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 25),
              //////////////////////////////////////////// Religion
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Religion',
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
                        controller: religionController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Religion Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              //////////////////////////////////////////// Clergyman
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Clergyman',
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
                        controller: clergyManController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Clergyman Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),
              //////////////////////////////////////////// Church Synagogue
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Church Synagogue',
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
                        controller: churchSynagogueController,
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
              //////////////////////////////////////////// Telephone
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
                        controller: telephoneReligionController,
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
                        controller: addressReligionController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        maxLines: 3,
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
                    fontSize: 20,
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
