// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  final String? token;

  // Declare the logout handled flag
  // Use static to keep the state across all instances

  TokenInterceptor({this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusMessage == "OK") {}

    super.onResponse(response, handler);
  }
}
