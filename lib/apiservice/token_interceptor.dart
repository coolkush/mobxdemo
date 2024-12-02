// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  final String? token;

  // Declare the logout handled flag
  static bool _isLogoutHandled =
      false; // Use static to keep the state across all instances

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
    if (response.statusMessage == "OK") {
      _isLogoutHandled = false;
    }

    super.onResponse(response, handler);
  }
}

enum ApiStatus {
  error,
  isLoading,
  success,
  normal,
  profile,
  checkin,
  checkinupdate
}
