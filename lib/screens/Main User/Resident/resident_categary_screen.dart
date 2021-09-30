import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'add_new_resident_screen.dart';
import 'display_resident_screen.dart';

class ResidentCategoryScreen extends StatefulWidget {
  const ResidentCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ResidentCategoryScreen> createState() => _ResidentCategoryScreenState();
}

class _ResidentCategoryScreenState extends State<ResidentCategoryScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Resident'),
        backgroundColor: Color(0xff788B91),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryItem(
                icon: Icons.apartment,
                text: 'Add Resident',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddResidentScreen(),
                    ),
                  );
                },
              ),
              CategoryItem(
                icon: Icons.contacts,
                text: 'Display Residents',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayResidentsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Function? onTap;

  const CategoryItem({this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Container(
            width: width * 0.65,
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 60,
                ),
                SizedBox(height: 20),
                AutoSizeText(
                  text!,
                  maxLines: 1,
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
