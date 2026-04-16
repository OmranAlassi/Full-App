import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:full_app/core/network/api_error.dart';
import 'package:full_app/core/network/api_exceptions.dart';
import 'package:full_app/core/network/api_service.dart';
import 'package:full_app/core/utils/pref_helper.dart';
import 'package:full_app/features/auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  bool isGuest = false;
  UserModel? currentUser;

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

        if (code != 200 && code != 201) {
          throw ApiError(message: msg ?? "Unknown error");
        }
        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
          log(user.token!);
        }
        isGuest = false;
        currentUser = user;
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

        if (code != 200 && code != 201) {
          throw ApiError(message: msg ?? "Unknown error");
        }

        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        isGuest = false;
        currentUser = user;
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
      final token = await PrefHelper.getToken();
      if (token == null || token == 'guest') {
        return null;
      }

      final response = await apiService.get('/profile');
      final user = UserModel.fromJson(response["data"]);
      currentUser = user;
      return user;
    } on DioError catch (e) {
      ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
    return null;
  }

  //Update profile data
  Future<UserModel?> updateProfileData({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? image,
  }) async {
    try {
      final formData = FormData.fromMap({
        "name": name,
        "email": email,
        "address": address,
        if (image != null && image.isNotEmpty)
          "image": await MultipartFile.fromFile(image, filename: 'profile.jpg'),
        if (visa != null && visa.isNotEmpty) "Visa": visa,
      });

      final response = await apiService.post('/update-profile', formData);
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response["message"];
        final code = response["code"];
        final data = response["data"];
        // final coder = int.tryParse(code);

        // if (coder != 200 && coder != 201) {
        //   throw ApiError(message: msg ?? "Unknown error");
        // }

        if (code != 200 && code != 201) {
          throw ApiError(message: msg ?? "Unknown error");
        }
        final updateUser = UserModel.fromJson(data);
        currentUser = updateUser;
        return updateUser;
      } else {
        throw ApiError(message: 'Invalid Error from here');
      }
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //Logout
  Future<void> logout() async {
    final response = await apiService.post('/logout', {});
    if (response["data"] != null) {
      throw ApiError(message: 'Error');
    }
    await PrefHelper.clearToken();
    currentUser = null;
    isGuest = true;
  }

  //auto login
  Future<UserModel?> authLogin() async {
    final token = await PrefHelper.getToken();
    if (token == null || token == 'guest') {
      isGuest = true;
      currentUser = null;
      return null;
    }
    isGuest = false;
    try {
      final user = await getProfileData();
      currentUser = user;
      return user;
    } catch (_) {
      await PrefHelper.clearToken();
      isGuest = true;
      currentUser = null;
      return null;
    }
  }

  //continue as guest
  Future<void> continueAsGuest() async {
    isGuest = true;
    currentUser = null;
    await PrefHelper.saveToken('guest');
  }

  bool get isLoggedIn => !isGuest && currentUser != null;
}
