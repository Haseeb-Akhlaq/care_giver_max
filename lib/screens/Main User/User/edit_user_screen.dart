import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:caregiver_max/Models/property.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:caregiver_max/widgets/error_snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'Model/care_giver_user.dart';
import 'Provider/add_user_provider.dart';

class EditUserScreen extends StatefulWidget {
  final CareGiverUser? careGiverUser;

  const EditUserScreen({this.careGiverUser});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Provider.of<AddNewUserProvider>(context, listen: false)
        .initializeForEdit(widget.careGiverUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit User'),
        backgroundColor: Color(0xff788B91),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DetailsExpansionTile(careGiverUser: widget.careGiverUser),
              SizedBox(height: 25),
              PropertyExpansionTile(careGiverUser: widget.careGiverUser),
              SizedBox(height: 25),
              RoleExpansionTile(careGiverUser: widget.careGiverUser),
              SizedBox(height: 25),
              DocumentUploadExpansionTile(),
              SizedBox(height: 50),
              AppButton(
                title: 'Done',
                onTap: () {
                  final CareGiverUser initialedUser =
                      Provider.of<AddNewUserProvider>(context, listen: false)
                          .getUser();

                  if (initialedUser.firstName == '') {
                    Fluttertoast.showToast(msg: 'Please Enter First Name');
                    return;
                  }

                  if (initialedUser.lastName == '') {
                    Fluttertoast.showToast(msg: 'Please Enter Last Name');
                    return;
                  }
                  if (initialedUser.email == '') {
                    Fluttertoast.showToast(msg: 'Please Enter Email');
                    return;
                  }
                  if (!(initialedUser.email!.contains('@'))) {
                    Fluttertoast.showToast(msg: 'Please Enter Valid Email');
                    return;
                  }
                  if (initialedUser.password == '') {
                    Fluttertoast.showToast(msg: 'Please Enter Password');
                    return;
                  }
                  if (initialedUser.initial == '') {
                    Fluttertoast.showToast(msg: 'Please Enter Initial');
                    return;
                  }
                  if (initialedUser.propertiesIds!.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please Select the Property');
                    return;
                  }
                  if (initialedUser.roles!.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Please Select Any Role For User');
                    return;
                  }
                  Provider.of<AddNewUserProvider>(context, listen: false)
                      .editUserFirebase(widget.careGiverUser!.id!);
                  Navigator.pop(context);
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

class DetailsExpansionTile extends StatefulWidget {
  final CareGiverUser? careGiverUser;

  const DetailsExpansionTile({Key? key, this.careGiverUser}) : super(key: key);

  @override
  _DetailsExpansionTileState createState() => _DetailsExpansionTileState();
}

class _DetailsExpansionTileState extends State<DetailsExpansionTile> {
  TextEditingController religionController = TextEditingController();

  String? hireDate = '';
  String? dateOfBirth = '';
  String? employeeStatusDropDown;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController initialController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController cellPhoneController = TextEditingController();
  TextEditingController homePhoneController = TextEditingController();
  TextEditingController workPhoneController = TextEditingController();

  TextEditingController sslController = TextEditingController();

  setInitialValues() {
    hireDate = widget.careGiverUser!.hireDate;
    dateOfBirth = widget.careGiverUser!.dateOfBirth;
    employeeStatusDropDown = widget.careGiverUser!.employeeStatus;

    firstNameController.text = widget.careGiverUser!.firstName!;
    secondNameController.text = widget.careGiverUser!.middleName!;
    lastNameController.text = widget.careGiverUser!.lastName!;
    emailController.text = widget.careGiverUser!.email!;
    passwordController.text = widget.careGiverUser!.password!;
    initialController.text = widget.careGiverUser!.initial!;
    addressController.text = widget.careGiverUser!.address!;
    cellPhoneController.text = widget.careGiverUser!.cellPhone!;
    homePhoneController.text = widget.careGiverUser!.homePhone!;
    workPhoneController.text = widget.careGiverUser!.workPhone!;
    sslController.text = widget.careGiverUser!.ssl!;
  }

  @override
  void initState() {
    setInitialValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.mainGrey.withOpacity(0.3),
      ),
      child: ExpansionTile(
        title: Text(
          ' Details',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(14),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ////////////////////////////////////////////First Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'First Name *',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: firstNameController,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            Provider.of<AddNewUserProvider>(context,
                                    listen: false)
                                .setFirstName(v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ////////////////////////////////////////////Middle Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Middle Name',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: secondNameController,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            Provider.of<AddNewUserProvider>(context,
                                    listen: false)
                                .setMiddleName(v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),
                ////////////////////////////////////////////Last Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Name *',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: lastNameController,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            Provider.of<AddNewUserProvider>(context,
                                    listen: false)
                                .setLastName(v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ////////////////////////////////////////////Email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email *',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            Provider.of<AddNewUserProvider>(context,
                                    listen: false)
                                .setEmail(v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ////////////////////////////////////////////Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password *',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            Provider.of<AddNewUserProvider>(context,
                                    listen: false)
                                .setPassword(v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ////////////////////////////////////////////Initial
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Initial *',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: initialController,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            Provider.of<AddNewUserProvider>(context,
                                    listen: false)
                                .setInitial(v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
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
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: addressController,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                          maxLines: 3,
                          onChanged: (v) {
                            Provider.of<AddNewUserProvider>(context,
                                    listen: false)
                                .setAddress(v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),
                ////////////////////////////////////////////Cellphone
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CellPhone',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: cellPhoneController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            Provider.of<AddNewUserProvider>(context,
                                    listen: false)
                                .setCellphoneNumber(v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ////////////////////////////////////////////HomePhone
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HomePhone',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: homePhoneController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            Provider.of<AddNewUserProvider>(context,
                                    listen: false)
                                .setHomePhoneNumber(v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ////////////////////////////////////////////WorkPhone
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WorkPhone',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: workPhoneController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            Provider.of<AddNewUserProvider>(context,
                                    listen: false)
                                .setHomePhoneNumber(v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ////////////////////////////////////////////Hire Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hire Date',
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

                        Provider.of<AddNewUserProvider>(context, listen: false)
                            .setHireDate(date.toString());

                        setState(() {
                          hireDate = DateFormat.yMd().format(date!);
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Text('$hireDate'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ////////////////////////////////////////////SSL
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SSL',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: sslController,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            Provider.of<AddNewUserProvider>(context,
                                    listen: false)
                                .setSSl(v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ////////////////////////////////////////////Date Of Birth
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date Of Birth',
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

                        Provider.of<AddNewUserProvider>(context, listen: false)
                            .setDateOfBirth(date.toString());

                        setState(() {
                          dateOfBirth = DateFormat.yMd().format(date!);
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Text('$dateOfBirth'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ///////////////////////////////////////////Employee Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Employee Status',
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
                          contentPadding: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 20, right: 10),
                          focusColor: Theme.of(context).primaryColor,
                          hintText: employeeStatusDropDown == null
                              ? 'Status'
                              : employeeStatusDropDown!,
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
                          setState(
                            () {
                              employeeStatusDropDown = val.toString();
                            },
                          );
                          Provider.of<AddNewUserProvider>(context,
                                  listen: false)
                              .setEmployeeStatus(employeeStatusDropDown);
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PropertyExpansionTile extends StatefulWidget {
  final CareGiverUser? careGiverUser;

  const PropertyExpansionTile({this.careGiverUser});
  @override
  State<PropertyExpansionTile> createState() => _PropertyExpansionTileState();
}

class _PropertyExpansionTileState extends State<PropertyExpansionTile> {
  List<bool> selectedProperties = [];

  List<Property> properties = [];

  generateParallelBoolList() {
    selectedProperties = List.generate(properties.length, (index) => false);

    widget.careGiverUser!.propertiesIds!.forEach((element) {
      int index = properties.indexWhere((property) => property.id == element);
      selectedProperties[index] = true;
    });

    setState(() {});
  }

  getUserProperties() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final allProperties = await FirebaseFirestore.instance
        .collection('properties')
        .where('addedBy', isEqualTo: userId)
        .get();

    allProperties.docs.forEach((element) {
      properties.add(Property.fromMap(element.data()));
    });

    generateParallelBoolList();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.mainGrey.withOpacity(0.3),
      ),
      child: ExpansionTile(
        title: Text(
          'Property *',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          ...properties.map(
            (e) => Row(
              children: [
                Checkbox(
                    value: selectedProperties[properties.indexOf(e)],
                    onChanged: (v) {
                      setState(() {
                        selectedProperties[properties.indexOf(e)] =
                            !selectedProperties[properties.indexOf(e)];
                      });

                      if (v == true) {
                        Provider.of<AddNewUserProvider>(context, listen: false)
                            .addProperties(e.id!);
                      } else {
                        Provider.of<AddNewUserProvider>(context, listen: false)
                            .removeProperties(e.id!);
                      }
                    }),
                Text(e.propertyName!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoleExpansionTile extends StatefulWidget {
  final CareGiverUser? careGiverUser;
  const RoleExpansionTile({this.careGiverUser});

  @override
  State<RoleExpansionTile> createState() => _RoleExpansionTileState();
}

class _RoleExpansionTileState extends State<RoleExpansionTile> {
  List<bool> selectedRoles = [];

  final List roles = [
    'Care giver',
    'Doctor',
    'Office Admin',
    'Pharmacist',
    'Nurse',
  ];

  generateParallelBoolList() {
    selectedRoles = List.generate(roles.length, (index) => false);

    widget.careGiverUser!.roles!.forEach((element) {
      int index = roles.indexOf(element);
      selectedRoles[index] = true;
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    generateParallelBoolList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.mainGrey.withOpacity(0.3),
      ),
      child: ExpansionTile(
        title: Text(
          ' Role *',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          ...roles.map(
            (e) => Row(
              children: [
                Checkbox(
                    value: selectedRoles[roles.indexOf(e)],
                    onChanged: (v) {
                      setState(() {
                        selectedRoles[roles.indexOf(e)] =
                            !selectedRoles[roles.indexOf(e)];
                      });

                      if (v == true) {
                        Provider.of<AddNewUserProvider>(context, listen: false)
                            .addUserRole(e);
                      } else {
                        Provider.of<AddNewUserProvider>(context, listen: false)
                            .removeUserRole(e);
                      }
                    }),
                Text(e),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DocumentUploadExpansionTile extends StatefulWidget {
  @override
  State<DocumentUploadExpansionTile> createState() =>
      _DocumentUploadExpansionTileState();
}

class _DocumentUploadExpansionTileState
    extends State<DocumentUploadExpansionTile> {
  bool isLoading = false;
  File? file;
  FilePickerResult? result;

  pickFile(BuildContext context) async {
    result = await FilePicker.platform.pickFiles();

    print(result);

    try {
      if (result != null) {
        file = File(result!.files.single.path);

        print('working');

        setState(() {
          isLoading = true;
        });

        final firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('userDocuments/${result!.files.single.path}');

        print('working2');

        final uploadTask = firebaseStorageRef.putFile(file!);

        final taskSnapshot =
            await uploadTask.whenComplete(() => print('Document uploaded'));

        taskSnapshot.ref.getDownloadURL().then(
          (value) {
            setState(() {
              print("Done: $value");
              file = File(result!.files.single.path);
            });
            Provider.of<AddNewUserProvider>(context, listen: false)
                .setDocumentLink(value);
            Provider.of<AddNewUserProvider>(context, listen: false)
                .setDocumentName(result!.files.single.path);
            isLoading = false;
          },
        );
      } else {
        showErrorSnackBar(context, 'User cancelled the picker');
      }
    } catch (e) {
      print('error occureed------------------------');
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.mainGrey.withOpacity(0.3),
      ),
      child: ExpansionTile(
        title: Text(
          'Document Upload',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose File *',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 25),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  pickFile(context);
                                },
                                icon: Icon(Icons.upload_file),
                                label: Text('Choose File:  '),
                              ),
                              SizedBox(height: 10),
                              AutoSizeText(
                                file == null
                                    ? 'No file Chosen'
                                    : '${result!.files.first.name}',
                                maxLines: 1,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
