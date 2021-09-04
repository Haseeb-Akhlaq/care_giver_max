import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget simpleAppBar(context, {String? title, Function? menuTap}) {
  return AppBar(
    title: AutoSizeText(title!, maxLines: 1),
    backgroundColor: Color(0xff788B91),
    centerTitle: true,
    leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        )),
    actions: [
      Row(
        children: [
          GestureDetector(
            onTap: () {
              menuTap!();
            },
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10),
        ],
      )
    ],
  );
}
