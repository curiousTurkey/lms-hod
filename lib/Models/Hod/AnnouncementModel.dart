import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementModel {
  final String subject;
  final String body;
  final String isStudent;
  final String isTeacher;
  final String date;
  final String announcerImage;
  final String announcerName;
  final String announcer;

  AnnouncementModel({
  required this.subject,
  required this.body,
  required this.isStudent,
  required this.isTeacher,
  required this.date,
  required this.announcerImage,
  required this.announcerName,
    this.announcer = 'hod'
});

  Map<String, dynamic> toJson() =>
      {
       "announcername" : announcerName,
        "announcerImage" : announcerImage,
        "announcedate" : date,
        "isForTeacher" : isTeacher,
        "isForStudent" : isStudent,
        "announcebody" : body,
        "announcesub" : subject,
        "announcer" : announcer
      };

  static AnnouncementModel fromSnap(DocumentSnapshot snapshot) {
    var snapShot = snapshot.data() as Map<String, dynamic> ;
    return AnnouncementModel(
        subject: snapShot["announcesub"],
        body: snapShot["announcebody"],
        isStudent: snapShot["isForStudent"],
        isTeacher: snapShot["isForTeacher"],
        date: snapShot["announcedate"],
        announcerImage: snapShot["announcerImage"],
        announcerName: snapShot["announcername"],
      announcer: snapShot['announcer'],
    );
  }
}