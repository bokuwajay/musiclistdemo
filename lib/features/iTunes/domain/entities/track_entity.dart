import 'package:equatable/equatable.dart';

class TrackEntity extends Equatable {
  final String? artistName;
  final String? collectionName;
  final String? trackName;
  final String? image;

  const TrackEntity({
    this.artistName,
    this.collectionName,
    this.trackName,
    this.image,
  });

  @override
  List<Object?> get props {
    return [
      artistName,
      collectionName,
      trackName,
      image,
    ];
  }
}
