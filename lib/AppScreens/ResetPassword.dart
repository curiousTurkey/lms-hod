import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../ReusableUtils/Colors.dart';
import '../ReusableUtils/HeightWidth.dart';
import '../ReusableUtils/Responsive.dart';
import '../ReusableUtils/SnackBar.dart';
import '../ReusableUtils/TextFormField.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _resetEmail = TextEditingController();

  void resetPassword(String email) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.sendPasswordResetEmail(email: email);
    snackBar(content: 'Please check your email inbox for reset instructions.', duration: 4000, context: context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenLayout(130, context),
            ),
            Center(
              child: SizedBox(
                width: getWidth(context)-screenLayout(40, context),
                child: TextForm(
                    textEditingController: _resetEmail,
                    prefixIcon: const Icon(Icons.alternate_email_rounded),
                    textInputType: TextInputType.emailAddress,
                    labelText: 'E-mail',
                    hintText: 'example@gmail.com'),
              ),
            ),
            SizedBox(
              height: screenLayout(30, context),
            ),
            Row(
              children: [
                SizedBox(width: screenLayout(25, context)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: spclColor2,
                  ), onPressed: () {
                  resetPassword(_resetEmail.text);
                  Navigator.pop(context);
                },
                  child: Text('Reset',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: screenLayout(28, context),
                      fontWeight: FontWeight.w700,

                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
