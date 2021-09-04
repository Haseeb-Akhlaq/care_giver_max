import 'package:caregiver_max/widgets/app_button.dart';
import 'package:caregiver_max/widgets/drawer.dart';
import 'package:caregiver_max/widgets/simple_appBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DischargedExpiredScreen extends StatefulWidget {
  @override
  State<DischargedExpiredScreen> createState() =>
      _DischargedExpiredScreenState();
}

class _DischargedExpiredScreenState extends State<DischargedExpiredScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List medicationList = [
    'Generlac sol',
    'Lotrel',
    'Bhall LLC',
    'Talco House',
  ];

  bool mdApproval = false;
  String? dischargeDate = '';

  selectTime(context) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppDrawer(),
      key: _scaffoldKey,
      appBar: simpleAppBar(
        context,
        title: 'Discharged/Expired',
        menuTap: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///////////////////////////////Discharged Or Expired Date;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discharged Or Expired Date',
                    style: TextStyle(
                      fontSize: 16,
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
                        dischargeDate = DateFormat.yMd().format(date!);
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Text('$dischargeDate'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ///////////////////////////////Reason;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reason',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Direction For use';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ///////////////////////////////Without MD Approval;
              Row(
                children: [
                  Checkbox(
                      value: mdApproval,
                      onChanged: (v) {
                        setState(() {
                          mdApproval = v!;
                        });
                      }),
                  Text('Without MD Approval'),
                ],
              ),
              SizedBox(height: 20),
              ///////////////////////////////Released To;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Released To',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Direction For use';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////New Address;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Address',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        maxLines: 3,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Direction For use';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////Place Of Death Address
              // (City, County, State);
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Place Of Death Address \n(City, County, State) ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        maxLines: 3,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Direction For use';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////Precinct No;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Precinct No',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Direction For use';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////Mortician Name;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mortician Name',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Mortician Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ///////////////////////////////Signature;
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Signature',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Signature';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),
              AppButton(
                title: 'Update',
                onTap: () {
                  Navigator.pop(context);
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
