import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:keysoctest/core/error/exception_conventer.dart';
import 'package:keysoctest/core/error/failures.dart';
import 'package:keysoctest/features/iTunes/data/datasources/itunes_remote_datasource.dart';
import 'package:keysoctest/features/iTunes/data/models/track_model.dart';
import 'package:keysoctest/features/iTunes/data/repository/itunes_repository_impl.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/domain/usecase/usecase_params.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<ItunesRemoteDataSource>()])
import './itunes_repository_impl_test.mocks.dart';

void main() {
  late ItunesRepositoryImpl itunesRepositoryImpl;
  late MockItunesRemoteDataSource mockItunesRemoteDataSource;
  const params = SearchParams(term: 'Taylor Swift');
  const trackModel = TrackModel(
    trackName: 'Track 1',
    collectionName: 'Album 1',
    image: 'https://example.com/image1.jpg',
  );

  provideDummy<Either<Failure, List<TrackModel>>>(const Right([trackModel]));
  Failure failure = exceptionConverter(UnknownFailure, 'in search of ItunesRepositoryImpl');
  provideDummy<Either<Failure, List<TrackEntity>>>(Left(failure));

  setUp(() {
    mockItunesRemoteDataSource = MockItunesRemoteDataSource();
    itunesRepositoryImpl = ItunesRepositoryImpl(mockItunesRemoteDataSource);
  });

  test('should return list of tracks when datasource call is successful', () async {
    // Arrange
    final tracks = <TrackModel>[trackModel];
    when(mockItunesRemoteDataSource.search(params)).thenAnswer((_) async => tracks);

    // Act
    final result = await itunesRepositoryImpl.search(params);

    // Assert
    expect(result, equals(Right(tracks)));
    verify(mockItunesRemoteDataSource.search(params)).called(1);
    verifyNoMoreInteractions(mockItunesRemoteDataSource);
  });

  test('should return failure when remote data source call fails', () async {
    // Arrange
    when(mockItunesRemoteDataSource.search(params)).thenThrow(Exception());

    // Act
    final result = await itunesRepositoryImpl.search(params);

    // Assert
    expect(result, isA<Left<Failure, List<TrackEntity>>>());
    verify(mockItunesRemoteDataSource.search(params)).called(1);
    verifyNoMoreInteractions(mockItunesRemoteDataSource);
  });
}
