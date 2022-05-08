
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lm_hod/ReusableUtils/Colors.dart';
import 'package:lm_hod/ReusableUtils/Heightwidth.dart' as height_width;
import 'package:lm_hod/ReusableUtils/Responsive.dart';
import '../Colors.dart';
import '../Responsive.dart';
import '../SnackBar.dart';
import '../TextFormField.dart';


dialogBox(BuildContext context,String title,Container content) async {
  await showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
            backgroundColor: primaryColor,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),

            title: Center(child: Text(title,
              style: TextStyle(
                fontSize: screenLayout(38, context),
                fontWeight: FontWeight.bold,
              ),
            )),
            content: content
        );
      }
  );
}

Container updateDetails(BuildContext context,
    TextEditingController textEditingController,
    Icon prefixIcon,
    String labelText,
    TextInputType textInputType,
    String hintText,
    VoidCallback onPressed,
    ){
  return Container(
      height: height_width.getHeight(context)/3,
      width: height_width.getWidth(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(screenLayout(40, context))),
      ),
      child: Column(
        children: [
          Padding(
            padding:EdgeInsets.only(bottom: screenLayout(20, context)),
            child: Container(
              height: screenLayout(3, context),
              width: height_width.getWidth(context)/3,
              decoration: BoxDecoration(
                  color: secondaryColor
              ),
            ),
          ),
          SizedBox(height: screenLayout(50, context),),
          TextForm(textEditingController:
          textEditingController,
              prefixIcon: prefixIcon,
              textInputType: textInputType,
              labelText: labelText,
              hintText: hintText),
          SizedBox(height: screenLayout(55, context),),
          Container(
            height: screenLayout(80, context),
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(screenLayout(20, context)))
            ),
            child: FloatingActionButton(
              backgroundColor: secondaryColor,
              onPressed: onPressed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenLayout(25, context)),
              ),
              child: const Text("Update"),
            ),
          )
        ],
      )
  );
}

