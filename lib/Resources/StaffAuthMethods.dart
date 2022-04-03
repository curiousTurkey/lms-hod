import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lm_hod/Models/Hod/HodModel.dart';
import 'package:lm_hod/Models/Staff/StaffModel.dart';

class StaffAuthMethod{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<StaffModel> getStaffDetails() async {
    var currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(currentUser.email).get();
    return StaffModel.fromSnap(snapshot);
  }
  Future<String> loginStaff({
    required String emailAddress,
    required String password,
    required String userType,
  }) async {
    String finalResult = "Database connection error";

    try{

      DocumentSnapshot snapshot = await _firestore.collection('users').doc(emailAddress).get();
      String usertype = (snapshot.data() as Map<String,dynamic>)['usertype'];
      String email = (snapshot.data() as Map<String,dynamic>)['email'];
      String pass = (snapshot.data() as Map<String,dynamic>)['password'];
      if(!snapshot.exists){
        finalResult = "Staff user not found. Contact HOD";
      }
      else if(userType == usertype && emailAddress == email && password == pass){
        String firstSignin = (snapshot.data() as Map<String, dynamic>)['firstsignin'];
        if(firstSignin == "true"){
          _firestore.collection('users').doc(emailAddress).update({"firstsignin" : "false"});
          await _auth.createUserWithEmailAndPassword(email: emailAddress, password: password);
        }
        else{
          await _auth.signInWithEmailAndPassword(email: emailAddress, password: password);
        }
      }
      else{
        finalResult = "Staff not found";
      }
      return finalResult;

    }on FirebaseAuthException catch(error){
      return finalResult = error.toString();
    }
  } //login staff

  Future<String> createStaff({
    required String fullName,
    required String emailAddress,
    required String password,
    required bool isClassTeacher,
    required String whichSem,
    required String deptName
  }) async {
    String finalResult = "Database connection error. Check network or try later.";

    try{
      //check if staff already exists
      var a = await _firestore.collection('users').doc(emailAddress).get();
      if(a.exists){
        return finalResult = "Staff already exists";
      }
      else {
        StaffModel staffModel = StaffModel(
          fullName: fullName,
          emailAddress: emailAddress,
          password: password,
          deptName: deptName,
          isClassTeacher: isClassTeacher,
          semClassTeacher: whichSem,
        );
        await _firestore.collection('users').doc(emailAddress).set(
            staffModel.toJson());
        finalResult = "success";
      }
    }catch(error){
      return finalResult = error.toString();
    }
    return finalResult;
  }//signup
}