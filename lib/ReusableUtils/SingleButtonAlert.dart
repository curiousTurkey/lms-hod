import 'package:flutter/material.dart';
import 'package:lm_hod/ReusableUtils/Colors.dart' as color_mode;
import 'package:lm_hod/ReusableUtils/Responsive.dart' as resize;

Widget alertDialogSingleButton({required String title,
  required VoidCallback onPressed,
  required String button1,
  required BuildContext context}){
  return AlertDialog(
    backgroundColor: color_mode.primaryColor,
    elevation: 20,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
    ),
    title: Text(title,
      style: TextStyle(
        color:  color_mode.unImportant,
        fontSize: resize.screenLayout(25, context),
        fontWeight: FontWeight.w700,
      ),
    ),
    actions: [
      TextButton(onPressed: () async {
        onPressed();
      }, child: Text(button1,
        style: TextStyle(
            color: color_mode.secondaryColor2,
            fontWeight: FontWeight.w500
        ),
      ),)
    ],
  );
}