import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lm_hod/ReusableUtils/HeightWidth.dart';
import 'package:lm_hod/ReusableUtils/Responsive.dart' as resize;
import 'package:lm_hod/ReusableUtils/Colors.dart' as color_mode;

class LeaveApplicants extends StatefulWidget {
  const LeaveApplicants({Key? key}) : super(key: key);

  @override
  State<LeaveApplicants> createState() => _LeaveApplicantsState();
}

class _LeaveApplicantsState extends State<LeaveApplicants> {

  late int itemCount;
  final Stream<QuerySnapshot> leaveApplicants = FirebaseFirestore.instance.collection('leave').where('isapproved',isEqualTo: 'no').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color_mode.secondaryColor,
        title: Text('Leave Applicants',
          style: TextStyle(
              color: color_mode.primaryColor,
              fontSize: resize.screenLayout(30, context)
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: leaveApplicants,
          builder: (_,AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong. Try again later.');
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text('Loading...'));
            }
            final data = snapshot.requireData;
            final length = snapshot.data!.size;
            return ListView.builder(
              itemCount: length,
              itemBuilder: (BuildContext context, int index) {
                String name = snapshot.data!.docs[index]["fullname"];
                String dept = snapshot.data!.docs[index]["dept"];
                String session2 = snapshot.data!.docs[index]["session2"];
                String fromDate = snapshot.data!.docs[index]["fromdate"];
                String toDate = snapshot.data!.docs[index]["todate"];
                int casualLeaveTaken = snapshot.data!.docs[index]["casualleavetaken"];
                String email = snapshot.data!.docs[index]["email"];
                String leaveReason = snapshot.data!.docs[index]["leavereason"];
                String session1 = snapshot.data!.docs[index]["session1"];
                String leavesub = snapshot.data!.docs[index]["leavesub"];
                return ListTile(
                  minVerticalPadding: resize.screenLayout(20, context),
                  title: Text(name),
                  onTap: () => navigateToDetail(name,dept,session2,session1,fromDate,toDate,casualLeaveTaken,email,leaveReason,leavesub),
                );
              },
            );
          }
      ),
    );
  }

  navigateToDetail(String name,
      String dept,
      String session2,
      String session1,
      String fromDate,
      String toDate,
      int casualLeaveTaken,
      String email,
      String leaveReason,
      String leavesub) {
      int days ;
      DateTime parseFromDate = DateTime.parse(fromDate);
      DateTime parseToDate = DateTime.parse(toDate);
      days = parseToDate.difference(parseFromDate).inDays;
      days++;
    Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(
      name: name,
      dept: dept,
      session2: session2,
      fromDate: fromDate,
      toDate: toDate,
      casualLeaveTaken: casualLeaveTaken,
      email: email,
      leavereason: leaveReason,
      session1: session1,
      leavesub: leavesub, days: days,
      
    )));
  }
}

class DetailPage extends StatefulWidget {
  final String name;
  final String email;
  final String leavereason;
  final String leavesub;
  final String session1;
  final String session2;
  final String fromDate;
  final String toDate;
  final String dept;
  final int casualLeaveTaken;
  final int days ;
  const DetailPage({Key? key,
    required this.name,
    required this.email,
    required this.leavereason,
    required this.leavesub,
    required this.session1,
    required this.session2,
    required this.fromDate,
    required this.toDate,
    required this.dept,
    required this.casualLeaveTaken, required this.days,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}


class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        color: color_mode.secondaryColor,
        fontSize: resize.screenLayout(30, context),
        fontWeight: FontWeight.w800,

    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color_mode.secondaryColor,
        title: Text('Leave Applicant Details',
          style: TextStyle(
            color: color_mode.primaryColor,
            fontSize: resize.screenLayout(30, context),

          )
        ),
      ),
      body: Container(
        width: getWidth(context),
        height: getHeight(context),
        decoration: BoxDecoration(
          color: color_mode.primaryColor
        ),
        child: Column(
          children: [
            resize.verticalSpace(80, context),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                resize.horizontalSpace(60, context),
                Text('Name :',
                style: textStyle),
                resize.horizontalSpace(20, context),
                Text(widget.name,
                  style: textStyle
                ),
              ],
            ),
            resize.verticalSpace(50, context),
            Row(
              children: [
                resize.horizontalSpace(60, context),
                Text('E-mail : ',
                  style: textStyle,
                ),
                resize.horizontalSpace(20, context),
                Text(widget.email,
                  style: textStyle,)
              ],
            ),
            resize.verticalSpace(50, context),
            Row(
              children: [
                resize.horizontalSpace(60, context),
                Text('Leave Subject : ',
                  style: textStyle,
                ),
                resize.horizontalSpace(20, context),
                Text(widget.leavesub,
                style: textStyle,)
              ],
            ),
            resize.verticalSpace(50, context),
            Row(
              children: [
                resize.horizontalSpace(60, context),
                Text('Leave Reason : ',
                  style: textStyle,
                ),
                resize.horizontalSpace(20, context),
                Text(widget.leavereason,
                  style: textStyle,)
              ],
            ),
            resize.verticalSpace(50, context),
            Row(
              children: [
                resize.horizontalSpace(60, context),
                Text('Department : ',
                  style: textStyle,
                ),
                resize.horizontalSpace(20, context),
                Text(widget.dept,
                  style: textStyle,)
              ],
            ),
            resize.verticalSpace(50, context),
            Row(
              children: [
                resize.horizontalSpace(60, context),
                Text('From Date : ',
                  style: textStyle,
                ),
                resize.horizontalSpace(20, context),
                Text(DateTime.parse(widget.fromDate).toString(),
                  style: textStyle,)
              ],
            ),
            resize.verticalSpace(50, context),
            Row(
              children: [
                resize.horizontalSpace(60, context),
                Text('To Date : ',
                  style: textStyle,
                ),
                resize.horizontalSpace(20, context),
                Text(DateTime.parse(widget.toDate).toString(),
                  style: textStyle,)
              ],
            ),
            resize.verticalSpace(50, context),
            Row(
              children: [
                resize.horizontalSpace(60, context),
                Text('From Session : ',
                  style: textStyle,
                ),
                resize.horizontalSpace(20, context),
                Text(widget.session1,
                  style: textStyle,)
              ],
            ),
            resize.verticalSpace(50, context),
            Row(
              children: [
                resize.horizontalSpace(60, context),
                Text('To Session : ',
                  style: textStyle,
                ),
                resize.horizontalSpace(20, context),
                Text(widget.session2,
                  style: textStyle,)
              ],
            ),
            resize.verticalSpace(50, context),
            Row(
              children: [
                resize.horizontalSpace(60, context),
                Text('Total Days : ',
                  style: textStyle,
                ),
                resize.horizontalSpace(20, context),
                Text(widget.days.toString(),
                  style: textStyle,)
              ],
            ),
            resize.verticalSpace(100, context),
            //text buttons 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    primary: color_mode.primaryColor,
                    backgroundColor: Colors.green,
                  ),
                    onPressed: (){},
                    child: Text('Approve Leave',
                      style: TextStyle(color: color_mode.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: resize.screenLayout(29, context)
                      ),
                    ),),
                //reject button
                TextButton(
                  style: TextButton.styleFrom(
                    primary: color_mode.primaryColor,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: (){},
                  child: Text('Reject Leave',
                    style: TextStyle(color: color_mode.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: resize.screenLayout(29, context)
                    ),
                  ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}




