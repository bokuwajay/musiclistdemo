import 'package:equatable/equatable.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';

abstract class ItunesState extends Equatable {
  const ItunesState();

  @override
  List<Object?> get props => [];
}

class ItunesStateInitial extends ItunesState {}

class ItunesStateLoading extends ItunesState {
  const ItunesStateLoading();

  @override
  List<Object?> get props => [];
}

class ItunesStateFailed extends ItunesState {
  final String message;
  const ItunesStateFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class ItunesStateSearchSuccessful extends ItunesState {
  final List<TrackEntity>? data;
  const ItunesStateSearchSuccessful(this.data);

  @override
  List<Object?> get props => [data];
}
