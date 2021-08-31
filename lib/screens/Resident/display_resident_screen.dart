import 'package:caregiver_max/Models/resident.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';
import '../setup_adl_screen.dart';
import 'ResidentDetails/resident_details_categary_screen.dart';

class DisplayResidentsScreen extends StatefulWidget {
  const DisplayResidentsScreen({Key? key}) : super(key: key);

  @override
  State<DisplayResidentsScreen> createState() => _DisplayResidentsScreenState();
}

class _DisplayResidentsScreenState extends State<DisplayResidentsScreen> {
  List<Resident> dummyResidents = [
    Resident(
      id: '0004',
      property: '1586 Beltine Road',
      residentName: 'James',
      phone: '9086672',
      age: '60',
      statusActive: true,
      sex: 'M',
      admissionDate: '01/02/2021',
      admissionForm: '',
    ),
    Resident(
      id: '0004',
      property: '1586 Beltine Road',
      residentName: 'Mikee',
      phone: '9086dd672',
      age: '66',
      statusActive: true,
      sex: 'F',
      admissionDate: '01/02/2016',
      admissionForm: 'Baylor',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('All Residents'),
        backgroundColor: Color(0xff788B91),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ResidentCard(
                resident: dummyResidents[index],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemCount: dummyResidents.length),
      ),
    );
  }
}

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
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          resident!.property!,
                          style: TextStyle(fontSize: 16),
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
                    'Resident Name :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      resident!.residentName!,
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
                    'Admission Date :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      resident!.admissionDate!,
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
                    'Admission Form :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      resident!.admissionForm!,
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
                    'Phone No :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      resident!.phone!,
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
                    'Age :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      resident!.age!,
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
                    'Sex :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      resident!.sex!,
                      style: TextStyle(fontSize: 16),
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
                                                  SetupAdlScreen()));
                                    },
                                  ),
                                  DialogEntries(text: 'Medication'),
                                  DialogEntries(text: 'Doctor\'s order'),
                                  DialogEntries(text: 'Activity'),
                                  DialogEntries(text: 'Service Care'),
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
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ResidentDetailsCategoryScreen()));
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
