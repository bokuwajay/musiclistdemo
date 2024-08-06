import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keysoctest/core/api/api_helper.dart';
import 'package:keysoctest/features/iTunes/data/datasources/itunes_remote_datasource.dart';
import 'package:keysoctest/features/iTunes/data/models/track_model.dart';
import 'package:keysoctest/features/iTunes/domain/usecase/usecase_params.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<ApiHelper>()])
import './itunes_remote_datasource_impl_test.mocks.dart';

void main() {
  late ItunesRemoteDataSourceImpl itunesRemoteDataSourceImpl;
  late MockApiHelper mockApiHelper;
  const params = SearchParams(term: 'Taylor Swift');
  const trackModel = TrackModel(
    trackName: 'Track 1',
    collectionName: 'Album 1',
    image: 'https://example.com/image1.jpg',
    artistName: 'Artist 1',
  );

  setUp(() {
    mockApiHelper = MockApiHelper();
    itunesRemoteDataSourceImpl = ItunesRemoteDataSourceImpl(mockApiHelper);
    dotenv.testLoad(fileInput: 'assets/env/.env.development');
  });

  test('should return list of tracks when API call is successful', () async {
    // Arrange
    final apiResponse = {
      'results': [
        {
          'trackName': 'Track 1',
          'collectionName': 'Album 1',
          'artworkUrl100': 'https://example.com/image1.jpg',
          'artistName': 'Artist 1',
        },
      ],
    };

    when(mockApiHelper.execute(
      method: Method.get,
      baseUrl: dotenv.env['itunesBaseURL'],
      endpoint: '/search?term=Taylor+Swift&limit=200&media=music',
    )).thenAnswer((_) async => apiResponse);

    // Act
    final result = await itunesRemoteDataSourceImpl.search(params);

    // Assert
    expect(result, [trackModel]);
    verify(mockApiHelper.execute(
      method: Method.get,
      baseUrl: dotenv.env['itunesBaseURL'],
      endpoint: '/search?term=Taylor+Swift&limit=200&media=music',
    )).called(1);

    verifyNoMoreInteractions(mockApiHelper);
  });

  test('should throw an exception when API call fails', () async {
    // Arrange
    when(mockApiHelper.execute(
      method: Method.get,
      baseUrl: dotenv.env['itunesBaseURL'],
      endpoint: '/search?term=Taylor+Swift&limit=200&media=music',
    )).thenThrow(Exception('API call failed'));

    // Act & Assert
    expect(() => itunesRemoteDataSourceImpl.search(params), throwsException);
    verify(mockApiHelper.execute(
      method: Method.get,
      baseUrl: dotenv.env['itunesBaseURL'],
      endpoint: '/search?term=Taylor+Swift&limit=200&media=music',
    )).called(1);

    verifyNoMoreInteractions(mockApiHelper);
  });
}
