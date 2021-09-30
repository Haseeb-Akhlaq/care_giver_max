import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/ADL%20Record/setup_adl_screen.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/Drawer/main_user_drawer.dart';
import 'package:caregiver_max/widgets/simple_appBar.dart';
import 'package:flutter/material.dart';

import 'doctors_order_screen.dart';
import 'document_upload_screen.dart';

class DoctorsOrderActionCategoryScreen extends StatefulWidget {
  final Resident? resident;
  const DoctorsOrderActionCategoryScreen({Key? key, this.resident})
      : super(key: key);

  @override
  State<DoctorsOrderActionCategoryScreen> createState() =>
      _DoctorsOrderActionCategoryScreenState();
}

class _DoctorsOrderActionCategoryScreenState
    extends State<DoctorsOrderActionCategoryScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MainUserDrawer(),
      appBar: simpleAppBar(context, title: 'Doctor\'s Order', menuTap: () {
        _scaffoldKey.currentState!.openEndDrawer();
      }),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                NameExpansionTile(resident: widget.resident),
                SizedBox(height: 15),
                Container(
                  color: AppColors.background.withOpacity(0.3),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DoctorOrdersScreen(resident: widget.resident),
                        ),
                      );
                    },
                    title: Text('Doctors Order'),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  color: AppColors.background.withOpacity(0.3),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DocumentUploadScreen(),
                        ),
                      );
                    },
                    title: Text('Document Upload'),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
