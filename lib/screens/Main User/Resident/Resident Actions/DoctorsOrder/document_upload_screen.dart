import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:caregiver_max/widgets/Drawer/main_user_drawer.dart';
import 'package:caregiver_max/widgets/app_button.dart';
import 'package:caregiver_max/widgets/error_snackBar.dart';
import 'package:caregiver_max/widgets/simple_appBar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DocumentUploadScreen extends StatefulWidget {
  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  File? file;
  FilePickerResult? result;

  pickFile() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = File(result!.files.single.path);
      });
    } else {
      showErrorSnackBar(context, 'User cancelled the picker');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MainUserDrawer(),
      key: _scaffoldKey,
      appBar: simpleAppBar(
        context,
        title: 'Document Upload',
        menuTap: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  ///////////////////////////////File Description;
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'File Description',
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
                                return 'Please Enter File Description';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 75),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select File',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  pickFile();
                                },
                                icon: Icon(Icons.upload_file),
                                label: Text('Choose File:  '),
                              ),
                              SizedBox(height: 10),
                              AutoSizeText(
                                file == null
                                    ? 'No file Chosen'
                                    : '${result!.files.first.name}',
                                maxLines: 1,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 25),
                ],
              ),
            ),
            AppButton(
              title: 'Upload',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
