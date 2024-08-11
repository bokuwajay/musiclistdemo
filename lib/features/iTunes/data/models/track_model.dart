import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';

class TrackModel extends TrackEntity {
  const TrackModel({
    required super.artistName,
    required super.collectionName,
    required super.trackName,
    required super.image,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      artistName: json['artistName'] ?? 'Unknown Artist',
      collectionName: json['collectionName'] ?? 'Unknown Collection',
      trackName: json['trackName'] ?? 'Unknown Track',
      image: json['artworkUrl100'] ?? 'https://pic.onlinewebfonts.com/svg/img_546302.png',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artistName': artistName,
      'collectionName': collectionName,
      'trackName': trackName,
      'artworkUrl100': image,
    };
  }

  TrackEntity toEnity() {
    return TrackEntity(
      artistName: artistName,
      collectionName: collectionName,
      trackName: trackName,
      image: image,
    );
  }
}
