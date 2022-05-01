import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lm_hod/Resources/AnnouncementMethods.dart';
import 'package:lm_hod/ReusableUtils/Appbar.dart';
import 'package:lm_hod/ReusableUtils/ExpandedTextForm.dart';
import 'package:lm_hod/ReusableUtils/HeightWidth.dart';
import 'package:lm_hod/ReusableUtils/Responsive.dart';
import 'package:lm_hod/ReusableUtils/TextFormField.dart';
import 'package:provider/provider.dart';
import '../../Models/Hod/HodModel.dart';
import '../../Providers/Hod provider/HodProvider.dart';
import '../../ReusableUtils/Colors.dart';
import '../../ReusableUtils/SnackBar.dart';
import 'package:intl/intl.dart';


class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  bool isLoading = false;
  bool isForStudents = false;
  bool isForStaff = false;
  @override
  void dispose(){
    super.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
  }
  void hodAnnouncement ({
      required String subject,
      required String body,
      required String isForStudents,
      required String isForStaff,
      required String date,
      required String announcerImage,
      required String announcerName,
  }) async {
    setState(() {
      isLoading = true;
    });
    String finalResult = await AnnouncementMethods().announcementHod(
        subject: subject,
        body: body,
        isStudent: isForStudents,
        isTeacher: isForStaff,
        date: date,
        announcerImage: announcerImage,
        announcerName: announcerName);
    if(finalResult == "success") {
      snackBar(content: "Announcement sent successfully", duration: 2000, context: context);
    }
    else{
      snackBar(content: finalResult, duration: 2000, context: context);
    }
    setState(() {
      isLoading = false;
    });
  }
  DateTime date = DateTime.now();
  var format = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    HodModel _hodModel = Provider
        .of<HodProvider>(context)
        .getHod;
    String formattedDate = format.format(date);
    print(formattedDate);
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
            verticalSpace(100, context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Students",
                  style: TextStyle(
                    fontSize: screenLayout(28, context),
                    color: secondaryColor,
                    fontWeight: FontWeight.w500
                  ),
                ),
                CupertinoSwitch(
                    value: isForStudents,
                    activeColor: secondaryColor2,
                    onChanged: (value){
                  setState(() {
                    isForStudents = value;
                    print(isForStudents);
                  });
                }),
                horizontalSpace(170, context),
                Text("Staff",
                  style: TextStyle(
                      fontSize: screenLayout(28, context),
                      color: secondaryColor,
                      fontWeight: FontWeight.w500
                  ),
                ),
                CupertinoSwitch(
                    value: isForStaff,
                    activeColor: secondaryColor2,
                    onChanged: (value){
                      setState(() {
                        isForStaff = value;
                        print(isForStaff);
                      });
                    }),
              ],
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
                    else if(isForStaff == false && isForStudents == false) {
                      snackBar(content: 'Please choose an audience for announcement', duration: 2000, context: context);
                    }
                    else {
                      hodAnnouncement(
                          subject: _subjectController.text,
                          body: _bodyController.text,
                          isForStudents: isForStudents.toString(),
                          isForStaff: isForStaff.toString(),
                          date: formattedDate,
                          announcerImage: _hodModel.imageUrl,
                          announcerName: _hodModel.fullName);
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
