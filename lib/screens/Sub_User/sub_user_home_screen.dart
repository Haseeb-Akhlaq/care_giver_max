import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/providers/auth_provider.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/%20Comprehensive%20Assesment/comprehensive_assesment_screen.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/ADL%20Record/setup_adl_screen.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/Activity/activity_category_screen.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/DoctorsOrder/doctors_order_categagory_screen.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/Medication/medication_action_category_screen.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/ServieCare/service_care_screen.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/ResidentDetails/resident_details_categary_screen.dart';
import 'package:caregiver_max/screens/Main%20User/User/Model/care_giver_user.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/Drawer/sub_user_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Resident/sub_user_add_new_resident.dart';

class SubUserHomeScreen extends StatefulWidget {
  const SubUserHomeScreen({Key? key}) : super(key: key);

  @override
  State<SubUserHomeScreen> createState() => _SubUserHomeScreenState();
}

class _SubUserHomeScreenState extends State<SubUserHomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  List<Resident> allResidents = [];

  Future<void> getAllResidents() async {
    print('Displaying All residents of Sub User');
    allResidents = [];

    CareGiverUser loggedInUser =
        Provider.of<AuthProvider>(context, listen: false).getLoggedSubUser();

    print('properties');
    print(loggedInUser.propertiesIds);

    setState(() {
      isLoading = true;
    });

    final allUsers = await FirebaseFirestore.instance
        .collection('residents')
        .where('addedBy', isEqualTo: loggedInUser.addedBy)
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

    List<Resident> usersResidents = [];

    //CHECKING IF THE RESIDENT CONTAIN THE SAME PROPERTY AS THE USER
    loggedInUser.propertiesIds!.forEach((propertyId) {
      allResidents.forEach((resident) {
        if (resident.propertyId == propertyId) {
          usersResidents.add(resident);
        }
      });
    });

    allResidents = usersResidents;

    setState(() {
      isLoading = false;
    });
  }

  setUser() async {
    await Provider.of<AuthProvider>(context, listen: false).setLoggedSubUser();
    getAllResidents();
  }

  @override
  void initState() {
    super.initState();
    setUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SubUserDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.textLight,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SubUserAddResidentScreen()));
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
