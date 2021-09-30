import 'package:caregiver_max/providers/auth_provider.dart';
import 'package:caregiver_max/screens/Sub_User/sub_user_home_screen.dart';
import 'package:caregiver_max/screens/registration/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Main User/main_user_home_screen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  SharedPreferences? sharedPreferences;

  initializeShared() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initializeShared();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return MainUserHomeScreen();
        }
        if (sharedPreferences!.getBool('loggedIn') == null ||
            sharedPreferences!.getBool('loggedIn') == false) {
          return AuthScreen();
        } else {
          Provider.of<AuthProvider>(context, listen: false).setLoggedSubUser();
          return SubUserHomeScreen();
        }
      },
    );
  }
}
