import 'package:equatable/equatable.dart';

abstract class ItunesEvent extends Equatable {
  const ItunesEvent();

  @override
  List<Object?> get props => [];
}

class ItunesEventSearch extends ItunesEvent {
  final String term;

  const ItunesEventSearch({required this.term});
}
