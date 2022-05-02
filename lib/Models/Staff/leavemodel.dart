import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class LeaveModel {
  final String fullName;
  final String dept;
  final String session2;
  final String fromDate;
  final String toDate;
  final String  email;
  final String leavereason;
  final String session1;
  final String leavesub;

  const LeaveModel({
    required this.fullName,
    required this.dept,
    required this.session2,
    required this.fromDate,
    required this.toDate,
    required this.email,
    required this.leavereason,
    required this.session1,
    required this.leavesub,
});

  static LeaveModel fromJson(Map<String, dynamic> json) => LeaveModel(
      fullName: json['fullname'],
      dept: json["dept"],
      session2: json['session2'],
      fromDate: json['fromdate'],
      toDate: json['todate'],
      email: json['email'],
      leavereason: json['leavereason'],
      session1: json['session1'],
      leavesub: json['leavesub']);

  static LeaveModel fromJsonAsync(AsyncSnapshot<DocumentSnapshot<Map<String,dynamic>>> json) => LeaveModel(
      fullName: json.data!['fullname'],
      dept: json.data!["dept"],
      session2: json.data!['session2'],
      fromDate: json.data!['fromdate'],
      toDate: json.data!['todate'],
      email: json.data!['email'],
      leavereason: json.data!['leavereason'],
      session1: json.data!['session1'],
      leavesub: json.data!['leavesub']);
}
