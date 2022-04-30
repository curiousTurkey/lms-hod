

import 'package:flutter/material.dart';
import 'package:lm_hod/Models/Hod/HodModel.dart';
import 'package:lm_hod/Resources/HodAuthMethods.dart';

class HodProvider with ChangeNotifier{
  HodModel _hodModel = HodModel(fullName: '', emailAddress: '', userId: 'userid', deptName: '', contactNo: 'contactno', imageUrl: 'https://www.flaticon.com/free-icons/teacher');
  final AuthMethods _authMethods = AuthMethods();

  HodModel get getHod => _hodModel;

  Future<void> refreshHod() async {
    HodModel hodModel = await _authMethods.getHodDetails();
    _hodModel = hodModel;
    notifyListeners();
  }
}