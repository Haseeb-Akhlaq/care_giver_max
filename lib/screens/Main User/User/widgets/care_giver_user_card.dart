import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/Medication/manage_daily_medication_scrren.dart';
import 'package:caregiver_max/screens/Main%20User/User/Model/care_giver_user.dart';
import 'package:caregiver_max/screens/Main%20User/User/edit_user_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CareGiverUserCard extends StatefulWidget {
  final CareGiverUser? careGiverUser;
  final Function? reset;

  const CareGiverUserCard({this.careGiverUser, this.reset});

  @override
  State<CareGiverUserCard> createState() => _CareGiverUserCardState();
}

class _CareGiverUserCardState extends State<CareGiverUserCard> {
  Future<Widget> _deleteUserAlert() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          titlePadding:
              EdgeInsets.only(top: 25.0, bottom: 5.0, left: 5.0, right: 5.0),
          contentPadding:
              EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
          actionsPadding: EdgeInsets.only(top: 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          title: Center(
            child: Text(
              'Delete User',
              style: TextStyle(
                fontSize: 20.0,
                letterSpacing: 0.5,
                //fontWeight: FontWeight.bold,
                color: Color(0xFF252525),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Are you sure you want to Delete?',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF868686),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 0.5,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: TextButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('careGiverUsers')
                              .doc(widget.careGiverUser!.id)
                              .delete();

                          Navigator.pop(context);
                          widget.reset!();
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 0.5,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      widget.careGiverUser!.firstName!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Initial :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      widget.careGiverUser!.initial!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'Phone :  ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'CellPhone      : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.careGiverUser!.cellPhone!)
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          'HomePhone : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.careGiverUser!.homePhone!)
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          'WorkPhone   : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.careGiverUser!.workPhone!)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Role :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...widget.careGiverUser!.roles!.map(
                        (e) => Text(
                          e,
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  )),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employee Status :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  widget.careGiverUser!.employeeStatus == 'Active'
                      ? ActiveStatus()
                      : InActiveStatus(),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditUserScreen(
                              careGiverUser: widget.careGiverUser),
                        ),
                      );
                    },
                    child: Icon(Icons.edit, color: Colors.blue),
                  ),
                  GestureDetector(
                      onTap: () {
                        _deleteUserAlert();
                      },
                      child: Icon(Icons.delete, color: Colors.red)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
