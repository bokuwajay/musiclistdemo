import 'package:fpdart/fpdart.dart';
import 'package:keysoctest/core/error/exception_conventer.dart';
import 'package:keysoctest/core/error/failures.dart';
import 'package:keysoctest/features/iTunes/data/data_sources/itunes_remote_datasource.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/domain/repositories/itunes_repository.dart';
import 'package:keysoctest/features/iTunes/domain/usecases/usecase_params.dart';

class ItunesRepositoryImpl extends ItunesRepository {
  final ItunesRemoteDataSource _itunesRemoteDataSource;

  ItunesRepositoryImpl(this._itunesRemoteDataSource);
  @override
  Future<Either<Failure, List<TrackEntity>>> search(SearchParams params) async {
    try {
      final result = await _itunesRemoteDataSource.search(params);
      final trackEntities = result.map((model) => model.toEnity()).toList();
      return Right(trackEntities);
    } catch (exception) {
      Failure failure = exceptionConverter(exception, 'in search of ItunesRepositoryImpl');
      return Left(failure);
    }
  }
}


// return type in data_sources will be similar to this repository
// but 2 huge differences: 
//  1: not return errors/failures (but throw exception)
//  2: not return entity, but return model

// because the data_sources are absolute boundary between our code world and external api/ 3rd party library
// models and entity have functionality to serialize and deserialize 'to' and 'from' json
// to convert to Dart objects