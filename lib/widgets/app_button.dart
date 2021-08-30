import 'package:caregiver_max/styles/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final Function? onTap;

  const AppButton({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(
          title!,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
