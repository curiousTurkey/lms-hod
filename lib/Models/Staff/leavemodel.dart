import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveModel {
  final String fullName;
  final String dept;
  final String session2;
  final String fromDate;
  final String toDate;
  final int casualLeaveTaken;
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
    required this.casualLeaveTaken,
    required this.email,
    required this.leavereason,
    required this.session1,
    required this.leavesub,
});

  static LeaveModel fromJson(Map<String, dynamic> json) => LeaveModel(
      fullName: json['name'],
      dept: json["dept"],
      session2: json['session2'],
      fromDate: json['fromdate'],
      toDate: json['todate'],
      casualLeaveTaken: json['casualleavetaken'],
      email: json['email'],
      leavereason: json['leavereason'],
      session1: json['session1'],
      leavesub: json['leavesub']);
}