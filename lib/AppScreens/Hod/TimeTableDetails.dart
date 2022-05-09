import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lm_hod/Models/Hod/HodModel.dart';
import 'package:lm_hod/Providers/Hod%20provider/HodProvider.dart';
import 'package:lm_hod/ReusableUtils/Appbar.dart';
import 'package:lm_hod/ReusableUtils/Colors.dart' as color_mode;
import 'package:lm_hod/ReusableUtils/ListTile.dart';
import 'package:lm_hod/ReusableUtils/Responsive.dart' as resize;
import 'package:provider/provider.dart';

import '../../ReusableUtils/HeightWidth.dart';

class TimeTableDetails extends StatefulWidget {
  final String docId;
  const TimeTableDetails({
    Key? key,
    required this.docId,
  }) : super(key: key);

  @override
  State<TimeTableDetails> createState() => _TimeTableDetailsState();
}

class _TimeTableDetailsState extends State<TimeTableDetails> {
  @override
  Widget build(BuildContext context) {
    final Future<DocumentSnapshot<Map<String,dynamic>>> timetable = FirebaseFirestore.instance.collection('TimeTable').
    doc(widget.docId).get();
    TextStyle textStyle = TextStyle(
      color: color_mode.secondaryColor,
      fontSize: resize.screenLayout(30, context),
      fontWeight: FontWeight.w800,
    );
    return Scaffold(
      appBar: appBar(context: context, title: "Today's Time Table"),
      body: FutureBuilder(
          future: timetable,
          builder: (_, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong. Try again later.');
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: SpinKitFoldingCube(
                color: color_mode.secondaryColor,
                size: resize.screenLayout(80, context),
                duration: const Duration(milliseconds: 1500),
              ));
            }
            String hour1 = snapshot.data!['Subject 1'];
            String hour2 = snapshot.data!['Subject 2'];
            String hour3 = snapshot.data!['Subject 3'];
            String hour4 = snapshot.data!['Subject 4'];
            String hour5 = snapshot.data!['Subject 5'];

            return SingleChildScrollView(
              child: Container(
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
                          Text('Hour  1 :',
                              style: textStyle),
                          resize.horizontalSpace(20, context),
                          Text(hour1,
                              style: textStyle
                          ),
                        ],
                      ),
                      resize.verticalSpace(50, context),
                      Row(
                        children: [
                          resize.horizontalSpace(60, context),
                          Text('Hour  2 : ',
                            style: textStyle,
                          ),
                          resize.horizontalSpace(20, context),
                          Text(hour2,
                            style: textStyle,)
                        ],
                      ),
                      resize.verticalSpace(50, context),
                      Row(
                        children: [
                          resize.horizontalSpace(60, context),
                          Text('Hour  3 : ',
                            style: textStyle,
                          ),
                          resize.horizontalSpace(20, context),
                          LimitedBox(
                            maxWidth: resize.screenLayout(240, context),
                            child: Text(hour3,
                              style: textStyle,),
                          )
                        ],
                      ),
                      resize.verticalSpace(50, context),
                      Row(
                        children: [
                          resize.horizontalSpace(60, context),
                          Text('Hour  4 : ',
                            style: textStyle,
                          ),
                          resize.horizontalSpace(20, context),
                          LimitedBox(
                            maxWidth: resize.screenLayout(240, context),
                            child: Text(hour4,
                              style: textStyle,),
                          )
                        ],
                      ),
                      resize.verticalSpace(50, context),
                      Row(
                        children: [
                          resize.horizontalSpace(60, context),
                          Text('Hour  5 : ',
                            style: textStyle,
                          ),
                          resize.horizontalSpace(20, context),
                          Text(hour5,
                            style: textStyle,)
                        ],
                      ),
                      resize.verticalSpace(50, context),
                    ]
                ),
              ),
            );
          } //builder closing
      ),
    );
  }
}
