// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:modxdemo/apiservice/token_interceptor.dart';

class ApiService {
  final Dio _dio = Dio();
  ApiService._internal() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    };
    // _dio.interceptors.add(PrettyDioLogger());
    // _dio.close();
  }

  static final ApiService _instance = ApiService._internal();

  _addTokenInterceptor({String? params}) {
    if (_dio.interceptors.isEmpty) {
      _dio.interceptors.add(TokenInterceptor(token: params));
    } else {
      _dio.interceptors
          .removeWhere((interceptor) => interceptor is TokenInterceptor);
      _dio.interceptors.add(TokenInterceptor(token: params));
    }
  }

  factory ApiService({String? token}) {
    _instance._addTokenInterceptor(params: token);
    return _instance;
  }

  Dio get sendRequest => _dio;
}
