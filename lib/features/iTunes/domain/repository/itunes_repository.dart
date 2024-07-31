import 'package:fpdart/fpdart.dart';
import 'package:keysoctest/core/error/failures.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/domain/usecase/usecase_params.dart';

abstract class ItunesRepository {
  Future<Either<Failure, List<TrackEntity>>> search(
    SearchParams params,
  );
}
