// ignore_for_file: library_private_types_in_public_api

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:modxdemo/apiservice/apiservices.dart';
import 'package:modxdemo/model/group_data_model.dart';

Repository repo = Repository();

class ApiStore with Store {
  @observable
  ObservableList<GroupDataModel> items = ObservableList<GroupDataModel>();

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @action
  Future<void> fetchItems() async {
    isLoading = true;
    error = null;

    try {
      final response = await repo.getGroupType();
      items = ObservableList.of(response);
    } catch (e) {
      error = 'Failed to load data';
    } finally {
      isLoading = false;
    }
  }
}
