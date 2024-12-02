import 'package:dio/dio.dart';
import 'package:modxdemo/apiservice/apiservice.dart';
import 'package:modxdemo/apiservice/exception.dart';
import 'package:modxdemo/model/group_data_model.dart';

class Repository {
  ApiService apiService = ApiService();
  static String baseUrl = "http://dev.api.teaqip.nobrainsolutions.com/v1/";
  static String grouptype = "group-types";
  Future<List<GroupDataModel>> getGroupType() async {
    try {
      final response = await apiService.sendRequest.get(baseUrl + grouptype);
      return (response.data["Data"]["Row"] as List).map((e) {
        return GroupDataModel.fromJson(e);
      }).toList();
    } catch (e) {
      DioException error = e as DioException;
      throw ApiErrorHandler().getErrorMessage(error);
    }
  }
}
