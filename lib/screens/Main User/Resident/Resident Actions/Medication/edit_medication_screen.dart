import 'package:auto_size_text/auto_size_text.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/Medication/Models/mdeication.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:caregiver_max/widgets/simple_appBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class EditMedicationScreen extends StatefulWidget {
  final Medication? medication;
  const EditMedicationScreen({this.medication});
  @override
  State<EditMedicationScreen> createState() => _EditMedicationScreenState();
}

class _EditMedicationScreenState extends State<EditMedicationScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List medicationList = [
    'Generlac sol',
    'Lotrel',
    'Bhall LLC',
    'Talco House',
  ];

  var taskingTime = TimeOfDay(hour: 00, minute: 00);

  String? taskingTimeDisplay = '12:00 AM';
  String? medication;
  String? routeOfAdministration;
  String? statusDropDown;
  String? dateIssued = '';
  String? dateExpired = '';

  bool controlledMedication = false;
  bool isPrn = false;

  TextEditingController strengthController = TextEditingController();
  TextEditingController rxController = TextEditingController();
  TextEditingController directionForUseController = TextEditingController();
  TextEditingController pharmacyNameController = TextEditingController();
  TextEditingController amountReceivedController = TextEditingController();
  TextEditingController dosageController = TextEditingController();

  setInitialParameters() {
    taskingTimeDisplay = widget.medication!.time!;
    medication = widget.medication!.medication!;
    routeOfAdministration = widget.medication!.routeOfAdministration!;
    statusDropDown = widget.medication!.status!;
    dateIssued = widget.medication!.dateIssued!;
    dateExpired = widget.medication!.dateExpire!;
    controlledMedication = widget.medication!.controlledMedication!;
    isPrn = widget.medication!.isPrn!;
    strengthController.text = widget.medication!.strength!;
    rxController.text = widget.medication!.rx!;
    directionForUseController.text = widget.medication!.directionForUse!;
    pharmacyNameController.text = widget.medication!.pharmacyName!;
    amountReceivedController.text = widget.medication!.amountReceived!;
    dosageController.text = widget.medication!.dosage!;
  }

  updateMedicationRecord() async {
    if (statusDropDown == null) {
      Fluttertoast.showToast(msg: 'Please Select Status');
      return;
    }
    if (medication == null) {
      Fluttertoast.showToast(msg: 'Please Select Medication');
      return;
    }
    if (routeOfAdministration == null) {
      Fluttertoast.showToast(msg: 'Please Select Route of Administration');
      return;
    }
    if (dateIssued == '') {
      Fluttertoast.showToast(msg: 'Please Select Date of Issue');
      return;
    }
    if (amountReceivedController.text == '') {
      Fluttertoast.showToast(msg: 'Please Enter Amount Received');
      return;
    }

    FirebaseFirestore.instance
        .collection('medication_details')
        .doc(widget.medication!.residentId)
        .collection('medicalRecords')
        .doc(widget.medication!.id)
        .update({
      'taskingTime': taskingTime.format(context),
      'isPrn': isPrn,
      'isControlledMedication': controlledMedication,
      'status': statusDropDown,
      'medication': medication,
      'routeOfAdministration': routeOfAdministration,
      'dateIssued': dateIssued,
      'dateExpired': dateExpired,
      'strength': strengthController.text,
      'rx': rxController.text,
      'directionOfUse': directionForUseController.text,
      'pharmacyName': pharmacyNameController.text,
      'amountReceived': amountReceivedController.text,
      'dosage': dosageController.text,
      'isActive': statusDropDown == 'Active' ? true : false,
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
      appBar: simpleAppBar(
        context,
        title: 'Setup Medication Details',
        menuTap: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///////////////////////////////Tasking Time;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Taking Time',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: taskingTime,
                      );

                      if (picked != null)
                        setState(() {
                          taskingTime = picked;
                          taskingTimeDisplay = taskingTime.format(context);
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
                        child: Text(taskingTimeDisplay!),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ///////////////////////////////PRN;
              Row(
                children: [
                  Checkbox(
                      value: isPrn,
                      onChanged: (v) {
                        setState(() {
                          isPrn = v!;
                        });
                      }),
                  Text('PRN'),
                ],
              ),
              SizedBox(height: 20),

              ///////////////////////////////Status;
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
                        contentPadding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 20, right: 10),
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

              SizedBox(height: 25),

              ///////////////////////////////Medication;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medication',
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
                        hintText:
                            medication == null ? 'New Medicine' : medication!,
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      items: medicationList.map(
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
                            medication = val.toString();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),

              ///////////////////////////////Route of Administration;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Route of Administration',
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
                        hintText: routeOfAdministration == null
                            ? 'Select Method'
                            : routeOfAdministration!,
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      items: ['By Mouth', 'IM', 'Inhalation'].map(
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
                            routeOfAdministration = val.toString();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),

              ///////////////////////////////Date Issued;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date Issued : *',
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
                        dateIssued = DateFormat.yMd().format(date!);
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
                        child: Text('$dateIssued'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////Date Expire;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date Expire :',
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
                        dateExpired = DateFormat.yMd().format(date!);
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
                        child: Text('$dateExpired'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////Strength;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Strength',
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
                        controller: strengthController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////RX #;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RX #',
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
                        controller: rxController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////Direction For use;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Direction For Use',
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
                        controller: directionForUseController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////Pharmacy Name;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pharmacy Name',
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
                        controller: pharmacyNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////Amount Received;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount Received : *',
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
                        controller: amountReceivedController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////Dosage;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dosage',
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
                        controller: dosageController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////controlledMedication;
              Row(
                children: [
                  Checkbox(
                      value: controlledMedication,
                      onChanged: (v) {
                        setState(() {
                          controlledMedication = v!;
                        });
                      }),
                  AutoSizeText(
                    'Check if this a Controlled Medication',
                    maxFontSize: 15,
                    maxLines: 1,
                  ),
                ],
              ),
              SizedBox(height: 25),
              AppButton(
                title: 'Update',
                onTap: () {
                  updateMedicationRecord();
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
