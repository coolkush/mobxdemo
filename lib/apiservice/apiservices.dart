import 'dart:developer';

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
      final response = await apiService.sendRequest
          .get(baseUrl + grouptype, queryParameters: {"PageSize": 10});
      log("${response.data}");
      return (response.data["Data"]["Rows"] as List).map((e) {
        return GroupDataModel.fromJson(e);
      }).toList();
    } catch (e) {
      log(e.toString());
      DioException error = e as DioException;
      throw ApiErrorHandler().getErrorMessage(error);
    }
  }

  Future<void> update(int id, String name, String description,
      bool showDivisionReport, bool isActive) async {
    try {
      log("message${baseUrl + grouptype}$id ${{
        'Name': name,
        'Description': description,
        'ShowDivisionReport': showDivisionReport,
        'IsActive': isActive,
      }}");
      final response = await apiService.sendRequest
          .patch("${baseUrl + grouptype}/$id", data: {
        'Name': name,
        'Description': description,
        'ShowDivisionReport': showDivisionReport,
        'IsActive': isActive,
      });
      log("${response.data} ");
    } catch (e) {
      DioException error = e as DioException;

      throw await ApiErrorHandler().getErrorMessage(error);
    }
  }
}
