import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lm_hod/ReusableUtils/Colors.dart' as color_mode;
import 'package:lm_hod/ReusableUtils/Responsive.dart';

import '../HeightWidth.dart';


InkWell homeContainer({
  required BuildContext context,
  required String description,
  required String heading,
  required IconData icon,
  required VoidCallback onTap,
}) {
  double containerWidth = getWidth(context)/2 - screenLayout(20, context);
  return InkWell(
    customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            screenLayout(30, context))),
    splashColor: color_mode.spclColor2.withOpacity(.5),
    onTap: onTap,
    child: Container(
        height: screenLayout(270, context),
        width: containerWidth,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: color_mode.spclColor.withOpacity(.3))],
          borderRadius: BorderRadius.circular(
              screenLayout(30, context)),
          color: color_mode.primaryColor.withOpacity(.1),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenLayout(25,context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FaIcon(icon,color: color_mode.spclColor2.withOpacity(1),size: screenLayout(73, context),),
              Text(heading,
                style: TextStyle(
                  fontSize: screenLayout(25,context),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: color_mode.tertiaryColor,
                ),
              ),

              Text(description,
                style: TextStyle(
                  fontSize: screenLayout(20,context),
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.1,
                  color: color_mode.unImportant,
                ),
              ),
            ],
          ),
        )
    ),
  );
}

