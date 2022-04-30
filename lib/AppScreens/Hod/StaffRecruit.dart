import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lm_hod/AppScreens/HOD/LoginScreen.dart';
import 'package:lm_hod/Resources/HodAuthMethods.dart';
import 'package:lm_hod/Resources/StaffAuthMethods.dart';
import 'package:lm_hod/ReusableUtils/Responsive.dart' as resize;
import 'package:lm_hod/ReusableUtils/Side%20transition.dart';
import 'package:lm_hod/ReusableUtils/SnackBar.dart';
import '../../ReusableUtils/TextFormField.dart';
import 'MainPage.dart';
import 'Package:lm_hod/ReusableUtils/Colors.dart' as color_mode;
import 'package:lm_hod/ReusableUtils/HeightWidth.dart' as heightwidth;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StaffRecruit extends StatefulWidget {
  const StaffRecruit({Key? key}) : super(key: key);

  @override
  State<StaffRecruit> createState() => _StaffRecruitState();
}

class _StaffRecruitState extends State<StaffRecruit> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  bool isLoading = false;
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(value: item, child: Text(item),);
  final List<String> listItem = ['Select Department','Computer Applications'];
  final List<String> semList = ['Select Semester','1st Sem','2nd Sem','3rd Sem','4th Sem','5th Sem','6th sem'];
  String value="Select Department";
  String semValue = "Select Semester";
  bool isChecked = false;

  //function to recruit staff

  void recruitStaff() async {
    String semester = "null";
    setState(() {
      isLoading = true;
    });
    print(isChecked);
    print(semValue);
    bool isClassTeacher = isChecked;
    if(semValue == "Select Semester"){
      semester = "null";
    }
    else{
      semester = semValue;
    }
    print(isClassTeacher);
    print(semester);
    String finalResult = await StaffAuthMethod().createStaff(
        fullName: _fullNameController.text,
        emailAddress: _emailController.text,
        password: _passwordController.text,
        isClassTeacher: isClassTeacher,
        whichSem: semester,
        deptName: value);
    if(finalResult == "success"){
      setState(() {
        isLoading = false;
        snackBar(content: 'Staff Added Successfully', duration: 1500, context: context);
        Navigator.pushReplacement(context, CustomPageRouteSide(child: const MainPage()));
      });
    }
    else{
      setState(() {
        isLoading = false;
        snackBar(content: finalResult, duration: 2000, context: context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color_mode.secondaryColor,
        title: Text('Staff Recruit',
          style: TextStyle(
            color: color_mode.primaryColor,
            fontSize: resize.screenLayout(30, context)
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color_mode.primaryColor,
            image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/background/bg.jpg'))
        ),
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              resize.verticalSpace(0, context),
              SingleChildScrollView(
                physics: (MediaQuery.of(context).viewInsets.bottom != 0)
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.all(resize.screenLayout(10, context)),
                  child: Text(
                    ' LMS - Staff  \nRecruitment',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color_mode.secondaryColor,
                        fontSize: resize.screenLayout(40, context)),
                  ),
                ),
              ),
              resize.verticalSpace(20, context),
              SingleChildScrollView(
                child: Container(
                  height: heightwidth.getHeight(context) / 1.9,
                  width: heightwidth.getWidth(context) -
                      resize.screenLayout(47, context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft:
                        Radius.circular(resize.screenLayout(20, context)),
                        topRight:
                        Radius.circular(resize.screenLayout(20, context)),
                        bottomLeft:
                        Radius.circular(resize.screenLayout(20, context)),
                        bottomRight:
                        Radius.circular(resize.screenLayout(20, context)),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white10,
                          blurStyle: BlurStyle.normal,
                          blurRadius: 4,
                        ),
                      ],
                      color: color_mode.spclColor),
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
                        Row(
                          children: [
                            Checkbox(
                              activeColor: color_mode.secondaryColor,
                                hoverColor: color_mode.spclColor,
                                checkColor: color_mode.primaryColor,
                                value: isChecked, onChanged: (bool? value){
                              setState(() {
                                isChecked = value!;
                                print(isChecked);
                              });
                            }),
                            SizedBox(width: resize.screenLayout(0, context),),
                            Text('Class Teacher',
                              style: TextStyle(
                                color: color_mode.secondaryColor,
                                fontSize: resize.screenLayout(30, context),
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: resize.screenLayout(70, context),
                          padding: EdgeInsets.all(resize.screenLayout(20, context)),
                          decoration: const BoxDecoration(
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                dropdownColor: color_mode.primaryColor,
                                focusColor: color_mode.primaryColor,
                                style: TextStyle(fontSize: resize.screenLayout(30, context),
                                    color: color_mode.secondaryColor,
                                    fontWeight: FontWeight.w600
                                ),
                                borderRadius: BorderRadius.circular(resize.screenLayout(20, context)),
                                iconDisabledColor: Colors.grey,
                                iconEnabledColor: color_mode.secondaryColor,
                                icon: const Icon(Icons.arrow_downward_rounded),
                              enableFeedback: true,
                              hint: const Text('Select Department'),
                              isExpanded: true,
                              items: listItem.map(buildMenuItem).toList(),
                              value: value,
                              onChanged: (val) {
                                setState(() {
                                  value = val!;
                                  print(value);
                                });
                              }
                            ),
                          ),
                        ),
                        resize.verticalSpace(20, context),
                        (isChecked==true)?Container(
                          height: resize.screenLayout(70, context),
                          padding: EdgeInsets.all(resize.screenLayout(20, context)),
                          decoration: const BoxDecoration(
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: color_mode.primaryColor,
                              focusColor: color_mode.primaryColor,
                              style: TextStyle(fontSize: resize.screenLayout(30, context),
                                  color: color_mode.secondaryColor,
                                  fontWeight: FontWeight.w600
                              ),
                              borderRadius: BorderRadius.circular(resize.screenLayout(20, context)),
                              iconDisabledColor: Colors.grey,
                              iconEnabledColor: color_mode.secondaryColor,
                              icon: const Icon(Icons.arrow_downward_rounded),
                              enableFeedback: true,
                              hint: const Text('Select Semester'),
                              isExpanded: true,
                              isDense: true,
                              items: semList.map(buildMenuItem).toList(),
                              value: semValue,
                              onChanged: (sem) {
                                setState(() {
                                  semValue = sem!;
                                  print(semValue);
                                });
                              },
                            ),
                          ),
                        ):Container(),
                        resize.verticalSpace(20, context),
                      ]
                  ),
                ),
              ),
              resize.verticalSpace(40, context),
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
                          _confirmPasswordController.text.isEmpty || value == "Select Department"
                      ){
                        snackBar(content: 'Provide all fields', duration: 1500, context: context);
                      }
                      else if(_passwordController.text != _confirmPasswordController.text){
                        snackBar(content: 'Confirm password mismatch', duration: 1500, context: context);
                      }
                      else if(isChecked == true && semValue == "Select Semester"){
                        snackBar(content: 'Please select semester for Class Teacher', duration: 1500, context: context);
                      }
                      else {
                        recruitStaff();
                      }
                    },
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          resize.screenLayout(25, context)),
                    ),
                    backgroundColor: color_mode.secondaryColor,
                    enableFeedback: true,
                    child: (isLoading==false)?Text('Add Staff',
                      style: TextStyle(
                        fontSize: resize.screenLayout(26, context),
                        fontWeight: FontWeight.w500,
                      ),
                    ):SpinKitCircle(
                      color: color_mode.primaryColor,
                      size: resize.screenLayout(50, context),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
