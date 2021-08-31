import 'package:auto_size_text/auto_size_text.dart';
import 'package:caregiver_max/screens/Resident/ResidentDetails/personal_information_details.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'other_contact_info_screen.dart';

class ResidentDetailsCategoryScreen extends StatefulWidget {
  const ResidentDetailsCategoryScreen({Key? key}) : super(key: key);

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
                        builder: (context) => PersonalInformationDetails(),
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
                        builder: (context) => OtherContactInfoScreen(),
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => OtherContactInfoScreen(),
                    //   ),
                    // );
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => OtherContactInfoScreen(),
                    //   ),
                    // );
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => OtherContactInfoScreen(),
                    //   ),
                    // );
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => OtherContactInfoScreen(),
                    //   ),
                    // );
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => OtherContactInfoScreen(),
                    //   ),
                    // );
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

class CategoryItem extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Function? onTap;

  const CategoryItem({this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Container(
            width: width * 0.65,
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 60,
                ),
                SizedBox(height: 20),
                AutoSizeText(
                  text!,
                  maxLines: 1,
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
