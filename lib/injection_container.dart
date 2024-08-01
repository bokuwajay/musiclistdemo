import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:keysoctest/config/routes/app_route_config.dart';
import 'package:keysoctest/core/api/api_helper.dart';
import 'package:keysoctest/core/api/api_interceptor.dart';
import 'package:keysoctest/features/iTunes/di/itunes_dependency.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton<AppRouteConfig>(() => AppRouteConfig());

  sl.registerLazySingleton(() => ApiInterceptor());
  sl.registerLazySingleton(() => Dio()..interceptors.add(sl<ApiInterceptor>()));
  sl.registerLazySingleton(() => ApiHelper(sl<Dio>()));

  ItunesDependency.init();
}
