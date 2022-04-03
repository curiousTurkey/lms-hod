import 'package:cloud_firestore/cloud_firestore.dart';

class Dept{
  final String deptName;
  final String deptId;
  Dept({
    required this.deptName,
    required this.deptId
});
  Map<String,dynamic> toJson() => {
    "deptname" : deptName,
    "deptid" : deptId,
  };
  static Dept fromJson(Map<String, dynamic> json) => Dept(
    deptName : json['deptname'],
    deptId : json['deptid']
  );
}