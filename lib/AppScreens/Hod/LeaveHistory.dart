import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lm_hod/AppScreens/Hod/LeaveHistoryList.dart';
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

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({Key? key}) : super(key: key);

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    HodModel hodModel = Provider
        .of<HodProvider>(context)
        .getHod;
    final Stream<QuerySnapshot> staff =
    FirebaseFirestore.instance.collection('users').
    where("usertype", isEqualTo: 'staff').
    where("dept", isEqualTo: hodModel.deptName).snapshots();

    return Scaffold(
      appBar: appBar(context: context, title: 'Staff Leave History'),
      body: StreamBuilder<QuerySnapshot>(
        stream: staff,
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          final data = snapshot.requireData;
          final itemCount = snapshot.data!.size;
          return ListView.builder(
            itemCount: itemCount,
            itemBuilder: (_, int index) {
              String name = snapshot.data!.docs[index]['name'];
              String semClassTeacher = snapshot.data!
                  .docs[index]['semclassteacher'];
              String email = snapshot.data!.docs[index]['email'];
              String image = snapshot.data!.docs[index]['imageurl'];
              return ListTile(
                minVerticalPadding: resize.screenLayout(50, context),
                title: Text(name),
                subtitle: Text(semClassTeacher),
                leading: (image == "null") ? Initicon(
                  borderRadius: BorderRadius.circular(
                      screenLayout(10, context)),
                  text: name,
                  size: resize.screenLayout(90, context),
                  elevation: 5,
                ) : Image.network(image,
                  width: resize.screenLayout(90, context),
                  height: resize.screenLayout(100, context),),
                trailing: TextButton(
                    style: TextButton.styleFrom(
                      enableFeedback: true,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LeaveHistoryList(
                        email : email,
                        image: image,
                      )));
                    },
                    child: Text('Show History',
                      style: TextStyle(color: color_mode.secondaryColor),
                    )),
              );
            },
          );
        },
      ),
    );
  }
}



