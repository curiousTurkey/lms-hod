import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lm_hod/Models/Hod/HodModel.dart';


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<HodModel> getHodDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(currentUser.uid).get();
    return HodModel.fromSnap(snapshot);
  }

  Future<String> signupHod({
  required String fullName,
    required String emailAddress,
    required String password,
    required String contactNo,
    required String deptName,
    
}) async {
    String finalResult = "Error . Database Connection failed";
    
    try {
      
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: emailAddress, password: password);
      var userId = userCredential.user!.uid;
      
      //add user to firestore
      
      HodModel hodModel = HodModel(
          fullName: fullName, 
          emailAddress: emailAddress,
          userId: userId, 
          deptName: deptName, 
          contactNo: contactNo);
      await _firestore.collection('users').doc(userId).set(hodModel.toJson());
      finalResult = "success";
      
    }on FirebaseAuthException catch(error){
      if(error.code == 'invalid-email') {
        finalResult = 'Provide a valid E-mail';
      }
      else if(error.code == 'weak-password'){
        finalResult = 'Provide a strong password. (Min 6 characters)';
      }
      else if(error.code == 'user-not-found'){
        finalResult = 'User not registered. Please register or check credentials';
      }
      else if(error.code == 'email-already-in-use'){
        finalResult = "The email address is already in use by another account.";
      }
    }
    return finalResult;
  } //signup function

 Future<String> loginHod({
  required String emailAddress,
   required String password,
   required String userType
}) async {
   String finalResult = "Error 500. Internal Error. Check network or try again later";
   try {
     UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
         email: emailAddress, password: password);
     var userId = _userCredential.user!.uid;
     DocumentSnapshot snapshot = await _firestore.collection('users').doc(
         userId).get();
     var userType = ((snapshot.data() as Map<String, dynamic>)['usertype']);
     if (userType == 'hod') {
       finalResult = "success";
     }
     else {
       logoutHod();
       return finalResult = "User not found. Check credentials";
     }
     return finalResult;
   }
  on FirebaseAuthException catch(error){
  if(error.code == 'invalid-email') {
  finalResult = 'Please provide a valid email';
  }
  else if(error.code == 'weak-password'){
  finalResult = 'Provide a valid password. (Min 6 characters)';
  }
  else if(error.code == 'user-not-found'){
  finalResult = 'User not registered. Please register or check credentials';
  }
  else if(error.code == 'wrong-password'){
  finalResult = 'Wrong credentials. Check password';
  }
  else {
  finalResult = error.toString();
  return finalResult;
  }
  return finalResult;
  } //catch
 } //login

 Future<String> logoutHod() async {
    String finalResult = "";
    try{
      _auth.signOut();
      finalResult = "success";
      return finalResult;
    }on FirebaseAuthException catch(error){
      finalResult = error.toString();
      return finalResult;
    }
 }

}