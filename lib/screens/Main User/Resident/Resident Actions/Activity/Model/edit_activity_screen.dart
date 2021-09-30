import 'package:caregiver_max/widgets/Drawer/main_user_drawer.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:caregiver_max/widgets/simple_appBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'activity.dart';

class EditActivityScreen extends StatefulWidget {
  final Activity? activity;
  const EditActivityScreen({Key? key, this.activity}) : super(key: key);

  @override
  State<EditActivityScreen> createState() => _EditActivityScreenState();
}

class _EditActivityScreenState extends State<EditActivityScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var taskingTime = '12:00 AM';
  String? typeDropDown;
  String? date = '';
  TextEditingController madeBy = TextEditingController();
  TextEditingController observation = TextEditingController();

  updateActivity() async {
    if (date == '') {
      Fluttertoast.showToast(msg: 'Please Select Date');
      return;
    }
    if (typeDropDown == null) {
      Fluttertoast.showToast(msg: 'Please Select Type');
      return;
    }

    if (madeBy.text == '') {
      Fluttertoast.showToast(msg: 'Please Select Type');
      return;
    }

    FirebaseFirestore.instance
        .collection('Resident Activity')
        .doc(widget.activity!.residentId)
        .collection('activities')
        .doc(widget.activity!.id)
        .update({
      'date': date,
      'time': taskingTime,
      'madeBy': madeBy.text,
      'type': typeDropDown,
      'observation': observation.text,
    });

    Navigator.pop(context);
  }

  initialValues() {
    date = widget.activity!.date!;
    taskingTime = widget.activity!.time!;
    madeBy.text = widget.activity!.madeBy!;
    typeDropDown = widget.activity!.type!;
    observation.text = widget.activity!.observation!;
  }

  @override
  void initState() {
    super.initState();
    initialValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MainUserDrawer(),
      key: _scaffoldKey,
      appBar: simpleAppBar(
        context,
        title: 'Activity',
        menuTap: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///////////////////////////////Date;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(Duration(days: 10)),
                          lastDate: DateTime.now().add(Duration(days: 60)));

                      setState(() {
                        date = DateFormat.yMMMd().format(selectedDate!);
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
                        child: Text('$date'),
                      ),
                    ),
                  ),
                ],
              ),
              ///////////////////////////////Time;
              SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time',
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
                        initialTime: TimeOfDay(hour: 00, minute: 00),
                      );

                      if (picked != null)
                        setState(() {
                          taskingTime = picked.format(context);
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
                        child: Text(taskingTime),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////Made By;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Made By',
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
                        controller: madeBy,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////Type;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type',
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
                        hintText: typeDropDown == null ? 'Type' : typeDropDown!,
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      items: [
                        'Daily Record',
                        'Diabetic',
                        'Diagnosis',
                      ].map(
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
                            typeDropDown = val.toString();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),
              ///////////////////////////////Observation / Comment;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Observation / Comment',
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
                        controller: observation,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 55),
              AppButton(
                title: 'Update',
                onTap: () {
                  updateActivity();
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
