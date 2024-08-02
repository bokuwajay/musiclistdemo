import 'package:fpdart/fpdart.dart';
import 'package:keysoctest/core/error/exception_conventer.dart';
import 'package:keysoctest/core/error/failures.dart';
import 'package:keysoctest/features/iTunes/data/datasources/itunes_remote_datasource.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/domain/repository/itunes_repository.dart';
import 'package:keysoctest/features/iTunes/domain/usecase/usecase_params.dart';

class ItunesRepositoryImpl implements ItunesRepository {
  final ItunesRemoteDataSource _itunesRemoteDataSource;

  ItunesRepositoryImpl(this._itunesRemoteDataSource);
  @override
  Future<Either<Failure, List<TrackEntity>>> search(SearchParams params) async {
    try {
      final result = await _itunesRemoteDataSource.search(params);
      return Right(result);
    } catch (exception) {
      Failure failure = exceptionConverter(exception, 'in search of ItunesRepositoryImpl');
      return Left(failure);
    }
  }
}
