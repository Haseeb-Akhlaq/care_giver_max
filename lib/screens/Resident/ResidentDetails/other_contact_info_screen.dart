import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherContactInfoScreen extends StatefulWidget {
  const OtherContactInfoScreen({Key? key}) : super(key: key);

  @override
  State<OtherContactInfoScreen> createState() => _OtherContactInfoScreenState();
}

class _OtherContactInfoScreenState extends State<OtherContactInfoScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? propertyDropDownName;
  String? state;

  //
  String? admissionDate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Other Contact Info'),
        backgroundColor: Color(0xff788B91),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ////////////////////////////////////////////Responsible Party
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Responsible Party',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Responsible Party Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ////////////////////////////////////////////RelationShip
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RelationShip',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter RelationShip Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ////////////////////////////////////////////Address
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Address',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        maxLines: 3,
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Address';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ////////////////////////////////////////////Telephone
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Telephone',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Telephone Number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),

              PowerOfAttorneyExpansionTile(),
              SizedBox(height: 25),
              InCaseOfEmergencyExpansionTile(),
              SizedBox(height: 50),
              AppButton(
                title: 'Update',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

class PowerOfAttorneyExpansionTile extends StatefulWidget {
  const PowerOfAttorneyExpansionTile({Key? key}) : super(key: key);

  @override
  _PowerOfAttorneyExpansionTileState createState() =>
      _PowerOfAttorneyExpansionTileState();
}

class _PowerOfAttorneyExpansionTileState
    extends State<PowerOfAttorneyExpansionTile> {
  TextEditingController religionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.mainGrey,
      ),
      child: ExpansionTile(
        title: Text(
          'Power Of Attorney',
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
                ////////////////////////////////////////////Power Of Attorney
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Power Of Attorney',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onSaved: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Power Of Attorney Name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                ////////////////////////////////////////////RelationShip
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RelationShip',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onSaved: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter RelationShip Name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                ////////////////////////////////////////////Address
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          maxLines: 3,
                          onSaved: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Address';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                ////////////////////////////////////////////Telephone
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Telephone',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onSaved: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Telephone Number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InCaseOfEmergencyExpansionTile extends StatefulWidget {
  const InCaseOfEmergencyExpansionTile({Key? key}) : super(key: key);

  @override
  _InCaseOfEmergencyExpansionTileState createState() =>
      _InCaseOfEmergencyExpansionTileState();
}

class _InCaseOfEmergencyExpansionTileState
    extends State<InCaseOfEmergencyExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.mainGrey,
      ),
      child: ExpansionTile(
        title: Text(
          'In Case Of Emergency',
          style: TextStyle(
            fontSize: 16.0,
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
                ////////////////////////////////////////////Notify in case of Emergency
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notify in case of Emergency',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onSaved: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Notify in case of Emergency Name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                ////////////////////////////////////////////RelationShip
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RelationShip',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onSaved: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter RelationShip Name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                ////////////////////////////////////////////Address
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          maxLines: 3,
                          onSaved: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Address';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                ////////////////////////////////////////////Telephone
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Telephone',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onSaved: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Telephone Number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
