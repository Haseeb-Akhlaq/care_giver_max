import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/drawer.dart';
import 'package:caregiver_max/widgets/simple_appBar.dart';
import 'package:flutter/material.dart';

import 'manage_daily_medication_scrren.dart';
import 'setup_medication_details_screen.dart';

class MedicationActionCategoryScreen extends StatefulWidget {
  const MedicationActionCategoryScreen({Key? key}) : super(key: key);

  @override
  State<MedicationActionCategoryScreen> createState() =>
      _MedicationActionCategoryScreenState();
}

class _MedicationActionCategoryScreenState
    extends State<MedicationActionCategoryScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: AppDrawer(),
      appBar: simpleAppBar(context, title: 'Medication Administration Record',
          menuTap: () {
        _scaffoldKey.currentState!.openEndDrawer();
      }),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Container(
                color: AppColors.background.withOpacity(0.3),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetupMedicationDetailsScreen(),
                      ),
                    );
                  },
                  title: Text('Setup Medication Details'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
              SizedBox(height: 15),
              Container(
                color: AppColors.background.withOpacity(0.3),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageDailyMedicationScreen(),
                      ),
                    );
                  },
                  title: Text('Manage Daily Medication'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
