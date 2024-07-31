import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:keysoctest/config/routes/app_route_config.dart';
import 'package:keysoctest/core/api/api_helper.dart';
import 'package:keysoctest/core/api/api_interceptor.dart';
import 'package:keysoctest/core/cache/hive_local_storage.dart';
import 'package:keysoctest/core/cache/secure_local_storage.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton<AppRouteConfig>(() => AppRouteConfig());

  sl.registerLazySingleton(() => ApiInterceptor());
  sl.registerLazySingleton(() => Dio()..interceptors.add(sl<ApiInterceptor>()));
  sl.registerLazySingleton(() => ApiHelper(sl<Dio>()));

  sl.registerLazySingleton(() => HiveLocalStorage());
  sl.registerLazySingleton(
      () => SecureLocalStorage(sl<FlutterSecureStorage>()));
}
