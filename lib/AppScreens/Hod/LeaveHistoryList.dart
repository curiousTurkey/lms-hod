import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lm_hod/AppScreens/Hod/LeaveHistoryDetails.dart';
import 'package:lm_hod/ReusableUtils/Appbar.dart';
import 'package:lm_hod/ReusableUtils/SingleButtonAlert.dart';
import 'package:provider/provider.dart';
import 'package:lm_hod/ReusableUtils/Responsive.dart' as resize;
import 'package:lm_hod/ReusableUtils/Colors.dart' as color_mode;
import '../../Models/Hod/HodModel.dart';
import '../../Providers/Hod provider/HodProvider.dart';
import '../../ReusableUtils/Dialog.dart';
import '../../ReusableUtils/HeightWidth.dart';
import '../../ReusableUtils/Responsive.dart';

class LeaveHistoryList extends StatefulWidget {
  final String email;
  final String image;
   const LeaveHistoryList({Key? key, required this.email , required this.image}) : super(key: key);
  @override
  State<LeaveHistoryList> createState() => _LeaveHistoryListState();
}

class _LeaveHistoryListState extends State<LeaveHistoryList> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> leaveList = FirebaseFirestore.instance.collection('leave').where('email', isEqualTo: widget.email).snapshots();
    return Scaffold(
      appBar: appBar(context: context, title: 'Leave History List'),
      body: StreamBuilder<QuerySnapshot>(
        stream: leaveList,
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot){
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
          int itemCount = snapshot.data!.size;
          return ListView.builder(
              itemCount: itemCount,
              itemBuilder: (_, int index){
                String docId = snapshot.data!.docs[index].id;
                String name = snapshot.data!.docs[index]['fullname'];
                String subject = snapshot.data!.docs[index]['leavesub'];
                String reason = snapshot.data!.docs[index]['leavereason'];
                return ListTile(
                  minVerticalPadding: resize.screenLayout(50, context),
                  title: Text(subject),
                  leading: (widget.image == "null") ? Initicon(
                    borderRadius: BorderRadius.circular(
                        screenLayout(10, context)),
                    text: name,
                    size: resize.screenLayout(90, context),
                    elevation: 5,
                  ) : Image.network(widget.image,
                    width: resize.screenLayout(90, context),
                    height: resize.screenLayout(100, context),),
                  trailing: TextButton(
                      style: TextButton.styleFrom(
                        enableFeedback: true,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => LeaveHistoryDetails(docId: docId)));
                      },
                      child: Text('Show Details',
                        style: TextStyle(color: color_mode.secondaryColor),
                      )),
                );
          });
        },
      ),
    );
  }
}

