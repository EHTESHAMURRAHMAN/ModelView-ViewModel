import 'dart:convert';
import 'dart:io';
import 'package:mvvm/data/app_exeption.dart';
import 'package:mvvm/data/network/baseApis.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.statusCode.toString());
      case 404:
        throw UnauthorisedException(response.statusCode.toString());
      case 408:
        throw UnauthorisedException(response.statusCode.toString());
      case 500:
        throw UnauthorisedException(response.statusCode.toString());
      default:
        throw FetchDataException(
            'Error accoured While Communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
