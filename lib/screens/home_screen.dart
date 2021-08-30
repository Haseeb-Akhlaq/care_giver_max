import 'package:caregiver_max/screens/setup_adl_screen.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.textLight,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text('CareGiverMax'),
        backgroundColor: Color(0xff788B91),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                    'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'),
              ),
              SizedBox(width: 10),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Residents',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctxt) => new AlertDialog(
                    backgroundColor: Colors.grey[200],
                    title: Container(),
                    content: Container(
                      height: 280,
                      child: Column(
                        children: [
                          DialogEntries(
                            text: 'ADL Record',
                            onpressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SetupAdlScreen()));
                            },
                          ),
                          DialogEntries(text: 'Medication'),
                          DialogEntries(text: 'Doctor\'s order'),
                          DialogEntries(text: 'Activity'),
                          DialogEntries(text: 'Service Care'),
                          DialogEntries(text: 'Comp Assessment'),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                color: AppColors.background.withOpacity(0.3),
                child: ListTile(
                  title: Text('Resident Name | Property'),
                  trailing: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DialogEntries extends StatelessWidget {
  final String? text;
  final Function? onpressed;

  const DialogEntries({this.text, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onpressed!();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.3),
            border: Border.all(
              color: Colors.white,
              width: 1,
            )),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(text!),
        ),
      ),
    );
  }
}
