import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lm_hod/ReusableUtils/snackBar.dart';

class ProfileUpdate{

  Future<String> updateImage({
  required imageUrl,
}) async {
    String finalResult = "Couldn't update image. Try again later.";
    FirebaseAuth _auth = FirebaseAuth.instance;
    try{
      String _user = _auth.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(_user).update(
          {
            'imageurl' : imageUrl,
          }

      );
      finalResult = "Image upload success.";
      return finalResult;
    }
    catch(error){
      finalResult = error.toString();
      return finalResult;
    }
  }

  Future<String> updateContactNumber({required String contactNo}) async {
    String finalResult = "Couldn't update contact number. Try again later.";
    try{
      FirebaseAuth _auth = FirebaseAuth.instance;
      String _user = _auth.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(_user).update(
          {
            "contact" : contactNo
          });
      return finalResult = "Contact number updated successfully.";
    }
    catch(error){
      finalResult = error.toString();
      return finalResult;
    }
  }
}
