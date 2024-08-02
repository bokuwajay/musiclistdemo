import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';

class TrackModel extends TrackEntity {
  const TrackModel({artistName, collectionName, trackName, image})
      : super(artistName: artistName, collectionName: collectionName, trackName: trackName, image: image);

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      artistName: json['artistName'] ?? 'Unknown Artist',
      collectionName: json['collectionName'] ?? 'Unknown Collection',
      trackName: json['trackName'] ?? 'Unknown Track',
      image: json['artworkUrl100'] ?? 'https://pic.onlinewebfonts.com/svg/img_546302.png',
    );
  }
}
