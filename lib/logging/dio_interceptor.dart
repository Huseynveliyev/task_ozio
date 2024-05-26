import 'dart:convert';
import 'dart:developer';

import 'package:chalkdart/chalk.dart';
import 'package:chalkdart/chalk_x11.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // options.baseUrl = ApiConfigs.baseUrl;
    String queryParamteres = '';
    for (String key in options.queryParameters.keys) {
      queryParamteres +=
          '?$key=${options.queryParameters[key]}${options.queryParameters[key] != options.queryParameters.keys.last ? '' : '& '}';
    }
    if (kDebugMode) {
      log(
        name: '  Request ',
        '''
${chalk.white.onDarkBlue('Url       : [${options.method}] ${options.baseUrl}${options.path}$queryParamteres')}
${chalk.white.onDarkBlue('Data      : ${options.data}')}
${chalk.white.onDarkBlue('Token     : ${options.headers["Authorization"]}')}
${chalk.white.onDarkBlue('Language  : ${options.headers["Accept-Language"]}')}
''',
      );
    }
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log(name: '   Error  ', '''
${chalk.white.onDarkRed('StatusCode: ${err.response?.statusCode}')}
${chalk.white.onDarkRed('StatusMsg : ${err.response?.statusMessage}')}
${chalk.white.onDarkRed('Message   : ${err.message}')}
${chalk.white.onDarkRed('Type      : ${err.type}')}
${chalk.white.onDarkRed('Data      : ${err.response?.data}')}
${chalk.white.onDarkRed('Headers   : ${err.response?.headers}')}
''');
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (kDebugMode) {
      log(name: ' Response ', '''
${chalk.white.onDarkGreen('Url       : [${response.requestOptions.method}] ${response.requestOptions.path}')}
${chalk.white.onDarkGreen('StatusCode: ${response.statusCode}')}
${chalk.white.onDarkGreen('StatusMsg : ${response.statusMessage}')}
${chalk.darkGreen.onWhite('Data      : ${prettyJson(response.data)}')}
''');
    }
    super.onResponse(response, handler);
  }
}

String prettyJson(dynamic input) {
  if (input is! String) {
    input = json.encode(input);
  }
  if (input.length < 5) return '';
  if (input[0] != '{') return input;
  const decoder = JsonDecoder();
  const encoder = JsonEncoder.withIndent('  ');

  var object = decoder.convert(input);
  var prettyString = encoder.convert(object);
  return prettyString;
}
