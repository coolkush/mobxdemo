import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ApiErrorHandler {
  Future<String> getmesage() async {
// Helper().check().then((value) {
    bool status = await Helper().check();
    return status
        ? "Server not reachable , Please check your internet connection."
        : " Please check your internet connection.";
    //   log("message$value ${helper ? ValidationAndCommonfuntions.serverError : ValidationAndCommonfuntions.internetConnectionError}");
    // });
  }

  Future<String> getErrorMessage(DioException error,
      {String message = ""}) async {
    String messageNetwork = await getmesage();
    if (error.response?.headers.value("Content-Type").toString() ==
        "text/html") {
      return 'Server not reachable , Please check your internet connection.';
    } else if (error.type == DioExceptionType.connectionTimeout) {
      return 'Server not reachable , Please check your internet connection.';
    } else if (error.type == DioExceptionType.connectionError) {
      return messageNetwork;
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return 'Receive timeout';
    } else if (error.type == DioExceptionType.badResponse) {
      // Handle different status codes
      final statusCode = error.response?.statusCode;
      switch (statusCode) {
        case 400:
          return error.response?.data['message'].toString() ??
              "${error.response?.data}";
        case 401:
          return "unAuthtecate";
        case 403:
          return error.response?.data['message'] ??
              error.response?.data["detail"].toString() ??
              error.response?.data.toString();
        case 413:
          return "The image file is too large. Please upload an image smaller than 30MB.";
        case 423:
          return "Kill Switch Active";
        case 404:
          return "NO DATA FOUND";
        case 500:
          return messageNetwork;
        // Add more cases as needed
        default:
          return messageNetwork;
      }
    } else if (error.type == DioExceptionType.connectionError) {
      // Handle different status codes
      return "No Internet";
    } else if (error.type == DioExceptionType.unknown) {
      return "Server not reachable , Please check your internet connection.";
    } else {
      return messageNetwork;
    }
  }
}

class Helper {
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    }
    return false;
  }
}
