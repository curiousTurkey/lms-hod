

import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar ({required String content,required int duration,required BuildContext context} ){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content) , duration: Duration(milliseconds: duration),));
}