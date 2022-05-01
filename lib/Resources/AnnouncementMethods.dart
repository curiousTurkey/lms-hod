import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lm_hod/Models/Hod/AnnouncementModel.dart';
import 'package:lm_hod/Models/Hod/HodModel.dart';

class AnnouncementMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  //function to define announcement
  Future<String> announcementHod ({
    required final String subject,
    required final String body,
    required final String isStudent,
    required final String isTeacher,
    required final String date,
    required final String announcerImage,
    required final String announcerName,
}) async {

    String finalResult = "Internal error occurred, try again later." ;

    try {

      AnnouncementModel announcementModel = AnnouncementModel(
          subject: subject,
          body: body,
          isStudent: isStudent,
          isTeacher: isTeacher,
          date: date,
          announcerImage: announcerImage,
          announcerName: announcerName);
      await _firestore.collection('announcement').doc().set(announcementModel.toJson());
      finalResult = "success";
      return finalResult;
    } catch (error) {
      finalResult = error.toString();
      return finalResult;
    }
} //announcement function
}