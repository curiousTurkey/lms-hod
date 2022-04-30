import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lm_hod/ReusableUtils/Appbar.dart';
import 'package:lm_hod/ReusableUtils/ExpandedTextForm.dart';
import 'package:lm_hod/ReusableUtils/HeightWidth.dart';
import 'package:lm_hod/ReusableUtils/Responsive.dart';
import 'package:lm_hod/ReusableUtils/TextFormField.dart';

import '../../ReusableUtils/Colors.dart';
import '../../ReusableUtils/SnackBar.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Announcement'),
      body: SingleChildScrollView(
        physics: (MediaQuery.of(context).viewInsets.bottom != 0)
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            verticalSpace(100, context),
            SizedBox(
              width: getWidth(context)-screenLayout(20, context),
              child: TextForm(
                  textEditingController: _subjectController,
                  prefixIcon: const Icon(Icons.notifications_rounded),
                  textInputType: TextInputType.text,
                  labelText: 'Subject',
                  hintText: 'Announcement Subject'),
            ),
            verticalSpace(40, context),
            SizedBox(
              width: getWidth(context)-screenLayout(20, context),
              child: ExpandedTextForm(
                  textEditingController: _bodyController,
                  prefixIcon: const Icon(Icons.text_fields_rounded),
                  textInputType: TextInputType.text,
                  labelText: 'Details',
                  hintText: 'Details of announcement'),
            ),
            verticalSpace(300, context),
            Container(
                padding: EdgeInsets.symmetric(
                    vertical: screenLayout(25, context),
                    horizontal: screenLayout(25, context)),
                width: double.infinity,
                child: FloatingActionButton(
                  onPressed: () {
                    if(_subjectController.text.isEmpty||
                        _bodyController.text.isEmpty
                    ){
                      snackBar(content: 'Provide all fields', duration: 1500, context: context);
                    }
                    else {
                    }
                  },
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        screenLayout(25, context)),
                  ),
                  backgroundColor: secondaryColor,
                  enableFeedback: true,
                  child: (isLoading==false)?Text('Announce !',
                    style: TextStyle(
                      fontSize: screenLayout(26, context),
                      fontWeight: FontWeight.w500,
                    ),
                  ):SpinKitCircle(
                    color: primaryColor,
                    size: screenLayout(50, context),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
