import 'package:flutter/material.dart';
import 'package:lm_hod/ReusableUtils/Responsive.dart' as resize;
import 'Package:lm_hod/ReusableUtils/Colors.dart' as color_mode;
import 'package:form_field_validator/form_field_validator.dart';

class TextForm extends StatelessWidget {
  final bool isPass;
  final TextEditingController textEditingController;
  final Icon prefixIcon;
  final TextInputType textInputType;
  final String labelText;
  final String hintText;

  final bool isEmail;
  const TextForm({Key? key,
    required this.textEditingController,
    required this.prefixIcon,
    required this.textInputType,
    this.isPass = false,
    this.isEmail = false,
    required this.labelText,required this.hintText,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UnderlineInputBorder focusedBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: color_mode.secondaryColor)
    );
    UnderlineInputBorder inputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: color_mode.secondaryColor)
    );
    return Theme(
      data: Theme.of(context).copyWith(colorScheme: ThemeData().colorScheme.copyWith(primary: color_mode.secondaryColor)),
      child: TextFormField(
        validator: MultiValidator([
          EmailValidator(errorText: 'Provide valid email'),
          RequiredValidator(errorText: 'Required Field'),
          MinLengthValidator(6, errorText: 'Require 6 characters'),
        ]),
        controller: textEditingController,
        decoration: InputDecoration(
          focusColor: color_mode.secondaryColor,
          focusedBorder: focusedBorder,
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: color_mode.unImportant,fontSize: 12),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.all(resize.screenLayout(20, context)),
          border: focusedBorder,
          prefixIconColor: color_mode.tertiaryColor,
          labelStyle: TextStyle(color: color_mode.secondaryColor,fontSize: 15,fontWeight: FontWeight.w500),
        ),
        keyboardType: textInputType,
        obscureText: isPass,
        enableSuggestions: !isPass,
        enableInteractiveSelection: !isPass,
        autovalidateMode: AutovalidateMode.disabled,
      ),
    );
  }
}
