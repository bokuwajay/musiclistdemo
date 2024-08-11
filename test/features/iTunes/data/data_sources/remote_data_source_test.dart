import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keysoctest/core/error/exceptions.dart';
import 'package:keysoctest/features/iTunes/data/data_sources/itunes_remote_datasource.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/domain/usecases/usecase_params.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

// we have to stub (means returning a fake object when mock mehtod is called) the data to make sure mockApiHelper returns right response when we call the end-point

void main() {
  late MockApiHelper mockApiHelper;
  late ItunesRemoteDataSourceImpl itunesRemoteDataSourceImpl;
  const params = SearchParams(term: 'Taylor Swift');

  setUp(() async {
    await dotenv.load(fileName: 'assets/env/.env.development');
    mockApiHelper = MockApiHelper();
    itunesRemoteDataSourceImpl = ItunesRemoteDataSourceImpl(mockApiHelper);
  });

  group('search in iTunes song list', () {
    test('should return Track Model when response is 200', () async {
      // arrange
      final jsonMap = json.decode(
        readJson('helpers/dummy_data/dummy_itunes_search_response.json'),
      );

      when(
        mockApiHelper.execute(
          baseUrl: anyNamed('baseUrl'),
          method: anyNamed('method'),
          endpoint: anyNamed('endpoint'),
          payload: anyNamed('payload'),
        ),
      ).thenAnswer(
        (_) async => jsonMap as Map<String, dynamic>,
      );

      // act
      final result = await itunesRemoteDataSourceImpl.search(params);

      // assert
      expect(result, isA<List<TrackEntity>>());
    });

    test('should throw a NotFoundException when response code is 404', () async {
      // arrange
      when(
        mockApiHelper.execute(
          baseUrl: anyNamed('baseUrl'),
          method: anyNamed('method'),
          endpoint: anyNamed('endpoint'),
          payload: anyNamed('payload'),
        ),
      ).thenThrow(NotFoundException());

      // act
      final result = itunesRemoteDataSourceImpl.search(params);

      // assert
      expect(result, throwsA(isA<NotFoundException>()));
    });
  });
}
