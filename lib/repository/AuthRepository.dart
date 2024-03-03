import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/data/network/baseApis.dart';
import 'package:mvvm/res/App_Url.dart';

class AuthRepository {
  BaseApiServices apiServices = NetworkApiService();
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> reigisterApi(dynamic data) async {
    try {
      dynamic response =
          await apiServices.getPostApiResponse(AppUrl.registerUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
