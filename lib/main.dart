import 'package:caregiver_max/providers/auth_provider.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/ADL%20Record/Provider/provider.dart';
import 'package:caregiver_max/screens/Main%20User/User/Provider/add_user_provider.dart';
import 'package:caregiver_max/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => AddNewUserProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => AdlRecordProvider(),
          ),
        ],
        builder: (ctx, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'mon',
            ),
            home: SplashScreen(),
          );
        });
  }
}
