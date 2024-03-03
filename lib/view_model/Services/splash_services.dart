import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/model/user_Model.dart';
import 'package:mvvm/utils/routes/routesName.dart';
import 'package:mvvm/view_model/User_View_Model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(context) async {
    getUserData().then((value) async {
      if (value.token == 'null' || value.token == '') {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
  }
}
