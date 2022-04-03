import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lm_hod/AppScreens/HOD/LoginScreen.dart';
import 'package:lm_hod/AppScreens/HOD/MainPage.dart';
import 'package:lm_hod/Models/Hod/HodModel.dart';
import 'package:lm_hod/Providers/Hod%20provider/HodProvider.dart';
import 'package:lm_hod/ReusableUtils/Responsive.dart' as resize;
import 'package:lm_hod/ReusableUtils/Colors.dart'as color_mode;
import 'package:lm_hod/ReusableUtils/Side%20transition.dart';
import 'package:provider/provider.dart';
import 'package:lm_hod/Resources/HodAuthMethods.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState(){
    super.initState();
    nextPage();
  }
  Widget nextPageWidget = const LoginScreen();
  void nextPage() {
    if(_auth.currentUser != null){
      setState(() {
        nextPageWidget = const MainPage();
      });
    }
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, CustomPageRouteSide(child: nextPageWidget));
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
              filterQuality: FilterQuality.low,
              fit: BoxFit.fitHeight,
              image: AssetImage('assets/background/red.jpg'),
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
                children: [
                  Center(
                    child: SpinKitRipple(
                      size: resize.screenLayout(350, context),
                      color: color_mode.secondaryColor2,
                      borderWidth: resize.screenLayout(9, context),

                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: resize.screenLayout(75, context)),
                      child: Image.asset('assets/background/teacher.png',
                        width: resize.screenLayout(200, context),
                      ),
                    ),
                  ),
                ]
            ),
          ],
        ),
      ),
    );
  }
}
