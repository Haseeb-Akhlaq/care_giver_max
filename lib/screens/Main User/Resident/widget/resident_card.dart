import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/%20Comprehensive%20Assesment/comprehensive_assesment_screen.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/ADL%20Record/setup_adl_screen.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/Activity/activity_category_screen.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/DoctorsOrder/doctors_order_categagory_screen.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/Medication/medication_action_category_screen.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/ServieCare/service_care_screen.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/ResidentDetails/resident_details_categary_screen.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:flutter/material.dart';

import '../../main_user_home_screen.dart';
import '../edit_resident_screen.dart';

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
                          resident!.propertyName!,
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
                      resident!.admissionDate!,
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
                                              MedicationActionCategoryScreen(
                                                  resident: resident),
                                        ),
                                      );
                                    },
                                  ),
                                  DialogEntries(
                                    text: 'Doctor\'s order',
                                    onpressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DoctorsOrderActionCategoryScreen(
                                                      resident: resident)));
                                    },
                                  ),
                                  DialogEntries(
                                    text: 'Activity',
                                    onpressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ActivityActionCategoryScreen(
                                                  resident: resident),
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
                                  DialogEntries(
                                    text: 'Comp Assessment',
                                    onpressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ComprehensiveAssessmentScreen(
                                                  resident: resident),
                                        ),
                                      );
                                    },
                                  ),
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
