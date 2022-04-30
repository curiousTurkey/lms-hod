import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class HodModel {
  final String fullName;
  final String emailAddress;
  final String userId;
  final String deptName;
  final String contactNo;
  late String userType;
  late String imageUrl;

  HodModel({
    required this.fullName,
    required this.emailAddress,
    required this.userId,
    required this.deptName,
    required this.contactNo,
    this.imageUrl = "notset",
    this.userType = "hod"});

  Map<String, dynamic> toJson() =>
      {
        "name": fullName,
        "email": emailAddress,
        "userid": userId,
        "dept": deptName,
        "contact": contactNo,
        "usertype": userType,
        "imageurl": imageUrl
      };

  static HodModel fromSnap(DocumentSnapshot snapshot) {
    var snapShot = snapshot.data() as Map<String, dynamic>;
    return HodModel(
        deptName: snapShot['dept'],
        fullName: snapShot['name'],
        contactNo: snapShot['contact'],
        userId: snapShot['userid'],
        emailAddress: snapShot['email'],
        userType: snapShot['usertype'],
        imageUrl: snapShot['imageurl']
    );
  }
}