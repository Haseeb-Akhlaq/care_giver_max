import 'package:auto_size_text/auto_size_text.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:caregiver_max/widgets/drawer.dart';
import 'package:caregiver_max/widgets/simple_appBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SetupMedicationDetailsScreen extends StatefulWidget {
  @override
  State<SetupMedicationDetailsScreen> createState() =>
      _SetupMedicationDetailsScreenState();
}

class _SetupMedicationDetailsScreenState
    extends State<SetupMedicationDetailsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List medicationList = [
    'Generlac sol',
    'Lotrel',
    'Bhall LLC',
    'Talco House',
  ];

  var taskingTime = TimeOfDay(hour: 00, minute: 00);
  bool isPrn = false;
  String? medication;
  String? routeOfAdministration;
  String? statusDropDown;

  String? dateIssued = '';
  String? dateExpired = '';

  bool controlledMedication = false;

  selectTime(context) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppDrawer(),
      key: _scaffoldKey,
      appBar: simpleAppBar(
        context,
        title: 'Setup Medication Details',
        menuTap: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
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
                      fontSize: 18,
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
                        });
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Text('${taskingTime.format(context)}'),
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
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.3),
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
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.3),
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
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.3),
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
                      fontSize: 18,
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
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
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
              ///////////////////////////////Date Issued;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date Expire :',
                    style: TextStyle(
                      fontSize: 18,
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
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
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
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Strength';
                          }
                          return null;
                        },
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
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter RX # number';
                          }
                          return null;
                        },
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
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Direction For use';
                          }
                          return null;
                        },
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
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Pharmacy Name';
                          }
                          return null;
                        },
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
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Amount Received';
                          }
                          return null;
                        },
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
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Dosage';
                          }
                          return null;
                        },
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
                title: 'Setup Medication',
                onTap: () {
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
