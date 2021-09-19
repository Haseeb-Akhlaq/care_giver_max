import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/screens/Resident/Resident%20Actions/ADL%20Record/widgets/setup_adl.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'widgets/manage_adl.dart';

class SetupAdlScreen extends StatelessWidget {
  final Resident? resident;

  const SetupAdlScreen({this.resident});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CareGiverMax'),
          backgroundColor: Color(0xff788B91),
          centerTitle: true,
          actions: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    googleSignIn.signOut();
                  },
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
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
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                NameExpansionTile(),
                SizedBox(height: 30),
                SetupADLExpansionTile(
                  resident: resident,
                ),
                SizedBox(height: 30),
                ManageDailyAdlExpansionTile(resident: resident),
              ],
            ),
          ),
        ));
  }
}

class NameExpansionTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainGrey,
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(
              'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'),
        ),
        title: Text(
          'James Armistead (click for Details)',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(14),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RESIDENT NAME : ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '         James Armistead ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'ADDRESS  : ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '         2126 Robin Rd Abilene, TX  ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'PHYSICIAN  : ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '         Dr Vince VanAcht  ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'PROPERTY : ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '         1586 Beltline Road  ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'DIAGNOSIS : ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '         Anemia Hypothyroidism  ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '         Paranoid Schizophrenia  ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '         HX: Alchol Abuse  ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '         HX: Alchol Abuse  ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
