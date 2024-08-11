import 'package:fpdart/fpdart.dart';
import 'package:keysoctest/core/error/failures.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/domain/usecases/usecase_params.dart';

abstract class ItunesRepository {
  Future<Either<Failure, List<TrackEntity>>> search(
    SearchParams params,
  );
}


// this ItunesRepository class should be abstract class , it will be implemented later at the data layer
// why define it abstract ? the domain layer should be independent of all other layers
// but how can it be independent when usecase obtains data from a repository that is shared with the data layer

// this comes to the art of dependency inversion, one of the S.O.L.I.D principles


// in domain layer, we create abstract repository class that define a contract what the reposiotory must do
// then in data layer, we write its actual implementation