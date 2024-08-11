import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:keysoctest/core/error/failures.dart';
import 'package:keysoctest/core/usecase/usecase.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/domain/repositories/itunes_repository.dart';

class Params extends Equatable {
  final String term;

  const Params({required this.term});

  @override
  List<Object?> get props => [term];
}

class ItunesSearchUseCase implements UseCase<List<TrackEntity>, Params> {
  final ItunesRepository _itunesRepository;
  ItunesSearchUseCase(this._itunesRepository);

  @override
  Future<Either<Failure, List<TrackEntity>>> call(Params params) async {
    if (params.term.isEmpty) {
      Failure failure = MissingParamsFailure(suffix: 'in call of ItunesSearchUseCase');
      return Left(failure);
    }
    return await _itunesRepository.search(params);
  }
}


// usecase is for orchestrate the flow of data "to" and "from" the entity
// Becasue of single responsibility principle, each usecase must be indepent of other usecase