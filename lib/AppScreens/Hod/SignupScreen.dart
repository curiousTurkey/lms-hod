import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lm_hod/AppScreens/HOD/LoginScreen.dart';
import 'package:lm_hod/Resources/HodAuthMethods.dart';
import 'package:lm_hod/ReusableUtils/Responsive.dart' as resize;
import 'package:lm_hod/ReusableUtils/Side%20transition.dart';
import 'package:lm_hod/ReusableUtils/SnackBar.dart';
import '../../ReusableUtils/TextFormField.dart';
import 'MainPage.dart';
import 'Package:lm_hod/ReusableUtils/Colors.dart' as color_mode;
import 'package:lm_hod/ReusableUtils/HeightWidth.dart' as heightwidth;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  bool isLoading = false;

  void signupHod() async {
    setState(() {
      isLoading = true;
    });
    String finalResult = await AuthMethods().signupHod(
        fullName: _fullNameController.text,
        emailAddress: _emailController.text,
        password: _passwordController.text,
        contactNo: _contactNoController.text,
        deptName: value);

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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String value="Select Department";
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _contactNoController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
  }
 DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(value: item, child: Text(item),);
  final List<String> listItem = ['Select Department','Computer Applications'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color_mode.primaryColor,
            image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/background/background.jpg'))),
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              resize.verticalSpace(0, context),
              Container(
                margin: EdgeInsets.all(resize.screenLayout(10, context)),
                child: Text(
                  'LMS - Hod \n   Sign Up',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color_mode.secondaryColor,
                      fontSize: resize.screenLayout(40, context)),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: heightwidth.getHeight(context) / 1.9,
                  width: heightwidth.getWidth(context) -
                      resize.screenLayout(47, context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(resize.screenLayout(40, context)),
                        topRight:
                            Radius.circular(resize.screenLayout(40, context)),
                        bottomLeft:
                            Radius.circular(resize.screenLayout(40, context)),
                        bottomRight:
                            Radius.circular(resize.screenLayout(40, context)),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white10,
                          blurStyle: BlurStyle.normal,
                          blurRadius: 4,
                        ),
                      ],
                      color: color_mode.spclColor.withOpacity(.45)),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      TextForm(
                          textEditingController: _fullNameController,
                          prefixIcon: const Icon(Icons.person_outline_outlined),
                          textInputType: TextInputType.name,
                          labelText: 'Name',
                          hintText: 'ex John Cena'),
                      resize.verticalSpace(20, context),
                      TextForm(
                          textEditingController: _emailController,
                          prefixIcon:
                              const Icon(Icons.alternate_email_outlined),
                          textInputType: TextInputType.emailAddress,
                          labelText: 'E-mail',
                          hintText: 'Provide E-mail'),
                      resize.verticalSpace(20, context),
                      TextForm(
                          textEditingController: _passwordController,
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          textInputType: TextInputType.visiblePassword,
                          labelText: 'Password',
                          isPass: true,
                          hintText: 'Min 6 characters'),
                      resize.verticalSpace(20, context),
                      TextForm(
                          textEditingController: _confirmPasswordController,
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          textInputType: TextInputType.visiblePassword,
                          labelText: 'Confirm Password',
                          isPass: true,
                          hintText: 'Retype password'),
                      resize.verticalSpace(20, context),
                      TextForm(
                          textEditingController: _contactNoController,
                          prefixIcon: const Icon(Icons.phone_android_outlined),
                          textInputType: TextInputType.number,
                          labelText: 'Contact No',
                          hintText: 'ex 9192936785'),
                      //need to add dept
                      resize.verticalSpace(20, context),
                      Container(
                        height: resize.screenLayout(70, context),
                        padding: EdgeInsets.all(resize.screenLayout(10, context)),
                        decoration: const BoxDecoration(
                        ),
                        child: DropdownButton<String>(
                          focusColor: color_mode.secondaryColor2,
                          enableFeedback: true,
                          hint: const Text('Select Department'),
                          isExpanded: true,
                          isDense: true,
                          items: listItem.map(buildMenuItem).toList(),
                          value: value,
                          onChanged: (value) => setState(() => this.value=value!),
                        ),
                      )
                     ]
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: resize.screenLayout(25, context),
                    horizontal: resize.screenLayout(25, context)),
                width: double.infinity,
                child: FloatingActionButton(
                    onPressed: () {
                      if(_emailController.text.isEmpty||
                          _passwordController.text.isEmpty ||
                          _fullNameController.text.isEmpty ||
                          _contactNoController.text.isEmpty ||
                          _confirmPasswordController.text.isEmpty ||
                          value.isEmpty
                      ){
                        snackBar(content: 'Provide all fields', duration: 1500, context: context);
                      }
                      else if(_passwordController.text != _confirmPasswordController.text){
                        snackBar(content: 'Confirm password mismatch', duration: 1500, context: context);
                      }
                      else {
                        signupHod();
                      }
                    },
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          resize.screenLayout(25, context)),
                    ),
                    backgroundColor: color_mode.secondaryColor,
                    enableFeedback: true,
                    child: (isLoading==false)?Text('Sign Up',
                      style: TextStyle(
                        fontSize: resize.screenLayout(26, context),
                        fontWeight: FontWeight.w500,
                      ),
                    ):SpinKitCircle(
                      color: color_mode.primaryColor,
                      size: resize.screenLayout(50, context),
                    ),
                    )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have account?",
                    style: TextStyle(color: color_mode.unImportant),
                  ),
                  resize.horizontalSpace(10, context),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          CustomPageRouteSide(child: const LoginScreen()));
                    },
                    splashColor: color_mode.secondaryColor2,
                    child: Text(
                      'Log in',
                      style: TextStyle(
                          fontSize: resize.screenLayout(28, context),
                          color: color_mode.secondaryColor2,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  resize.verticalSpace(100, context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
