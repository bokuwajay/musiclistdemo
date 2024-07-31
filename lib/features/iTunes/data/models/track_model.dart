import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';

class TrackModel extends TrackEntity {
  const TrackModel({artistName, collectionName, trackName, image})
      : super(
          artistName: artistName,
          collectionName: collectionName,
          trackName: trackName,
          image: image,
        );

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      artistName: json['artistName'] as String,
      collectionName: json['collectionName'] as String,
      trackName: json['trackName'] as String,
      image: json['artworkUrl100'] as String,
    );
  }
}
