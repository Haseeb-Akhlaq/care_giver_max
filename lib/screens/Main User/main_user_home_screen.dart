import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/Drawer/main_user_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Resident/Resident Actions/ Comprehensive Assesment/comprehensive_assesment_screen.dart';
import 'Resident/Resident Actions/ADL Record/setup_adl_screen.dart';
import 'Resident/Resident Actions/Activity/activity_category_screen.dart';
import 'Resident/Resident Actions/DoctorsOrder/doctors_order_categagory_screen.dart';
import 'Resident/Resident Actions/Medication/medication_action_category_screen.dart';
import 'Resident/Resident Actions/ServieCare/service_care_screen.dart';
import 'Resident/ResidentDetails/resident_details_categary_screen.dart';
import 'Resident/add_new_resident_screen.dart';

class MainUserHomeScreen extends StatefulWidget {
  const MainUserHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainUserHomeScreen> createState() => _MainUserHomeScreenState();
}

class _MainUserHomeScreenState extends State<MainUserHomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  List<Resident> allResidents = [];

  Future<void> getAllResidents() async {
    allResidents = [];
    setState(() {
      isLoading = true;
    });

    final userId = FirebaseAuth.instance.currentUser!.uid;

    final allUsers = await FirebaseFirestore.instance
        .collection('residents')
        .where('addedBy', isEqualTo: userId)
        .get();

    if (allUsers.docs.length == 0) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    allUsers.docs.forEach((element) {
      print(element.data());
      allResidents.add(Resident.fromMap(element.data()));
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllResidents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MainUserDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.textLight,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddResidentScreen()));
        },
      ),
      appBar: AppBar(
        title: Text('CareGiverMax'),
        centerTitle: true,
        backgroundColor: Color(0xff788B91),
        actions: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                    'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'),
              ),
              SizedBox(width: 10),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Residents',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: getAllResidents,
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return HomeResidentTile(
                              resident: allResidents[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemCount: allResidents.length),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeResidentTile extends StatelessWidget {
  final Resident? resident;
  const HomeResidentTile({Key? key, this.resident}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background.withOpacity(0.3),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResidentDetailsCategoryScreen(
                        resident: resident,
                      )));
        },
        title: Text('${resident!.residentName} | ${resident!.propertyName}'),
        trailing: GestureDetector(
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
                                      SetupAdlScreen(resident: resident)));
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
                              builder: (context) => ServiceCareActionScreen(),
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
          child: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class DialogEntries extends StatelessWidget {
  final String? text;
  final Function? onpressed;

  const DialogEntries({this.text, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onpressed!();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.3),
            border: Border.all(
              color: Colors.white,
              width: 1,
            )),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(text!),
        ),
      ),
    );
  }
}
