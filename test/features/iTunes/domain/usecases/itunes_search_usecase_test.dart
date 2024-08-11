import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:keysoctest/core/error/failures.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/domain/usecases/itunes_search_usecase.dart';
import 'package:keysoctest/features/iTunes/domain/usecases/usecase_params.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

// what we want to test here?
// we want to test and ensure the repository is actually called and the data simply pass and unchanged through the usecase
// therefore, we need the repository (abstract class ItunesRepository) here, but how can we test an abstract class
// the package mockito can help

void main() {
  late ItunesSearchUseCase itunesSearchUseCase;
  late MockItunesRepository mockItunesRepository;

  setUp(() {
    mockItunesRepository = MockItunesRepository();
    itunesSearchUseCase = ItunesSearchUseCase(mockItunesRepository);
  });

  const params = SearchParams(term: 'Taylor Swift');
  const track = TrackEntity(
    trackName: 'Track 1',
    collectionName: 'Album 1',
    image: 'https://example.com/image1.jpg',
    artistName: 'Artist 1',
  );
  provideDummy<Either<Failure, List<TrackEntity>>>(const Right([track]));
  Failure failure = MissingParamsFailure(suffix: 'in call of ItunesSearchUseCase');
  provideDummy<Either<Failure, List<TrackEntity>>>(Left(failure));

  test('should get list of track entity from the repository', () async {
    // arrange
    when(mockItunesRepository.search(params)).thenAnswer((_) async => const Right([track]));

    // act
    final result = await itunesSearchUseCase.call(params);

    // assert
    expect(result, const Right([track]));
  });
}
