import 'package:dio/dio.dart';
import 'package:full_app/core/utils/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://sonic-zdi0.onrender.com/api',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  DioClient() {
    // _dio.interceptors.add(
    //   LogInterceptor(requestBody: true, responseBody: true),
    // );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();
          
          print('Api Request to:${options.path}');
          print('Token for Request: ${token ?? 'null'}');


          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers["Authorization"] = 'Bearer$token';
          }
          return handler.next(options);
        },
      ),
    );
  }
  Dio get dio => _dio;
}
