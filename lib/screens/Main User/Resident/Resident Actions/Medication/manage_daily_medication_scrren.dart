import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/Medication/Models/mdeication.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'edit_medication_screen.dart';

class ManageDailyMedicationScreen extends StatefulWidget {
  final Resident? resident;
  const ManageDailyMedicationScreen({Key? key, this.resident})
      : super(key: key);

  @override
  State<ManageDailyMedicationScreen> createState() =>
      _ManageDailyMedicationScreenState();
}

class _ManageDailyMedicationScreenState
    extends State<ManageDailyMedicationScreen> {
  List<Medication> allMedications = [];

  bool isLoading = false;

  String? statusDropDown;
  String? existingRecord;
  String? medications;

  getAllMedications() async {
    setState(() {
      isLoading = true;
    });

    final medications = await FirebaseFirestore.instance
        .collection('medication_details')
        .doc(widget.resident!.id)
        .collection('medicalRecords')
        .get();

    medications.docs.forEach((element) {
      allMedications.add(
        Medication.fromMap(element.data()),
      );
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllMedications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Manage Medication'),
        backgroundColor: Color(0xff788B91),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: SingleChildScrollView(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    ////////////////////////////////////////////Existing Record
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Existing Record',
                          style: TextStyle(
                            fontSize: 16,
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
                              hintText: existingRecord == null
                                  ? 'Record'
                                  : existingRecord!,
                            ),
                            isExpanded: true,
                            iconSize: 30.0,
                            items: ['New Record', 'All'].map(
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
                                  existingRecord = val.toString();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    ////////////////////////////////////////////Status
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 16,
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
                              hintText: statusDropDown == null
                                  ? 'Status'
                                  : statusDropDown!,
                            ),
                            isExpanded: true,
                            iconSize: 30.0,
                            items: ['Active Only', 'InActive Only', 'All'].map(
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

                    SizedBox(height: 15),
                    ////////////////////////////////////////////Medications
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Medications',
                          style: TextStyle(
                            fontSize: 16,
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
                              hintText: medications == null
                                  ? 'Medications'
                                  : medications!,
                            ),
                            isExpanded: true,
                            iconSize: 30.0,
                            items: [
                              'All Medication',
                              'PRN Only',
                              'Scheduled Only',
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
                                  medications = val.toString();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15),

                    ...allMedications.map((e) => Column(
                          children: [
                            MedicationCard(
                              medication: e,
                            ),
                            SizedBox(height: 10),
                          ],
                        )),

                    AppButton(
                      title: 'Save',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 25),

                    // Expanded(
                    //   child: ListView.separated(
                    //       itemBuilder: (context, index) {
                    //         return MedicationCard(
                    //           medication: dummyMedications[index],
                    //         );
                    //       },
                    //       separatorBuilder: (context, index) {
                    //         return SizedBox(height: 10);
                    //       },
                    //       itemCount: dummyMedications.length),
                    // ),
                  ],
                ),
        ),
      ),
    );
  }
}

class MedicationCard extends StatelessWidget {
  final Medication? medication;

  const MedicationCard({this.medication});

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
                          'Time :  ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          medication!.time!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditMedicationScreen(
                            medication: medication,
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
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medication :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      medication!.medication!,
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
                    'Strength :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      medication!.strength!,
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
                    'Date Issued:  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      medication!.dateIssued!,
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
                    'Date Expired :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      medication!.dateExpire!,
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
                    'Direction For Use :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      medication!.directionForUse!,
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
                    'Dosage :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      medication!.dosage!,
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
                    'Added By :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      medication!.addedBy!,
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
                    'Status :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  medication!.isActive! ? ActiveStatus() : InActiveStatus(),
                ],
              ),
              SizedBox(height: 15),
              ////////////////////////////////////////////Address
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
            ],
          ),
        ),
      ),
    );
  }
}

class ActiveStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Text(
          '  Active',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class InActiveStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Text(
          '  InActive',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
