import 'package:caregiver_max/Models/Resident/Adl/checkBox.dart';
import 'package:caregiver_max/Models/Resident/Adl/header.dart';
import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/screens/Resident/Resident%20Actions/ADL%20Record/Provider/provider.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SetupADLExpansionTile extends StatefulWidget {
  final Resident? resident;
  const SetupADLExpansionTile({this.resident});

  @override
  _SetupADLExpansionTileState createState() => _SetupADLExpansionTileState();
}

class _SetupADLExpansionTileState extends State<SetupADLExpansionTile> {
  bool isLoading = false;
  bool isSaving = false;

  String? headerDropDown;

  List<Header> adlHeader = [];

  List<AdlCheckBox> checkBoxOptions = [];

  List selectedDetailsIds = [];

  configHeader() async {
    setState(() {
      isLoading = true;
    });
    final headerComponents =
        await FirebaseFirestore.instance.collection('Config ADL Header').get();
    headerComponents.docs.forEach((element) {
      adlHeader.add(Header.fromMap(element.data()));
    });
    setState(() {
      isLoading = false;
    });
  }

  configCheckBoxes() async {
    setState(() {
      isLoading = true;
    });
    final checkBoxes =
        await FirebaseFirestore.instance.collection('Config ADL Details').get();
    checkBoxes.docs.forEach((element) {
      checkBoxOptions.add(AdlCheckBox.fromMap(element.data()));
    });
    setState(() {
      isLoading = false;
    });
  }

  addRemoveDetails(String id, bool add) {
    if (add) {
      selectedDetailsIds.add(id);
    } else {
      selectedDetailsIds.remove(id);
    }
    print(selectedDetailsIds);
  }

  saveHeaderDetails() async {
    if (headerDropDown == null) {
      Fluttertoast.showToast(msg: 'Please Select Header');
      return;
    }

    setState(() {
      isSaving = true;
    });

    final Header selectedHeaderItem =
        adlHeader.firstWhere((element) => element.title == headerDropDown);
    await FirebaseFirestore.instance
        .collection('Resident Action ADL')
        .doc(widget.resident!.id)
        .collection('Headers')
        .doc(selectedHeaderItem.id)
        .set({
      'id': selectedHeaderItem.id,
      'headerName': selectedHeaderItem.title,
      'selectedDetails': selectedDetailsIds,
    });

    await Provider.of<AdlRecordProvider>(context, listen: false)
        .getHeadersWithOptions(widget.resident!.id!);

    setState(() {
      isSaving = false;
    });
  }

  getSelectedHeaderDetails() async {
    selectedDetailsIds = [];

    checkBoxOptions.forEach((checkBoxElement) {
      checkBoxElement.isSelected = false;
    });

    final Header selectedHeaderItem =
        adlHeader.firstWhere((element) => element.title == headerDropDown);

    final selectedDetails = await FirebaseFirestore.instance
        .collection('Resident Action ADL')
        .doc(widget.resident!.id)
        .collection('Headers')
        .doc(selectedHeaderItem.id)
        .get();

    if (selectedDetails.exists) {
      selectedDetailsIds = selectedDetails.data()!['selectedDetails'];

      //LIST WILL CHECK IF SELECTED ID IS EQUAL IS CHECKBOX ID THEN MAKE IT SELECTED
      selectedDetailsIds.forEach((id) {
        checkBoxOptions.forEach((checkBoxElement) {
          if (checkBoxElement.id == id) {
            checkBoxElement.isSelected = true;
          }
        });
      });
      setState(() {});
    } else {
      print('Not Matched');
    }
  }

  @override
  void initState() {
    super.initState();
    configHeader();
    configCheckBoxes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainGrey.withOpacity(0.3),
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
          isLoading
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
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
                                color: Colors.grey.withOpacity(0.1),
                              ),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      top: 5.0, bottom: 5.0, left: 20),
                                  focusColor: Theme.of(context).primaryColor,
                                  hintText: headerDropDown == null
                                      ? 'Header'
                                      : headerDropDown!,
                                ),
                                isExpanded: true,
                                iconSize: 30.0,
                                items: adlHeader.map(
                                  (val) {
                                    return DropdownMenuItem(
                                      value: val.title,
                                      child: Text(val.title!),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      headerDropDown = val.toString();
                                      getSelectedHeaderDetails();
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          isSaving
                              ? Container(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator())
                              : GestureDetector(
                                  onTap: () {
                                    saveHeaderDetails();
                                  },
                                  child: Icon(
                                    Icons.save,
                                    size: 30,
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ...checkBoxOptions.map((e) => Column(
                            children: [
                              AdlCheckBoxes(
                                adlCheckBox: e,
                                addDetailId: addRemoveDetails,
                              ),
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
  final AdlCheckBox? adlCheckBox;
  final Function? addDetailId;
  const AdlCheckBoxes({this.adlCheckBox, this.addDetailId});

  @override
  _AdlCheckBoxesState createState() => _AdlCheckBoxesState();
}

class _AdlCheckBoxesState extends State<AdlCheckBoxes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: widget.adlCheckBox!.isSelected,
            onChanged: (v) {
              setState(() {
                widget.adlCheckBox!.isSelected = v;
              });
              if (v!) {
                widget.addDetailId!(widget.adlCheckBox!.id, true);
              } else {
                widget.addDetailId!(widget.adlCheckBox!.id, false);
              }
            },
          ),
          Text(
            widget.adlCheckBox!.title!,
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
