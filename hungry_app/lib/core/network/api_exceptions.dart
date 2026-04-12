import 'package:dio/dio.dart';
import 'package:full_app/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: 'Bad Connection');
      case DioExceptionType.badResponse:
        return ApiError(message: error.toString());
      default:
        return ApiError(message: 'Something went wrong');
    }
  }
}
