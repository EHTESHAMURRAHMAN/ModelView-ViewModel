import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/model/user_Model.dart';
import 'package:mvvm/repository/AuthRepository.dart';
import 'package:mvvm/utils/routes/routesName.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/User_View_Model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final myRepo = AuthRepository();

  bool _loading = false;

  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _registerLoading = false;

  bool get registerLoading => _registerLoading;
  setRegisterLoading(bool value) {
    _registerLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    myRepo.loginApi(data).then((value) {
      setLoading(false);
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(UserModel(token: value['token'].toString()));
      Navigator.pushNamed(context, RoutesName.home);
      Utils.flushBarErrorMessage('Login Success', context);

      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> registerApi(dynamic data, BuildContext context) async {
    setRegisterLoading(true);
    myRepo.reigisterApi(data).then((value) {
      setRegisterLoading(false);
      Navigator.pushNamed(context, RoutesName.login);
      Utils.flushBarErrorMessage('Register Success', context);

      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setRegisterLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}
