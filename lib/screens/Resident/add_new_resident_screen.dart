import 'package:caregiver_max/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddResidentScreen extends StatefulWidget {
  const AddResidentScreen({Key? key}) : super(key: key);

  @override
  State<AddResidentScreen> createState() => _AddResidentScreenState();
}

class _AddResidentScreenState extends State<AddResidentScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? statusDropDown;
  String? propertyDropDownName;
  String? state;

  //
  String? admissionDate = '';
  String? dateOfBirth = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add New Resident'),
        backgroundColor: Color(0xff788B91),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 20, right: 10),
                        focusColor: Theme.of(context).primaryColor,
                        hintText:
                            statusDropDown == null ? 'Status' : statusDropDown!,
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      items: ['Active', 'Non Active'].map(
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
                            statusDropDown = val.toString();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              ////////////////////////////////////////////Status
              SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Property',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 20, right: 10),
                        focusColor: Theme.of(context).primaryColor,
                        hintText: propertyDropDownName == null
                            ? 'Property'
                            : propertyDropDownName!,
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      items: [
                        'Family Choice',
                        'RNC Data',
                        'Bhall LLC',
                        'Talco House',
                      ].map(
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
                            propertyDropDownName = val.toString();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              ////////////////////////////////////////////Property
              SizedBox(height: 25),
              ////////////////////////////////////////////Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
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
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),
              ////////////////////////////////////////////Admission Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admission Date',
                    style: TextStyle(
                      fontSize: 18,
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
                        admissionDate = DateFormat.yMd().format(date!);
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
                        child: Text('$admissionDate'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ////////////////////////////////////////////Primary Language
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Primary Language',
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
                            return 'Please Enter Language Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ////////////////////////////////////////////Admission Form
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admission Form',
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
                            return 'Please Enter Admission Form Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),

              ////////////////////////////////////////////Occupation
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Occupation',
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
                            return 'Please Enter Occupation Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),

              ////////////////////////////////////////////Place of Birth
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Place of birth',
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
                            return 'Please Enter Place of birth Name';
                          }
                          return null;
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
                        maxLines: 3,
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Address';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ////////////////////////////////////////////Telephone
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Telephone',
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
                            return 'Please Enter Telephone Number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),

              ////////////////////////////////////////////Race
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Race',
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
                            return 'Please Enter Race Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),
              ////////////////////////////////////////////Age
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Age',
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
                            return 'Please Enter Telephone Number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              ////////////////////////////////////////////Date of birth
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date of Birth',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2030));

                      setState(() {
                        dateOfBirth = DateFormat.yMd().format(date!);
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
                        child: Text('$dateOfBirth'),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25),

              ////////////////////////////////////////////Sex
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sex',
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
                            return 'Please Enter Sex Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              //////////////////////////////////////////// Martial Status
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Martial Status',
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
                            return 'Please Enter Martial Status';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),

              ////////////////////////////////////////////Height
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Height',
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
                            return 'Please Enter Height';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),

              ////////////////////////////////////////////Weight
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weight',
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
                            return 'Please Enter Weight';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              //////////////////////////////////////////// Social Security
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Social Security',
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
                            return 'Please Enter Social Security';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),

              Container(
                width: double.infinity,
                child: Text(
                  'Religious',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 25),
              //////////////////////////////////////////// Religion
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Religion',
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
                            return 'Please Enter Religion Name';
                          }
                          return null;
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
                            return 'Please Enter Clergyman Name';
                          }
                          return null;
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
                            return 'Please Enter Church Synagogue Name';
                          }
                          return null;
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
                            return 'Please Enter Telephone Number';
                          }
                          return null;
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
                        maxLines: 3,
                        onSaved: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Address';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Container(
                width: double.infinity,
                child: Text(
                  'Medication',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 25),
              //////////////////////////////////////////// Medicare
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medicare',
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
                            return 'Please Enter Medicare';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              //////////////////////////////////////////// Medicaid
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medicaid',
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
                            return 'Please Enter Medicaid';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50),
              AppButton(
                title: 'Add',
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
