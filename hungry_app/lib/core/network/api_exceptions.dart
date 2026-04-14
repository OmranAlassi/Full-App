import 'package:dio/dio.dart';
import 'package:full_app/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (data is Map<String, dynamic> && data["message"] != null) {
      return ApiError(message: data["message"], statusCode: statusCode);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message: 'ConnectionTimeout. Please check your internet Connection',
        );
      case DioExceptionType.sendTimeout:
        return ApiError(message: 'Request timeout. Please try again');
      case DioExceptionType.receiveTimeout:
        return ApiError(message: 'Response timeout. Please try again');
      // case DioExceptionType.badResponse:
      //   return ApiError(message: error.toString());
      default:
        return ApiError(message: 'Something went wrong');
    }
  }
}
