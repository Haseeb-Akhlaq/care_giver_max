import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/DoctorsOrder/Model/doctors_orders.dart';
import 'package:caregiver_max/widgets/Drawer/main_user_drawer.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:caregiver_max/widgets/simple_appBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class DoctorOrdersScreen extends StatefulWidget {
  final Resident? resident;

  const DoctorOrdersScreen({Key? key, this.resident}) : super(key: key);
  @override
  State<DoctorOrdersScreen> createState() => _DoctorOrdersScreenState();
}

class _DoctorOrdersScreenState extends State<DoctorOrdersScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<DoctorsOrder> allOrders = [];

  bool controlledMedication = false;

  String? existingRecord = 'New Record';
  List<String> records = [
    'New Record',
  ];
  String? date = '';

  bool? sN = false;
  bool? hha = false;
  bool? pt = false;
  bool? msw = false;
  bool? patient = false;

  bool otherSelected = false;
  bool isLoading = false;

  TextEditingController mrController = TextEditingController();
  TextEditingController physicianController = TextEditingController();
  TextEditingController clinicalFindingsController = TextEditingController();
  TextEditingController orderController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  addNewDoctorsOrder() {
    final time = DateTime.now();

    if (date == '') {
      Fluttertoast.showToast(msg: 'Please Select Date');
      return;
    }
    if (mrController.text == '') {
      Fluttertoast.showToast(msg: 'Please Enter MR #');
      return;
    }
    if (physicianController.text == '') {
      Fluttertoast.showToast(msg: 'Please Enter Physician Name');
      return;
    }

    if (existingRecord != 'New Record') {
      return;
    }

    FirebaseFirestore.instance
        .collection('Residents-Doctor-Orders')
        .doc(widget.resident!.id)
        .collection('orders')
        .doc(time.toString())
        .set({
      'id': time.toString(),
      'date': date,
      'mr': mrController.text,
      'physician': physicianController.text,
      'clinicalFinding': clinicalFindingsController.text,
      'order': orderController.text,
      'sn': sN,
      'hha': hha,
      'pt': pt,
      'msw': msw,
      'patient': patient,
      'other': otherSelected,
      'otherText': otherController.text,
    });

    Navigator.pop(context);
  }

  getPreviousOrders() async {
    setState(() {
      isLoading = true;
    });

    final previousOrders = await FirebaseFirestore.instance
        .collection('Residents-Doctor-Orders')
        .doc(widget.resident!.id)
        .collection('orders')
        .get();

    previousOrders.docs.forEach((element) {
      allOrders.add(DoctorsOrder.fromMap(element.data()));
      records.add(element.data()['id']);
    });

    print(records);

    setState(() {
      isLoading = false;
    });
  }

  onRecordSelect() {
    DoctorsOrder selectedOrder =
        allOrders.firstWhere((element) => element.id == existingRecord);

    date = selectedOrder.date;
    mrController.text = selectedOrder.mr!;
    physicianController.text = selectedOrder.physician!;
    clinicalFindingsController.text = selectedOrder.clinicalFindings!;
    orderController.text = selectedOrder.order!;
    sN = selectedOrder.sn;
    hha = selectedOrder.hha;
    pt = selectedOrder.pt;
    msw = selectedOrder.msw;
    patient = selectedOrder.patient;
    otherSelected = selectedOrder.other!;
    otherController.text = selectedOrder.otherText!;

    setState(() {});
  }

  reset() {
    date = '';
    mrController.text = '';
    physicianController.text = '';
    clinicalFindingsController.text = '';
    orderController.text = '';
    sN = false;
    hha = false;
    pt = false;
    msw = false;
    patient = false;
    otherSelected = false;
    otherController.text = '';

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreviousOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MainUserDrawer(),
      key: _scaffoldKey,
      appBar: simpleAppBar(
        context,
        title: 'Setup Medication Details',
        menuTap: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    ////////////////////////////////////////////Existing Record
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Existing Record',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        DropdownButton(
                          value: existingRecord,
                          items: records.map(
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
                            if (existingRecord == 'New Record') {
                              reset();
                            }
                            if (existingRecord != 'New Record') {
                              onRecordSelect();
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    ///////////////////////////////Date;
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate:
                                    DateTime.now().subtract(Duration(days: 10)),
                                lastDate:
                                    DateTime.now().add(Duration(days: 60)));

                            setState(() {
                              date = DateFormat.yMd().format(selectedDate!);
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
                                  horizontal: 20, vertical: 15),
                              child: Text('$date'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    ///////////////////////////////MR #;
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MR #',
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
                              controller: mrController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    ///////////////////////////////Physician;
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Physician',
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
                              controller: physicianController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    ////////////////////////////////////////////Clinical Findings
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Clinical Findings',
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
                              controller: clinicalFindingsController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              maxLines: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    ////////////////////////////////////////////Order
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order',
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
                              controller: orderController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              maxLines: null,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 25),
                    ////////////////////////////////////////////Staff Notified
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Staff notified',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 1.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    value: sN,
                                    onChanged: (v) {
                                      setState(() {
                                        sN = v;
                                      });
                                    }),
                                Text(
                                  'SN',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: hha,
                                    onChanged: (v) {
                                      setState(() {
                                        hha = v;
                                      });
                                    }),
                                Text(
                                  'HHA',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: pt,
                                    onChanged: (v) {
                                      setState(() {
                                        pt = v;
                                      });
                                    }),
                                Text(
                                  'PT',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    value: msw,
                                    onChanged: (v) {
                                      setState(() {
                                        msw = v;
                                      });
                                    }),
                                Text(
                                  'MSW',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: patient,
                                    onChanged: (v) {
                                      setState(() {
                                        patient = v;
                                      });
                                    }),
                                Text(
                                  'PATIENT',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 25),
                    ////////////////////////////////////////////Others
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: otherSelected,
                                onChanged: (v) {
                                  setState(() {
                                    otherSelected = v!;
                                  });
                                }),
                            Text(
                              'OTHER : ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
                              controller: otherController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 25),
                    if (existingRecord == 'New Record')
                      AppButton(
                        title: 'Save',
                        onTap: () {
                          addNewDoctorsOrder();
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
