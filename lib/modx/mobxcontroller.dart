// ignore_for_file: library_private_types_in_public_api

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

class ApiStore with Store {
  final Dio _dio = Dio();

  @observable
  ObservableList<String> items = ObservableList<String>();

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @action
  Future<void> fetchItems() async {
    isLoading = true;
    error = null;

    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts');
      items = ObservableList.of(response.data
          .map<String>((item) => item['title'].toString())
          .toList());
    } catch (e) {
      error = 'Failed to load data';
    } finally {
      isLoading = false;
    }
  }
}
