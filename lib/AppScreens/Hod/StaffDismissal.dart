import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lm_hod/ReusableUtils/Appbar.dart';
import 'package:lm_hod/ReusableUtils/HeightWidth.dart';
import 'package:lm_hod/ReusableUtils/Responsive.dart' as resize;
import 'package:lm_hod/ReusableUtils/Colors.dart' as color_mode;
import 'package:lm_hod/ReusableUtils/SnackBar.dart';
import 'package:provider/provider.dart';
import '../../Models/Hod/HodModel.dart';
import '../../Providers/Hod provider/HodProvider.dart';
import '../../ReusableUtils/Dialog.dart';
import '../../ReusableUtils/Responsive.dart';

class StaffDismissal extends StatefulWidget {
  const StaffDismissal({Key? key}) : super(key: key);

  @override
  State<StaffDismissal> createState() => _StaffDismissalState();
}

class _StaffDismissalState extends State<StaffDismissal> {

  @override
  Widget build(BuildContext context) {
    HodModel hodModel = Provider.of<HodProvider>(context).getHod;

    final Stream<QuerySnapshot> staff =
    FirebaseFirestore.instance.collection('users').
    where("usertype", isEqualTo: 'staff').
    where("dept", isEqualTo: hodModel.deptName).snapshots();

    return Scaffold(
      appBar: appBar(context: context, title: 'Staff Dismissal'),
      body: StreamBuilder<QuerySnapshot>(
        stream: staff,
        builder: (_,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasError) {
            return const Text('Something went wrong. Try again later.');
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
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
              itemBuilder: (_,int index){
                String name = snapshot.data!.docs[index]['name'];
                String semClassTeacher = snapshot.data!.docs[index]['semclassteacher'];
                String email = snapshot.data!.docs[index]['email'];
                String image = snapshot.data!.docs[index]['imageurl'];
                return ListTile(
                  minVerticalPadding: resize.screenLayout(50, context),
                  title: Text(name),
                  subtitle: Text(semClassTeacher),
                  leading: (image == "null")?Initicon(
                    borderRadius: BorderRadius.circular(
                        screenLayout(10, context)),
                    text: name,
                    size: resize.screenLayout(90, context),
                    elevation: 5,
                  ):Image.network(image ,
                    width: resize.screenLayout(90, context),
                    height: resize.screenLayout(100, context),),
                  trailing: TextButton(
                    style: TextButton.styleFrom(
                      enableFeedback: true,
                    ),
                      onPressed: () async {
                        await showDialog(
                            barrierColor: Colors.white70,
                            context: context,
                            builder: (BuildContext context){
                          return alertDialog(
                              title: 'Do you want to dismiss $name?',
                              onPressed: () async {
                                await FirebaseFirestore.instance.collection('users').doc(email).delete();
                                Navigator.pop(context);
                              },
                              button1: 'Cancel', button2: 'Dismiss',
                              context: context);
                        });
                      }, child: Text('Dismiss' ,
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
