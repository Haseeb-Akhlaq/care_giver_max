import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:flutter/material.dart';

class PhysicianExpansionTile extends StatefulWidget {
  final Resident? resident;
  final Function? setPhysicianTileValues;

  const PhysicianExpansionTile(
      {Key? key, this.resident, this.setPhysicianTileValues})
      : super(key: key);

  @override
  State<PhysicianExpansionTile> createState() => _PhysicianExpansionTileState();
}

class _PhysicianExpansionTileState extends State<PhysicianExpansionTile> {
  TextEditingController physicianNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();

  setInitialValues() {
    physicianNameController.text = widget.resident!.physician!;
    addressController.text = widget.resident!.physicianAddress!;
    telephoneController.text = widget.resident!.physicianTelephone!;
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
                ////////////////////////////////////////////Physician Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Physician Name',
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
                          controller: physicianNameController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            widget.setPhysicianTileValues!(
                                physicianNameController.text,
                                addressController.text,
                                telephoneController.text);
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
                          controller: addressController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            widget.setPhysicianTileValues!(
                                physicianNameController.text,
                                addressController.text,
                                telephoneController.text);
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
                            widget.setPhysicianTileValues!(
                                physicianNameController.text,
                                addressController.text,
                                telephoneController.text);
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
