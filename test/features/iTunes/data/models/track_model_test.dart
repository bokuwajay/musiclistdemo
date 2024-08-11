import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:keysoctest/features/iTunes/data/models/track_model.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';

import '../../../../helpers/json_reader.dart';

// here to test 3 main things
// 1: Is the model we created equals the entity at domain layer?
// 2: Does the fromJson function return a valid model ?
// 3: Does the toJson function return appropriate json map ?

void main() {
  const testTrackModel = TrackModel(
    trackName: 'Surrender',
    collectionName: 'Surrender - Single',
    image: 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/2c/23/0f/2c230f3c-db35-43ea-f0dc-45284dad6bc7/886448400653.jpg/100x100bb.jpg',
    artistName: 'Natalie Taylor',
  );

// 1: Is the model we created equals the entity at domain layer?
  test('should be a subclass of track entity', () async {
    // assert
    expect(testTrackModel, isA<TrackEntity>());
  });

// 2: Does the fromJson function return a valid model ?
  test('should return a valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_itunes_search_response.json'),
    );
    // act
    var response = jsonMap['results'] as List;

    final result = response.map((e) => TrackModel.fromJson(e)).toList();

    // assert
    expect(result, equals([testTrackModel]));
  });

// 3: Does the toJson function return appropriate json map ?
// (actually not necessary for this project)
  test('should return a json map containing proper data', () async {
    // act
    final result = testTrackModel.toJson();

    // assert
    final expectedJsonMap = {
      'artistName': 'Natalie Taylor',
      'collectionName': 'Surrender - Single',
      'trackName': 'Surrender',
      'artworkUrl100': 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/2c/23/0f/2c230f3c-db35-43ea-f0dc-45284dad6bc7/886448400653.jpg/100x100bb.jpg',
    };

    expect(result, equals(expectedJsonMap));
  });
}
