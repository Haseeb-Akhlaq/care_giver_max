import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/%20Comprehensive%20Assesment/Model/models.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/Drawer/main_user_drawer.dart';
import 'package:caregiver_max/widgets/simple_appBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComprehensiveAssessmentScreen extends StatefulWidget {
  final Resident? resident;

  const ComprehensiveAssessmentScreen({Key? key, this.resident})
      : super(key: key);

  @override
  State<ComprehensiveAssessmentScreen> createState() =>
      _ComprehensiveAssessmentScreenState();
}

class _ComprehensiveAssessmentScreenState
    extends State<ComprehensiveAssessmentScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? existingRecord;
  List<String>? records = ['New Record'];

  List<ComprehensiveAssessment> allAssessmentsRecords = [];
  ComprehensiveAssessment newAssessment = ComprehensiveAssessment();
  ComprehensiveAssessment? selectedAssessment;

  List sleepPatterns = [
    'Sleeps well night',
    'Light sleeper but independent',
    'Requires night supervision',
    'Naps regularly',
    'No medication needed for sleep',
    'Medication given 1-3 times per week',
    'Medication given 1-3 times per month',
    'Medication given every night',
  ];

  List behaviorSymptoms = [
    'Cheerfiul',
    'Sociable, talkative',
    'Fearfulness, anxiety',
    'Depressed',
    'Obsessive/Compulsive',
    'Irritability',
    'Physically abusive to self or others',
    'Wanders',
    'Hostility',
    'Liability',
  ];

  List frequencyOfBehaviorSymptoms = [
    'Less than once a month',
    'None Noted',
    'Daily',
    '1-2 times a week',
    '1-3 times a month',
  ];

  List psychoSocialSignsOrSymptomsOfDepression = [
    'None noted',
    'Fatigue',
    'Weakness',
    'Low self-esteem',
    'Apathy',
    'Poor appetite',
    'Self-care deficit in hygiene/grooming',
    'Trouble sleeping, wakes during night',
  ];

  List<CheckBoxOption> sleepPatternsObjects = [];
  List<CheckBoxOption> behaviorSymptomsObjects = [];
  List<CheckBoxOption> frequencyOfBehaviorSymptomsObjects = [];
  List<CheckBoxOption> psychoSocialSignsOrSymptomsOfDepressionObjects = [];

  changeValues(String name, bool value, String headerName) {
    if (headerName == 'SlEEP PATTERNS') {
      int index = sleepPatterns.indexOf(name);
      selectedAssessment!.sleepPatterns![index].checked = value;
    }

    if (headerName == 'BEHAVIOR SYMPTOMS') {
      int index = behaviorSymptoms.indexOf(name);
      selectedAssessment!.behaviorSymptoms![index].checked = value;
    }
    if (headerName == 'FREQUENCY OF BEHAVIOR SYMPTOMS') {
      int index = frequencyOfBehaviorSymptoms.indexOf(name);
      selectedAssessment!.frequencyOfBehaviorSymptoms![index].checked = value;
    }

    if (headerName == 'PSYCHOSOCIAL SIGNS OR SYMPTOMS OF DEPRESSION') {
      int index = psychoSocialSignsOrSymptomsOfDepression.indexOf(name);
      selectedAssessment!
          .psychoSocialSignsOrSymptomsOfDepression![index].checked = value;
    }

    setState(() {});
  }

  createOptions() {
    sleepPatternsObjects = sleepPatterns
        .map((e) => CheckBoxOption(name: e, checked: false))
        .toList();

    behaviorSymptomsObjects = behaviorSymptoms
        .map((e) => CheckBoxOption(name: e, checked: false))
        .toList();

    frequencyOfBehaviorSymptomsObjects = frequencyOfBehaviorSymptoms
        .map((e) => CheckBoxOption(name: e, checked: false))
        .toList();

    psychoSocialSignsOrSymptomsOfDepressionObjects =
        psychoSocialSignsOrSymptomsOfDepression
            .map((e) => CheckBoxOption(name: e, checked: false))
            .toList();

    newAssessment.sleepPatterns = sleepPatternsObjects;
    newAssessment.behaviorSymptoms = behaviorSymptomsObjects;
    newAssessment.frequencyOfBehaviorSymptoms =
        frequencyOfBehaviorSymptomsObjects;

    newAssessment.psychoSocialSignsOrSymptomsOfDepression =
        psychoSocialSignsOrSymptomsOfDepressionObjects;

    selectedAssessment = newAssessment;
    setState(() {});
  }

  saveToFirebase() {
    var time = DateFormat.yMd().add_jm().format(DateTime.now());

    time = time.replaceAll('/', '-');

    print(time);

    FirebaseFirestore.instance
        .collection('Resident Comprehensive Assessment')
        .doc(widget.resident!.id)
        .collection('records')
        .doc(time)
        .set({
      'time': time,
      'sleepPatterns': [
        ...selectedAssessment!.sleepPatterns!.map((e) => {
              'name': e.name,
              'isChecked': e.checked,
            })
      ],
      'behaviorSymptoms': [
        ...selectedAssessment!.behaviorSymptoms!.map((e) => {
              'name': e.name,
              'isChecked': e.checked,
            })
      ],
      'frequencyOfBehaviorSymptoms': [
        ...selectedAssessment!.frequencyOfBehaviorSymptoms!.map((e) => {
              'name': e.name,
              'isChecked': e.checked,
            })
      ],
      'psychoSocialSignsOrSymptomsOfDepression': [
        ...selectedAssessment!.psychoSocialSignsOrSymptomsOfDepression!
            .map((e) => {
                  'name': e.name,
                  'isChecked': e.checked,
                })
      ],
    });
  }

  getOptionsFromFirebase() async {
    final previousRecords = await FirebaseFirestore.instance
        .collection('Resident Comprehensive Assessment')
        .doc(widget.resident!.id)
        .collection('records')
        .get();

    //WE ARE GETTING ALL RECORDS FROM FIREBASE

    previousRecords.docs.forEach((record) {
      records!.add(record.data()['time']);

      String time = record.data()['time'];

      //SETTING SLEEP PATTERNS
      List sleepingPatterns = record
          .data()['sleepPatterns']
          .map((e) => CheckBoxOption(name: e['name'], checked: e['isChecked']))
          .toList();

      //SETTING BEHAVIOR SYMPTOMS
      List behaviourSymptoms = record
          .data()['behaviorSymptoms']
          .map((e) => CheckBoxOption(name: e['name'], checked: e['isChecked']))
          .toList();

      //SETTING FREQUENCY OF BEHAVIOR SYMPTOMS
      List frequencyBehaviourSymptoms = record
          .data()['frequencyOfBehaviorSymptoms']
          .map((e) => CheckBoxOption(name: e['name'], checked: e['isChecked']))
          .toList();

      //SETTING PSYCHOSOCIAL SIGNS OR SYMPTOMS OF DEPRESSION
      List psychoSocialSignsOrSymptomsOfDepression = record
          .data()['psychoSocialSignsOrSymptomsOfDepression']
          .map((e) => CheckBoxOption(name: e['name'], checked: e['isChecked']))
          .toList();

      final assesment = ComprehensiveAssessment(
        time: time,
        sleepPatterns: sleepingPatterns,
        behaviorSymptoms: behaviourSymptoms,
        frequencyOfBehaviorSymptoms: frequencyBehaviourSymptoms,
        psychoSocialSignsOrSymptomsOfDepression:
            psychoSocialSignsOrSymptomsOfDepression,
      );

      allAssessmentsRecords.add(assesment);
    });

    setState(() {});
  }

  changeAssessment() {
    if (existingRecord == 'New Record') {
      selectedAssessment = newAssessment;
      return;
    }

    selectedAssessment = allAssessmentsRecords
        .firstWhere((element) => element.time == existingRecord);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    createOptions();
    getOptionsFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MainUserDrawer(),
      key: _scaffoldKey,
      appBar: simpleAppBar(
        context,
        title: 'Comprehensive Screen',
        menuTap: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ////////////////////////////////////////////Existing Record

              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 20, right: 10),
                          focusColor: Theme.of(context).primaryColor,
                          hintText: existingRecord == null
                              ? 'Record'
                              : existingRecord!,
                        ),
                        isExpanded: true,
                        iconSize: 30.0,
                        items: records!.map(
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
                          changeAssessment();
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  if (existingRecord == 'New Record')
                    GestureDetector(
                      onTap: () {
                        saveToFirebase();
                        getOptionsFromFirebase();
                      },
                      child: Icon(
                        Icons.save,
                        size: 30,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 15),
              OptionsTile(
                sleepPatternsObjects: selectedAssessment!.sleepPatterns,
                changeValues: changeValues,
                title: 'SlEEP PATTERNS',
              ),
              SizedBox(height: 15),
              OptionsTile(
                sleepPatternsObjects: selectedAssessment!.behaviorSymptoms,
                changeValues: changeValues,
                title: 'BEHAVIOR SYMPTOMS',
              ),
              SizedBox(height: 15),
              OptionsTile(
                sleepPatternsObjects:
                    selectedAssessment!.frequencyOfBehaviorSymptoms,
                changeValues: changeValues,
                title: 'FREQUENCY OF BEHAVIOR SYMPTOMS',
              ),
              SizedBox(height: 15),
              OptionsTile(
                sleepPatternsObjects:
                    selectedAssessment!.psychoSocialSignsOrSymptomsOfDepression,
                changeValues: changeValues,
                title: 'PSYCHOSOCIAL SIGNS OR SYMPTOMS OF DEPRESSION',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionsTile extends StatelessWidget {
  final List? sleepPatternsObjects;
  final Function? changeValues;
  final String? title;

  const OptionsTile({
    Key? key,
    this.sleepPatternsObjects,
    this.changeValues,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainGrey.withOpacity(0.3),
      ),
      child: ExpansionTile(
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Column(
            children: sleepPatternsObjects!
                .map((e) => Row(
                      children: [
                        Checkbox(
                            value: e.checked,
                            onChanged: (v) {
                              changeValues!(e.name, v, title);
                            }),
                        Text(e.name!),
                      ],
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
