import 'package:equatable/equatable.dart';

class TrackEntity extends Equatable {
  final String artistName;
  final String collectionName;
  final String trackName;
  final String image;

  const TrackEntity({
    required this.artistName,
    required this.collectionName,
    required this.trackName,
    required this.image,
  });

  @override
  List<Object?> get props => [artistName, collectionName, trackName, image];
}
