import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lm_hod/AppScreens/Hod/SplashScreen.dart';
import 'package:lm_hod/Providers/Hod%20provider/HodProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); //portrait mode only
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HodProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context,snapShot){
            if(snapShot.connectionState == ConnectionState.active){
              if(snapShot.hasData){
                return const SplashScreen();
              }
              else if(snapShot.hasError){
                return Scaffold(
                  body: Center(
                    child: Text(snapShot.error.toString()),
                  ),
                );
              }
            }
            if(snapShot.connectionState == ConnectionState.waiting){
              return const SplashScreen();
            }
            return const SplashScreen();
          },
        )
      ),
    );
  }
}


