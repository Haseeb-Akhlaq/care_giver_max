import 'package:auto_size_text/auto_size_text.dart';
import 'package:caregiver_max/screens/Main%20User/Property/property_category_screen.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/resident_categary_screen.dart';
import 'package:caregiver_max/screens/Main%20User/User/user_category_screen.dart';
import 'package:caregiver_max/screens/landing_screen.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../screens/Main User/main_user_home_screen.dart';
import '../custom_horizantal_divider.dart';

class MainUserDrawer extends StatefulWidget {
  @override
  _MainUserDrawerState createState() => _MainUserDrawerState();
}

class _MainUserDrawerState extends State<MainUserDrawer> {
  Future<Widget> _logoutAlert() async {
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
              'Logout',
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
                'Are you sure you want to logout?',
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
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          GoogleSignIn googleSignIn = GoogleSignIn();
                          googleSignIn.signOut();

                          Navigator.pushAndRemoveUntil<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  LandingScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 0.5,
                            color: Colors.blue,
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
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16.0),
                color: AppColors.background,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Color(0xFFF7F7F7),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(0.0),
                  children: [
                    CustomHorizontalDivider(thickness: 2),
                    ListTile(
                      leading: FittedBox(
                        fit: BoxFit.cover,
                        child: Icon(
                          Icons.home,
                          color: AppColors.background,
                          size: 26,
                        ),
                      ),
                      title: AutoSizeText(
                        'Home',
                        style: TextStyle(fontSize: 18),
                        maxLines: 1,
                      ),
                      onTap: () {
                        Route route = MaterialPageRoute(
                          builder: (context) => MainUserHomeScreen(),
                        );
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                            context, route, (route) => false);
                      },
                    ),
                    CustomHorizontalDivider(thickness: 2),
                    ListTile(
                      leading: FittedBox(
                        fit: BoxFit.cover,
                        child: Icon(
                          Icons.apartment,
                          color: AppColors.background,
                          size: 26,
                        ),
                      ),
                      title: AutoSizeText(
                        'Property',
                        style: TextStyle(fontSize: 18),
                        maxLines: 1,
                      ),
                      onTap: () {
                        Route route = MaterialPageRoute(
                          builder: (context) => PropertyCategoryScreen(),
                        );
                        Navigator.pop(context);
                        Navigator.push(context, route);
                      },
                    ),
                    CustomHorizontalDivider(thickness: 2),
                    ListTile(
                      leading: FittedBox(
                        fit: BoxFit.cover,
                        child: Icon(
                          Icons.people,
                          color: AppColors.background,
                          size: 26,
                        ),
                      ),
                      title: AutoSizeText(
                        'Resident',
                        style: TextStyle(fontSize: 18),
                        maxLines: 1,
                      ),
                      onTap: () {
                        Route route = MaterialPageRoute(
                          builder: (context) => ResidentCategoryScreen(),
                        );
                        Navigator.pop(context);
                        Navigator.push(context, route);
                      },
                    ),
                    CustomHorizontalDivider(thickness: 2),
                    ListTile(
                      leading: FittedBox(
                        fit: BoxFit.cover,
                        child: Icon(
                          Icons.person,
                          color: AppColors.background,
                          size: 26,
                        ),
                      ),
                      title: AutoSizeText(
                        'User',
                        style: TextStyle(fontSize: 18),
                        maxLines: 1,
                      ),
                      onTap: () {
                        Route route = MaterialPageRoute(
                          builder: (context) => UserCategoryScreen(),
                        );
                        Navigator.pop(context);
                        Navigator.push(context, route);
                      },
                    ),
                    CustomHorizontalDivider(thickness: 2),
                    ListTile(
                      leading: FittedBox(
                        fit: BoxFit.cover,
                        child: Icon(
                          Icons.logout,
                          color: AppColors.background,
                          size: 26,
                        ),
                      ),
                      title: AutoSizeText(
                        'Logout',
                        style: TextStyle(fontSize: 18),
                        maxLines: 1,
                      ),
                      onTap: () {
                        _logoutAlert();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
