// ignore_for_file: body_might_complete_normally_nullable, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:full_app/core/network/api_error.dart';
import 'package:full_app/core/network/api_exceptions.dart';
import 'package:full_app/core/network/api_service.dart';
import 'package:full_app/core/utils/pref_helper.dart';
import 'package:full_app/features/auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();

  //Login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post('/login', {
        'email': email,
        'password': password,
      });

      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response["message"];
        final code = response["code"];
        final data = response["data"];

        if (code != 200 && code != 201 || data == null) {
          throw ApiError(message: msg ?? "Unknown error");
        }
        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        return user;
      } else {
        throw ApiError(message: 'UnExpected Error From Server');
      }
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //Register
  Future<UserModel?> signup(String name, String email, String password) async {
    try {
      final response = await apiService.post('/register', {
        name: name,
        email: email,
        password: password,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response["message"];
        final code = response["code"];
        // final coder = int.tryParse(code);
        final data = response["data"];

        // if (coder != 200 && coder != 201) {
        //   throw ApiError(message: msg ?? "Unknown error");
        // }

        if (code != 200 && code != 201 || data == null) {
          throw ApiError(message: msg ?? "Unknown error");
        }

        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        return user;
      } else {
        throw ApiError(message: 'UnExpected Error From Server');
      }
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //Get Profile data
  Future<UserModel?> getProfileData() async {
    try {
      final response = await apiService.get('/profile');
      return UserModel.fromJson(response["data"]);
    } on DioError catch (e) {
      ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //Update profile data

  //Logout
}
