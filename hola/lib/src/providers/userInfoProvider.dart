import 'package:flutter/material.dart';

class UserInfoProvider with ChangeNotifier {
  Map<String, dynamic> _userInfo = {
    "email": "",
    "name": "",
    "api_key": "",
    "password": "",
    "logged": "",
  };

  // StudentInfoProvider(this._studentInfo) {
  //   _studentInfo = {..._studentInfo};
  // }

  Map<String, dynamic> get getUserInfo => _userInfo;
  void setUserInfo(Map<String, dynamic> data) {
    //print(data);
    _userInfo = {..._userInfo, ...data};
    //print("\n\n");
    print(_userInfo);
    notifyListeners();
  }
}
