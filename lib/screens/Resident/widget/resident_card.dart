import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/screens/Resident/Resident%20Actions/ADL%20Record/setup_adl_screen.dart';
import 'package:caregiver_max/screens/Resident/Resident%20Actions/Activity/activity_screen.dart';
import 'package:caregiver_max/screens/Resident/Resident%20Actions/DoctorsOrder/doctors_order_categagory_screen.dart';
import 'package:caregiver_max/screens/Resident/Resident%20Actions/Medication/medication_action_category_screen.dart';
import 'package:caregiver_max/screens/Resident/Resident%20Actions/ServieCare/service_care_screen.dart';
import 'package:caregiver_max/screens/Resident/ResidentDetails/resident_details_categary_screen.dart';
import 'package:caregiver_max/screens/Resident/edit_resident_screen.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../home_screen.dart';

class ResidentCard extends StatelessWidget {
  final Resident? resident;

  const ResidentCard({this.resident});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Property :  ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          resident!.property!,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         EditPropertyScreen(property: property),
                      //   ),
                      // );
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditResidentScreen(
                              resident: resident,
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.edit,
                        color: AppColors.background,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resident Name :  ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      resident!.residentName!,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admission Date :  ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      DateFormat.yMd()
                          .format(DateTime.parse(resident!.admissionDate!)),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admission Form :  ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      resident!.admissionForm!,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone No :  ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      resident!.telephone!,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Age :  ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      resident!.age!,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sex :  ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      resident!.sex!,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: 'Actions',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctxt) => new AlertDialog(
                            backgroundColor: Colors.grey[200],
                            title: Container(),
                            content: Container(
                              height: 280,
                              child: Column(
                                children: [
                                  DialogEntries(
                                    text: 'ADL Record',
                                    onpressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SetupAdlScreen(
                                                      resident: resident)));
                                    },
                                  ),
                                  DialogEntries(
                                    text: 'Medication',
                                    onpressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MedicationActionCategoryScreen()));
                                    },
                                  ),
                                  DialogEntries(
                                    text: 'Doctor\'s order',
                                    onpressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DoctorsOrderActionCategoryScreen()));
                                    },
                                  ),
                                  DialogEntries(
                                    text: 'Activity',
                                    onpressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ActivityActionScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  DialogEntries(
                                    text: 'Service Care',
                                    onpressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ServiceCareActionScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  DialogEntries(text: 'Comp Assessment'),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: AppButton(
                      title: 'Details',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResidentDetailsCategoryScreen(
                                      resident: resident,
                                    )));
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
