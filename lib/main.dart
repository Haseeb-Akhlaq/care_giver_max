import 'package:caregiver_max/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'mon',
        // textTheme: TextTheme(
        //   bodyText1: TextStyle(),
        //   bodyText2: TextStyle(),
        // ).apply(
        //   bodyColor: Colors.white,
        //   displayColor: Colors.white,
        // ),
      ),
      home: SplashScreen(),
    );
  }
}
