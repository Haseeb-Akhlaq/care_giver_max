import 'package:caregiver_max/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SetupAdlScreen extends StatelessWidget {
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
                SetupADLExpansionTile(),
                SizedBox(height: 30),
                ManageDailyAdlExpansionTile(),
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

class ManageDailyAdlExpansionTile extends StatefulWidget {
  @override
  _ManageDailyAdlExpansionTileState createState() =>
      _ManageDailyAdlExpansionTileState();
}

class _ManageDailyAdlExpansionTileState
    extends State<ManageDailyAdlExpansionTile> {
  String? headerDropDown;
  String? bowelMovement;

  List switchOptions = [
    'Shower',
    'Sponge Bath',
    'Mid Morning snack',
    'Mid afternoon Snack',
    'Brush Teeth',
    'Bowel Movement',
    'Denture Care',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainGrey,
      ),
      child: ExpansionTile(
        leading: Icon(Icons.border_horizontal_rounded),
        title: Text(
          'Manage Daily ADL',
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
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                top: 10.0, bottom: 10.0, left: 20),
                            focusColor: Theme.of(context).primaryColor,
                            hintText: headerDropDown == null
                                ? 'New Record'
                                : headerDropDown!,
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          items: ['A', 'B', 'C', 'D'].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                headerDropDown = val.toString();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.save,
                      size: 50,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'ADL Record',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  color: Colors.blue.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bowel Movements',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, left: 20),
                              focusColor: Theme.of(context).primaryColor,
                              hintText: bowelMovement == null
                                  ? 'Small / Medium / Large'
                                  : bowelMovement!,
                            ),
                            isExpanded: true,
                            iconSize: 30.0,
                            items: ['A', 'B', 'C', 'D'].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  headerDropDown = val.toString();
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: TextFormField(
                              maxLines: 4,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Remark',
                              ),
                              onSaved: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter first name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Evening Care',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      ...switchOptions.map((e) => Column(
                            children: [
                              ManageDailyADLSwitches(text: e),
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SetupADLExpansionTile extends StatefulWidget {
  @override
  _SetupADLExpansionTileState createState() => _SetupADLExpansionTileState();
}

class _SetupADLExpansionTileState extends State<SetupADLExpansionTile> {
  String? headerDropDown;

  List dropDownsOptions = [
    'Shower',
    'Sponge Bath',
    'Mid Morning snack',
    'Mid afternoon Snack',
    'Brush Teeth',
    'Bowel Movement',
    'Denture Care',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainGrey,
      ),
      child: ExpansionTile(
        leading: Icon(Icons.menu),
        title: Text(
          'Setup ADL',
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
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                top: 13.0, bottom: 13.0, left: 20),
                            focusColor: Theme.of(context).primaryColor,
                            hintText: headerDropDown == null
                                ? 'Header DropdownList'
                                : headerDropDown!,
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          items: ['A', 'B', 'C', 'D'].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                headerDropDown = val.toString();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.save,
                      size: 50,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ...dropDownsOptions.map((e) => Column(
                      children: [
                        AdlCheckBoxes(text: e),
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AdlCheckBoxes extends StatefulWidget {
  final String? text;
  const AdlCheckBoxes({this.text});

  @override
  _AdlCheckBoxesState createState() => _AdlCheckBoxesState();
}

class _AdlCheckBoxesState extends State<AdlCheckBoxes> {
  bool? checkbox = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: checkbox,
            onChanged: (v) {
              setState(() {
                checkbox = v;
              });
            },
          ),
          Text(
            widget.text!,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}

class ManageDailyADLSwitches extends StatefulWidget {
  final String? text;
  const ManageDailyADLSwitches({this.text});

  @override
  _ManageDailyADLSwitchesState createState() => _ManageDailyADLSwitchesState();
}

class _ManageDailyADLSwitchesState extends State<ManageDailyADLSwitches> {
  bool? switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text!,
            style: TextStyle(fontSize: 18),
          ),
          Switch(
            activeColor: AppColors.background,
            inactiveThumbColor: Colors.white,
            value: switchValue!,
            onChanged: (v) {
              setState(() {
                switchValue = v;
              });
            },
          )
        ],
      ),
    );
  }
}
