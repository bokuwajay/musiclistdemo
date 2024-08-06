import 'package:flutter_test/flutter_test.dart';
import 'package:keysoctest/core/error/failures.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/domain/repository/itunes_repository.dart';
import 'package:keysoctest/features/iTunes/domain/usecase/itunes_search_usecase.dart';
import 'package:keysoctest/features/iTunes/domain/usecase/usecase_params.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fpdart/fpdart.dart';

@GenerateNiceMocks([MockSpec<ItunesRepository>()])
import './itunes_search_usecase_test.mocks.dart';

void main() {
  late ItunesSearchUseCase itunesSearchUseCase;
  late MockItunesRepository mockItunesRepository;
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

  setUp(() {
    mockItunesRepository = MockItunesRepository();
    itunesSearchUseCase = ItunesSearchUseCase(mockItunesRepository);
  });

  test('should return list of tracks when repository call is successful', () async {
    // Arrange
    final tracks = <TrackEntity>[track];
    when(mockItunesRepository.search(any)).thenAnswer((_) async => Right(tracks));

    // Act
    final result = await itunesSearchUseCase.call(params);

    // Assert
    expect(result, equals(Right(tracks)));
    verify(mockItunesRepository.search(params)).called(1);
    verifyNoMoreInteractions(mockItunesRepository);
  });

  test('should return failure when repository call fails', () async {
    // Arrange
    when(mockItunesRepository.search(params)).thenAnswer((_) async => Left(failure));

    // Act
    final result = await itunesSearchUseCase.call(params);

    // Assert
    expect(result, equals(Left(failure)));
    verify(mockItunesRepository.search(params)).called(1);
    verifyNoMoreInteractions(mockItunesRepository);
  });
}
