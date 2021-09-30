import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReligiousExpansionTile extends StatefulWidget {
  final Resident? resident;
  final Function? setReligionTileValues;

  const ReligiousExpansionTile(
      {Key? key, this.resident, this.setReligionTileValues})
      : super(key: key);

  @override
  _ReligiousExpansionTileState createState() => _ReligiousExpansionTileState();
}

class _ReligiousExpansionTileState extends State<ReligiousExpansionTile> {
  TextEditingController religionController = TextEditingController();
  TextEditingController clergyManController = TextEditingController();
  TextEditingController churchSynagogueController = TextEditingController();
  TextEditingController telephoneReligionController = TextEditingController();
  TextEditingController addressReligionController = TextEditingController();

  setInitialValues() {
    religionController.text = widget.resident!.religion!;
    clergyManController.text = widget.resident!.clergyMan!;
    churchSynagogueController.text = widget.resident!.churchSynagogue!;
    telephoneReligionController.text = widget.resident!.telephoneChurch!;
    addressReligionController.text = widget.resident!.addressChurch!;
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
          'Religious',
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
                SizedBox(height: 25),
                //////////////////////////////////////////// Religion
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Religion',
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
                          controller: religionController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            widget.setReligionTileValues!(
                                religionController.text,
                                clergyManController.text,
                                churchSynagogueController.text,
                                telephoneReligionController.text,
                                addressReligionController.text);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                //////////////////////////////////////////// Clergyman
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Clergyman',
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
                          controller: clergyManController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            widget.setReligionTileValues!(
                                religionController.text,
                                clergyManController.text,
                                churchSynagogueController.text,
                                telephoneReligionController.text,
                                addressReligionController.text);
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25),
                //////////////////////////////////////////// Church Synagogue
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Church Synagogue',
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
                          controller: churchSynagogueController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            widget.setReligionTileValues!(
                                religionController.text,
                                clergyManController.text,
                                churchSynagogueController.text,
                                telephoneReligionController.text,
                                addressReligionController.text);
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
                          controller: telephoneReligionController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            widget.setReligionTileValues!(
                                religionController.text,
                                clergyManController.text,
                                churchSynagogueController.text,
                                telephoneReligionController.text,
                                addressReligionController.text);
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: addressReligionController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          maxLines: 3,
                          onChanged: (v) {
                            widget.setReligionTileValues!(
                                religionController.text,
                                clergyManController.text,
                                churchSynagogueController.text,
                                telephoneReligionController.text,
                                addressReligionController.text);
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
