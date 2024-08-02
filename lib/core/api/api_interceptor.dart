import 'package:dio/dio.dart';
import 'package:keysoctest/util/logger.dart';

import 'api_url.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.baseUrl.isEmpty) {
      options.baseUrl = ApiUrl.baseUrl;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String url = err.requestOptions.uri.toString();
    String errorType = err.type.toString();
    logger.e('Logger in Api Interceptor:\nApi Url: $url\nError Type: $errorType');
    super.onError(err, handler);
  }
}
