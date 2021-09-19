import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:caregiver_max/widgets/drawer.dart';
import 'package:caregiver_max/widgets/simple_appBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/async.dart';

class ResidentGuardian {
  String? id;
  String? name;
  String? relationShip;
  String? address;
  String? telephone;

  ResidentGuardian(
      {this.id, this.telephone, this.address, this.name, this.relationShip});

  ResidentGuardian.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.relationShip = map['relationShip'];
    this.address = map['address'];
    this.telephone = map['telephone'];
  }
}

class NearestRelativeGuardianScreen extends StatefulWidget {
  final Resident? resident;
  const NearestRelativeGuardianScreen({Key? key, this.resident})
      : super(key: key);

  @override
  State<NearestRelativeGuardianScreen> createState() =>
      _NearestRelativeGuardianScreenState();
}

class _NearestRelativeGuardianScreenState
    extends State<NearestRelativeGuardianScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<ResidentGuardian> allGuardians = [];
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController relationShipController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();

  addNearestGuardian() async {
    String id = await customAlphabet('1234567890', 10);

    await FirebaseFirestore.instance
        .collection('Resident-Guardians')
        .doc(widget.resident!.id)
        .collection('guardians')
        .doc(id)
        .set({
      'id': id,
      'name': nameController.text,
      'relationShip': relationShipController.text,
      'address': addressController.text,
      'telephone': telephoneController.text,
    });

    nameController.text = '';
    relationShipController.text = '';
    addressController.text = '';
    telephoneController.text = '';

    getAllGuardians();
  }

  getAllGuardians() async {
    allGuardians = [];

    setState(() {
      isLoading = true;
    });

    final guardians = await FirebaseFirestore.instance
        .collection('Resident-Guardians')
        .doc(widget.resident!.id)
        .collection('guardians')
        .get();

    guardians.docs.forEach((element) {
      allGuardians.add(ResidentGuardian.fromMap(element.data()));
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllGuardians();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppDrawer(),
      key: _scaffoldKey,
      appBar: simpleAppBar(
        context,
        title: 'Nearest Relative/Guardian',
        menuTap: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///////////////////////////////Name;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
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
                        controller: nameController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////Relationship;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Relationship',
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
                        controller: relationShipController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////Address;
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
                        maxLines: 3,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////The Phone Number;
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
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              AppButton(
                title: 'Add',
                onTap: () {
                  addNearestGuardian();
                },
              ),
              SizedBox(height: 25),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: allGuardians
                          .map((e) => GuardianCard(
                                residentGuardian: e,
                                residentId: widget.resident!.id,
                                getGuardians: getAllGuardians,
                              ))
                          .toList()),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class GuardianCard extends StatelessWidget {
  final ResidentGuardian? residentGuardian;
  final String? residentId;
  final Function? getGuardians;
  const GuardianCard(
      {Key? key, this.residentGuardian, this.residentId, this.getGuardians})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      residentGuardian!.name!,
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
                    'Relationship :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      residentGuardian!.relationShip!,
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
                    'Address :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      residentGuardian!.address!,
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
                    'Telephone :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      residentGuardian!.telephone!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.edit, color: Colors.blue),
                  GestureDetector(
                    onTap: () async {
                      await FirebaseFirestore.instance
                          .collection('Resident-Guardians')
                          .doc(residentId)
                          .collection('guardians')
                          .doc(residentGuardian!.id)
                          .delete();

                      getGuardians!();
                    },
                    child: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
