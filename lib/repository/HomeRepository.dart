import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/data/network/baseApis.dart';
import 'package:mvvm/model/movies_Model.dart';
import 'package:mvvm/res/App_Url.dart';

class HomeRepository {
  BaseApiServices apiServices = NetworkApiService();

  Future<MovieListModel> fetchmovieList() async {
    try {
      dynamic response = await apiServices.getGetResponse(AppUrl.moviesListUrl);
      return response = MovieListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
