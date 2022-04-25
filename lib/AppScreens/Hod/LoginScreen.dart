
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lm_hod/AppScreens/HOD/MainPage.dart';
import 'package:lm_hod/AppScreens/HOD/SignupScreen.dart';
import 'package:lm_hod/Resources/HodAuthMethods.dart';
import 'package:lm_hod/ReusableUtils/Responsive.dart' as resize;
import 'package:lm_hod/ReusableUtils/Side%20transition.dart';
import '../../ReusableUtils/SnackBar.dart';
import 'Package:lm_hod/ReusableUtils/Colors.dart' as color_mode;
import 'package:lm_hod/ReusableUtils/HeightWidth.dart' as heightwidth;
import 'package:lm_hod/ReusableUtils/TextFormField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// void check() async {
//   DocumentSnapshot snapshot = await _firestore.collection('users').doc('arya1@gmail.com').get();
//   if(snapshot.exists){
//     String data = (snapshot.data() as Map<String,dynamic>)['name'];
//     print(data);
//   }
// }

 void loginHod() async {
    setState(() {
      isLoading = true;
    });
    String finalResult = await AuthMethods().loginHod(
        emailAddress: _emailController.text,
        password: _passwordController.text, userType: 'hod');
    if(finalResult == "success"){
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(context, CustomPageRouteSide(child: const MainPage()));
    }
    else {
      setState(() {
        isLoading = false;
      });
      snackBar(content: finalResult, duration: 1500, context: context);
    }
 }
  @override
  void dispose(){
      super.dispose();
      _emailController.dispose();
      _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color_mode.primaryColor,
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/background/bg.jpg'))),
      height: double.maxFinite,
      width: double.maxFinite,
      child: SingleChildScrollView(
        physics: (MediaQuery.of(context).viewInsets.bottom != 0)
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom:resize.screenLayout(70, context),left: resize.screenLayout(50, context)),
              child: Text(
                'LMS - HoD',
                style: TextStyle(
                  letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    color: color_mode.secondaryColor,
                  fontSize: resize.screenLayout(45, context)
                ),
              ),
            ),
            resize.verticalSpace(70, context),
            Container(
              height: heightwidth.getHeight(context) / 1.9,
              width: heightwidth.getWidth(context) / 1.1,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(resize.screenLayout(50, context)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white10,
                      blurStyle: BlurStyle.normal,
                      blurRadius: 4,
                    ),
                  ],
                  color: color_mode.primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextForm(
                      textEditingController: _emailController,
                      prefixIcon: const Icon(Icons.alternate_email_outlined),
                      textInputType: TextInputType.emailAddress,
                      labelText: 'E-mail',
                      hintText: 'Provide E-mail'),
                  resize.verticalSpace(25, context),
                  TextForm(
                      textEditingController: _passwordController,
                      prefixIcon: const Icon(Icons.lock_rounded),
                      textInputType: TextInputType.visiblePassword,
                      labelText: 'Password',
                      isPass:true,
                      hintText: 'Min 6 characters'),
                  resize.verticalSpace(40, context),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: resize.screenLayout(25, context),horizontal: resize.screenLayout(25, context)),
                    width: double.infinity,
                    child: FloatingActionButton(
                      onPressed: () {
                        if(_emailController.text.isNotEmpty || _passwordController.text.isNotEmpty){
                          loginHod();
                        }
                        else{
                          snackBar(content: 'Please provide all fields.', duration: 1500, context: context);
                        }
                      },
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(resize.screenLayout(25, context)),
                      ),
                      backgroundColor: color_mode.secondaryColor,
                      enableFeedback: true,
                      child: (isLoading==false)?Text('Log In',
                        style: TextStyle(
                          fontSize: resize.screenLayout(26, context),
                          fontWeight: FontWeight.w500,
                        ),
                      ):SpinKitCircle(
                        color: color_mode.primaryColor,
                        size: resize.screenLayout(50, context),
                      ),
                      ),
                    ),
                  resize.verticalSpace(25, context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have account?",
                        style: TextStyle(
                          color: color_mode.tertiaryColor
                        ),
                      ),
                      resize.horizontalSpace(10, context),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, CustomPageRouteSide(child: const SignupScreen()));
                        },
                        splashColor: color_mode.secondaryColor2,
                        child: Text('Sign Up',
                          style: TextStyle(
                              fontSize: resize.screenLayout(28, context),
                              color: color_mode.spclColor2,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: resize.screenLayout(40, context),),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
