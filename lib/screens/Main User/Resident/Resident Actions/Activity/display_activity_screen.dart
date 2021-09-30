import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/Activity/Model/activity.dart';
import 'package:caregiver_max/widgets/simple_appBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';

import 'Model/edit_activity_screen.dart';

class DisplayActivityScreen extends StatefulWidget {
  final Resident? resident;

  const DisplayActivityScreen({Key? key, this.resident}) : super(key: key);

  @override
  State<DisplayActivityScreen> createState() => _DisplayActivityScreenState();
}

class _DisplayActivityScreenState extends State<DisplayActivityScreen> {
  List<Activity> allActivities = [];
  List<Activity> displayActivities = [];

  String? typeDropDown;
  bool isLoading = false;

  int? selectedIndex1 = 0;

  final type = [
    'All',
    'Daily Record',
    'Diabetic',
    'Diagnosis',
  ];

  getAllActivities() async {
    allActivities = [];
    displayActivities = [];

    setState(() {
      isLoading = true;
    });

    final medications = await FirebaseFirestore.instance
        .collection('Resident Activity')
        .doc(widget.resident!.id)
        .collection('activities')
        .get();

    medications.docs.forEach((element) {
      allActivities.add(
        Activity.fromMap(element.data()),
      );
      displayActivities = allActivities;
    });

    setState(() {
      isLoading = false;
    });
  }

  filterActivities() {
    displayActivities = [];

    if (typeDropDown == 'All') {
      displayActivities = allActivities;
      setState(() {});
    } else {
      allActivities.forEach((element) {
        if (element.type == typeDropDown) {
          displayActivities.add(element);
        }
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
        context,
        title: 'All Activity',
        menuTap: () {},
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  ///////////////////////////////Type;

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      DirectSelect(
                          itemExtent: 35.0,
                          selectedIndex: selectedIndex1!,
                          child: MySelectionItem(
                            isForList: false,
                            title: type[selectedIndex1!],
                          ),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedIndex1 = index;
                            });
                            typeDropDown = type[index!];
                            filterActivities();
                          },
                          mode: DirectSelectMode.tap,
                          items: type
                              .map((val) => MySelectionItem(
                                    title: val,
                                  ))
                              .toList()),
                    ],
                  ),
                  SizedBox(height: 50),
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return ActivityCard(
                              activity: displayActivities[index],
                              reset: getAllActivities,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemCount: displayActivities.length))
                ],
              ),
            ),
    );
  }
}

class ActivityCard extends StatefulWidget {
  final Activity? activity;
  final Function? reset;
  const ActivityCard({this.activity, this.reset});

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  Future<Widget> _deleteUserAlert() async {
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
              'Delete User',
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
                'Are you sure you want to Delete?',
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
                        onPressed: () async {
                          FirebaseFirestore.instance
                              .collection('Resident Activity')
                              .doc(widget.activity!.residentId)
                              .collection('activities')
                              .doc(widget.activity!.id)
                              .delete();

                          Navigator.pop(context);
                          widget.reset!();
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 0.5,
                            color: Colors.red,
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Date :  ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.activity!.date!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => EditMedicationScreen(
                  //           medication: medication,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   child: Icon(
                  //     Icons.edit,
                  //     color: AppColors.background,
                  //     size: 20,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Time :  ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.activity!.time!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Made By :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      widget.activity!.madeBy!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      widget.activity!.type!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Observation / Comment:  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      widget.activity!.observation!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditActivityScreen(activity: widget.activity),
                        ),
                      );
                    },
                    child: Icon(Icons.edit, color: Colors.blue),
                  ),
                  GestureDetector(
                      onTap: () {
                        _deleteUserAlert();
                      },
                      child: Icon(Icons.delete, color: Colors.red)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MySelectionItem extends StatelessWidget {
  final String? title;
  final bool isForList;

  const MySelectionItem({Key? key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: Colors.grey),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(
        title!,
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
