import 'package:keysoctest/core/api/api_helper.dart';
import 'package:keysoctest/features/iTunes/data/datasources/itunes_remote_datasource.dart';
import 'package:keysoctest/features/iTunes/data/repository/itunes_repository_impl.dart';
import 'package:keysoctest/features/iTunes/domain/usecase/itunes_search_usecase.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/iTunes_bloc.dart';
import 'package:keysoctest/injection_container.dart';

class ItunesDependency {
  ItunesDependency._();

  static void init() {
    sl.registerLazySingleton(() => ItunesRemoteDataSourceImpl(sl<ApiHelper>()));
    sl.registerLazySingleton(
        () => ItunesRepositoryImpl(sl<ItunesRemoteDataSourceImpl>()));

    sl.registerLazySingleton(
        () => ItunesSearchUseCase(sl<ItunesRepositoryImpl>()));

    sl.registerFactory(() => ItunesBloc(
          sl<ItunesSearchUseCase>(),
        ));
  }
}
