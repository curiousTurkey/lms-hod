import 'Package:lm_hod/ReusableUtils/Colors.dart' as color_mode;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lm_hod/ReusableUtils/HeightWidth.dart' as heightwidth;
import 'package:lm_hod/ReusableUtils/Responsive.dart' as resize;

AppBar appBar ({
  required BuildContext context,
  required String title
}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: color_mode.secondaryColor,
    title: Text(title,
      style: TextStyle(
          color: color_mode.primaryColor,
          fontSize: resize.screenLayout(30, context)
      ),
    ),
  );
}