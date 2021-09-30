import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PhysicalExamExpansionTile extends StatefulWidget {
  final Resident? resident;
  final Function? setPhysicalExamTileValues;

  const PhysicalExamExpansionTile(
      {Key? key, this.resident, this.setPhysicalExamTileValues})
      : super(key: key);

  @override
  State<PhysicalExamExpansionTile> createState() =>
      _PhysicalExamExpansionTileState();
}

class _PhysicalExamExpansionTileState extends State<PhysicalExamExpansionTile> {
  String? physicalExamDateDisplay = '';

  TextEditingController yearlyPhysicalDueController = TextEditingController();
  TextEditingController diagnosisController = TextEditingController();
  TextEditingController allergiesController = TextEditingController();

  setInitialValues() {
    physicalExamDateDisplay = widget.resident!.dateOfLastPhysicalExam!;
    yearlyPhysicalDueController.text =
        widget.resident!.physicalExamYearlyPhysicalDue!;
    diagnosisController.text = widget.resident!.physicalExamDiagnosis!;
    allergiesController.text = widget.resident!.physicalExamAllergies!;
  }

  @override
  void initState() {
    super.initState();
    setInitialValues();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.mainGrey.withOpacity(0.3),
      ),
      child: ExpansionTile(
        title: Text(
          'Physician',
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
                ////////////////////////////////////////////Date of Last Physical Exam
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date of Last Physical Exam',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime.now().subtract(Duration(days: 10)),
                            lastDate: DateTime.now().add(Duration(days: 60)));

                        setState(() {
                          physicalExamDateDisplay =
                              DateFormat.yMd().format(date!);
                          widget.setPhysicalExamTileValues!(
                              physicalExamDateDisplay,
                              yearlyPhysicalDueController.text,
                              diagnosisController.text,
                              allergiesController.text);
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: Text('$physicalExamDateDisplay'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),

                ////////////////////////////////////////////Yearly Physical Due
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yearly Physical Due',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        child: TextFormField(
                          controller: diagnosisController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            widget.setPhysicalExamTileValues!(
                                physicalExamDateDisplay,
                                yearlyPhysicalDueController.text,
                                diagnosisController.text,
                                allergiesController.text);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                ////////////////////////////////////////////Diagnosis
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diagnosis',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        child: TextFormField(
                          controller: diagnosisController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            widget.setPhysicalExamTileValues!(
                                physicalExamDateDisplay,
                                yearlyPhysicalDueController.text,
                                diagnosisController.text,
                                allergiesController.text);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                //////////////////////////////////////////// Allergies
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Allergies',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        child: TextFormField(
                          controller: allergiesController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            widget.setPhysicalExamTileValues!(
                                physicalExamDateDisplay,
                                yearlyPhysicalDueController.text,
                                diagnosisController.text,
                                allergiesController.text);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          )
        ],
      ),
    );
  }
}
