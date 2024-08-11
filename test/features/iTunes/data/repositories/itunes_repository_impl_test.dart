import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:keysoctest/core/error/exception_conventer.dart';
import 'package:keysoctest/core/error/exceptions.dart';
import 'package:keysoctest/core/error/failures.dart';
import 'package:keysoctest/features/iTunes/data/repositories/itunes_repository_impl.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/domain/usecases/usecase_params.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockItunesRemoteDataSource mockItunesRemoteDataSource;
  late ItunesRepositoryImpl itunesRepositoryImpl;

  setUp(() {
    mockItunesRemoteDataSource = MockItunesRemoteDataSource();
    itunesRepositoryImpl = ItunesRepositoryImpl(mockItunesRemoteDataSource);
  });

  const params = SearchParams(term: 'Taylor');

  // const testTrackModel = TrackModel(
  //   trackName: 'Surrender',
  //   collectionName: 'Surrender - Single',
  //   image: 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/2c/23/0f/2c230f3c-db35-43ea-f0dc-45284dad6bc7/886448400653.jpg/100x100bb.jpg',
  //   artistName: 'Natalie Taylor',
  // );

  // const testTrackEntity = TrackEntity(
  //   trackName: 'Surrender',
  //   collectionName: 'Surrender - Single',
  //   image: 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/2c/23/0f/2c230f3c-db35-43ea-f0dc-45284dad6bc7/886448400653.jpg/100x100bb.jpg',
  //   artistName: 'Natalie Taylor',
  // );

  group('search itunes song list ', () {
    // test('should return list of songs when call to data source is successful', () async {
    //   // arrange
    //   when(mockItunesRemoteDataSource.search(params)).thenAnswer((_) async => [testTrackModel]);

    //   // act
    //   final result = await itunesRepositoryImpl.search(params);

    //   // assert
    //   expect(result, equals(Right<Failure, List<TrackEntity>>([testTrackEntity])));
    // });

    test('should return failure when call to data source is unsuccessful', () async {
      // arrange
      when(mockItunesRemoteDataSource.search(params)).thenThrow(InternalServerException);

      // act
      final result = await itunesRepositoryImpl.search(params);

      // assert
      expect(result, equals(Left<Failure, List<TrackEntity>>(exceptionConverter(InternalServerException, 'in search of ItunesRepositoryImpl'))));
    });

    test('should return connection failure when device has no internet connection', () async {
      // arrange
      when(mockItunesRemoteDataSource.search(params)).thenThrow(FetchDataException);

      // act
      final result = await itunesRepositoryImpl.search(params);

      // assert
      expect(result, equals(Left<Failure, List<TrackEntity>>(exceptionConverter(FetchDataException, 'in search of ItunesRepositoryImpl'))));
    });
  });
}
