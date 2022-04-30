import 'package:flutter/material.dart';
import 'package:lm_hod/ReusableUtils/Appbar.dart';

class StaffDismissal extends StatefulWidget {
  const StaffDismissal({Key? key}) : super(key: key);

  @override
  State<StaffDismissal> createState() => _StaffDismissalState();
}

class _StaffDismissalState extends State<StaffDismissal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Staff Dismissal'),
    );
  }
}
