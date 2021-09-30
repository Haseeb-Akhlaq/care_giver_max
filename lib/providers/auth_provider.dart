import 'package:caregiver_max/screens/Main%20User/User/Model/care_giver_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  CareGiverUser? loggedSubUser;

  Future setLoggedSubUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getString('loggedUserId');

    final userData = await FirebaseFirestore.instance
        .collection('careGiverUsers')
        .doc(userId)
        .get();

    CareGiverUser loggedUser = CareGiverUser.fromMap(userData.data()!);

    loggedSubUser = loggedUser;

    print('sub user setted------------------------------------');
    print(loggedSubUser!.email);
  }

  getLoggedSubUser() {
    return loggedSubUser;
  }
}
