import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:flutter/material.dart';

class HospitalExpansionTile extends StatefulWidget {
  final Resident? resident;
  final Function? setHospitalTileValues;

  const HospitalExpansionTile(
      {Key? key, this.resident, this.setHospitalTileValues})
      : super(key: key);

  @override
  State<HospitalExpansionTile> createState() => _HospitalExpansionTileState();
}

class _HospitalExpansionTileState extends State<HospitalExpansionTile> {
  TextEditingController hospitalPreferenceController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  setInitialValues() {
    hospitalPreferenceController.text = widget.resident!.hospitalPreference!;
    telephoneController.text = widget.resident!.hospitalTelephone!;
    emailController.text = widget.resident!.hospitalEmail!;
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
          'Hospital',
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
                //////////////////////////////////////////// Hospital Preference
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hospital Preference',
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
                          controller: hospitalPreferenceController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            widget.setHospitalTileValues!(
                                hospitalPreferenceController.text,
                                telephoneController.text,
                                emailController.text);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                //////////////////////////////////////////// Telephone
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Telephone',
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
                          controller: telephoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            widget.setHospitalTileValues!(
                                hospitalPreferenceController.text,
                                telephoneController.text,
                                emailController.text);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                //////////////////////////////////////////// Email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
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
                          controller: emailController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            widget.setHospitalTileValues!(
                                hospitalPreferenceController.text,
                                telephoneController.text,
                                emailController.text);
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
