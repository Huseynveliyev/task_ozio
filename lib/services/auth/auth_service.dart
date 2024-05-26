import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task/models/error_model.dart';
import 'package:task/models/login_response_model.dart';
import 'package:task/utils/constants/api_config.dart';

import '../../exception/http_exception.dart';
import '../../logging/dio_interceptor.dart';

class AuthService {
  final Dio _myDio = Dio();

  AuthService() {
    _myDio.options = BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    _myDio.interceptors.add(DioInterceptor());
    _myDio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
    ));
  }

  //! Login metod
  Future<dynamic> login({
    required String login,
    required String password,
  }) async {
    try {
      final response = await _myDio.post(
        'login',
        data: {
          "login": login,
          "password": password,
        },
      );

      if (kDebugMode) {
        print(response.data);
      }

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        return ErrorResponseModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      if (e.response != null && e.response!.data != null) {
        return ErrorResponseModel.fromJson(e.response!.data);
      } else {
        throw HttpException(message: 'Something went wrong: ${e.message}');
      }
    }
  }
}
