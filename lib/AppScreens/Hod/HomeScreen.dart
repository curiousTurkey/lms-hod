import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lm_hod/Models/Hod/HodModel.dart';
import 'package:lm_hod/Providers/Hod%20provider/HodProvider.dart';
import 'package:lm_hod/ReusableUtils/Colors.dart' as color_mode;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lm_hod/AppScreens/HOD/LoginScreen.dart';
import 'package:lm_hod/Resources/HodAuthMethods.dart';
import 'package:lm_hod/ReusableUtils/Side transition.dart';
import 'package:lm_hod/ReusableUtils/Heightwidth.dart' as height_width;
import 'package:lm_hod/ReusableUtils/Responsive.dart' as resize;

import 'package:provider/provider.dart';

import '../../ReusableUtils/SideBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  addHodData() async {
    HodProvider _hodProvider = Provider.of(context,listen: false);
    await _hodProvider.refreshHod();
  }
  @override
  void initState(){
    if(mounted) {
      super.initState();
      addHodData();
    }
  }
  @override
  void dispose(){
    super.dispose();
  }
  void logoutHod() async{
    String finalResult = await AuthMethods().logoutHod();
    if(finalResult == "success"){
      Navigator.pushReplacement(context, CustomPageRouteSide(child: const LoginScreen()));
    }
  }
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    HodModel hodModel = Provider.of<HodProvider>(context).getHod;
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        drawer: const SideBar(),
        backgroundColor: color_mode.primaryColor,
        body: Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.menu_rounded),
                onPressed: () {
                  _globalKey.currentState?.openDrawer();
                },),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("Welcome " + hodModel.fullName)),
                  FloatingActionButton(onPressed: logoutHod,child: const Text('Logout'),),
                ],
              ),
            ]
        ),
      ),
    );
  }
}

