import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //adding profile image to storage
  //childName specifies the folder name for image storage , ref.child() creates a folder named childName
  Future<String> uploadImageToStorage(String folderName, File file) async {

    var userId = _auth.currentUser!.uid;
    Reference reference = _storage.ref().child(folderName).child(userId);
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot snapShot = await uploadTask;
    String downloadUrl = await snapShot.ref.getDownloadURL();
    return downloadUrl;
  }


}