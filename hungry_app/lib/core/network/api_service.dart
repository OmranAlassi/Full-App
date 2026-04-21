import 'package:dio/dio.dart';
import 'package:full_app/core/network/api_exceptions.dart';
import 'package:full_app/core/network/dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  //CRUD METHODS

  //GET
  Future<dynamic> get(String endPoint) async {
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioExceptionType catch (e) {
      return ApiExceptions.handleError(e as DioException);
    }
  }

  //POST
  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: body);
      return response.data;
    } on DioExceptionType catch (e) {
      return ApiExceptions.handleError(e as DioException);
    }
  }

  //PUT//UPDATE
  Future<dynamic> put(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioExceptionType catch (e) {
      return ApiExceptions.handleError(e as DioException);
    }
  }

  //DELETE
  Future<dynamic> delete(
    String endPoint,
    dynamic body, {
    dynamic params,
  }) async {
    try {
      final response = await _dioClient.dio.delete(
        endPoint,
        data: body,
        queryParameters: params,
      );
      return response.data;
    } on DioExceptionType catch (e) {
      return ApiExceptions.handleError(e as DioException);
    }
  }
}
