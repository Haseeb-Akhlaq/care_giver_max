import 'package:auto_size_text/auto_size_text.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/Drawer/main_user_drawer.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:caregiver_max/widgets/simple_appBar.dart';
import 'package:flutter/material.dart';

class ServiceCareActionScreen extends StatefulWidget {
  @override
  State<ServiceCareActionScreen> createState() =>
      _ServiceCareActionScreenState();
}

class _ServiceCareActionScreenState extends State<ServiceCareActionScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? existingRecord = 'New Record';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MainUserDrawer(),
      appBar: simpleAppBar(context, title: 'Service Care Plan Assessment',
          menuTap: () {
        _scaffoldKey.currentState!.openEndDrawer();
      }),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Container(
          width: double.infinity,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Existing Record',
                    style: TextStyle(
                      fontSize: 16,
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
                            top: 10.0, bottom: 10.0, left: 20, right: 10),
                        focusColor: Theme.of(context).primaryColor,
                        hintText:
                            existingRecord == null ? 'Record' : existingRecord!,
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      items: ['New Record'].map(
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
                            existingRecord = val.toString();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Section1(),
              SizedBox(height: 20),
              Section2(),
              SizedBox(height: 20),
              Section3(),
              SizedBox(height: 20),
              Section5(),
              SizedBox(height: 20),
              Section6(),
              SizedBox(height: 20),
              Section7(),
              SizedBox(height: 30),
              AppButton(
                title: 'Save',
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

/////////////////////////////////////SECTION 1///////////////////////////////////

class Section1 extends StatelessWidget {
  final List residentNeedsList = [
    'Ambulation',
    'Ambulatory w/ Cane, Crutch, Walker',
    'Transferring',
    'Wheelchair Mobility',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainGrey,
      ),
      child: ExpansionTile(
        title: Text(
          'SECTION 1 - Resident’s Needs',
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
              children: residentNeedsList
                  .map<Widget>((e) => Section1RadioButtons(
                        title: e,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

class Section1RadioButtons extends StatefulWidget {
  final String? title;

  const Section1RadioButtons({this.title});
  @override
  State<Section1RadioButtons> createState() => _Section1RadioButtonsState();
}

class _Section1RadioButtonsState extends State<Section1RadioButtons> {
  var groupValue = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AutoSizeText(
            widget.title!,
            minFontSize: 12,
            maxFontSize: 14,
            maxLines: 1,
          ),
        ),
        Row(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Radio(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (int? v) {
                        setState(() {
                          groupValue = v!;
                        });
                      }),
                ),
                Text('N'),
              ],
            ),
            SizedBox(width: 10),
            Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (int? v) {
                      setState(() {
                        groupValue = v!;
                      });
                    },
                  ),
                ),
                Text('M'),
              ],
            ),
            SizedBox(width: 10),
            Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Radio(
                    value: 3,
                    groupValue: groupValue,
                    onChanged: (int? v) {
                      setState(() {
                        groupValue = v!;
                      });
                    },
                  ),
                ),
                Text('T'),
              ],
            ),
          ],
        )
      ],
    );
  }
}

/////////////////////////////////////SECTION 2///////////////////////////////////

class Section2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainGrey,
      ),
      child: ExpansionTile(
        title: Text(
          'SECTION 2 – Diet',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Diet',
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
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////SECTION 3///////////////////////////////////

class Section3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainGrey,
      ),
      child: ExpansionTile(
        title: Text(
          'SECTION 3 - Diagnosis',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Diagnosis',
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
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////SECTION 5///////////////////////////////////

class Section5 extends StatelessWidget {
  final List residentNeedsList = [
    'Fecal Incontinent',
    'Urinary Incontinent',
    'Nocturnal Incontinent',
    'Blindness',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainGrey,
      ),
      child: ExpansionTile(
        title: Text(
          'SECTION 5 - Functioning',
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
              children: residentNeedsList
                  .map<Widget>((e) => Section1RadioButtons(
                        title: e,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

/////////////////////////////////////SECTION 6///////////////////////////////////

class Section6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainGrey,
      ),
      child: ExpansionTile(
        title: Text(
          'SECTION 6- Allergies',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Allergies',
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
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////SECTION 7///////////////////////////////////

class Section7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainGrey,
      ),
      child: ExpansionTile(
        title: Text(
          'SECTION 7 - Medication',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '(List PRN’s last)',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Medication',
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
          ),
        ],
      ),
    );
  }
}
