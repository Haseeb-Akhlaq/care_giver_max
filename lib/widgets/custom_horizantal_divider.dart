import 'package:flutter/material.dart';

class CustomHorizontalDivider extends StatelessWidget {
  CustomHorizontalDivider({required this.thickness});
  final double thickness;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Divider(
        color: Colors.grey.shade200,
        height: 0,
        thickness: thickness,
      ),
    );
  }
}
