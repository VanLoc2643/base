import 'package:dio/dio.dart';

Dio buildDio({required String baseUrl}) {
  final dio = Dio(BaseOptions(
      baseUrl: baseUrl, connectTimeout: const Duration(seconds: 10)));
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestBody: true,
    responseBody: true,
  ));
  return dio;
}
