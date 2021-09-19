import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/screens/Resident/ResidentDetails/PerosnalInformation/personal_information_details.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'DischargedExpired/discharged_expired_screen.dart';
import 'DocumentUpload/resident_document_upload.dart';
import 'HomeHealthAndHospice/home_health_or_hospice_screen.dart';
import 'NearestRelative/nearest_relative_guardian.dart';
import 'OtherContactsInfo/other_contact_info_screen.dart';
import 'ResidentBillingInfo/resident_billing_info.dart';

class ResidentDetailsCategoryScreen extends StatefulWidget {
  final Resident? resident;
  const ResidentDetailsCategoryScreen({Key? key, this.resident})
      : super(key: key);

  @override
  State<ResidentDetailsCategoryScreen> createState() =>
      _ResidentDetailsCategoryScreenState();
}

class _ResidentDetailsCategoryScreenState
    extends State<ResidentDetailsCategoryScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Resident Details'),
        backgroundColor: Color(0xff788B91),
        centerTitle: true,
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: AppColors.background.withOpacity(0.3),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalInformationDetails(
                            resident: widget.resident),
                      ),
                    );
                  },
                  title: Text('Personal Information'),
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
                        builder: (context) =>
                            OtherContactInfoScreen(resident: widget.resident),
                      ),
                    );
                  },
                  title: Text('Other Contact info'),
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
                        builder: (context) => ResidentDocumentUploadScreen(),
                      ),
                    );
                  },
                  title: Text('Document Upload'),
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
                        builder: (context) => HomeHealthOrHospiceScreen(
                            resident: widget.resident),
                      ),
                    );
                  },
                  title: Text('Home health or hospice'),
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
                        builder: (context) => NearestRelativeGuardianScreen(
                            resident: widget.resident),
                      ),
                    );
                  },
                  title: Text('Nearest Relative / Guardian'),
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
                        builder: (context) => DischargedExpiredScreen(),
                      ),
                    );
                  },
                  title: Text('Discharged / Expired'),
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
                        builder: (context) => ResidentBillingInfoScreen(),
                      ),
                    );
                  },
                  title: Text('Resident Billing Info'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
