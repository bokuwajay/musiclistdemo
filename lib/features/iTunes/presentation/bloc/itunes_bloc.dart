import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keysoctest/core/error/failure_conventer.dart';
import 'package:keysoctest/features/iTunes/domain/usecases/itunes_search_usecase.dart';
import 'package:keysoctest/features/iTunes/domain/usecases/usecase_params.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_event.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_state.dart';

class ItunesBloc extends Bloc<ItunesEvent, ItunesState> {
  final ItunesSearchUseCase _itunesSearchUseCase;

  ItunesBloc(this._itunesSearchUseCase) : super(ItunesStateInitial()) {
    on<ItunesEventSearch>(
      (event, emit) async {
        emit(const ItunesStateLoading());

        final result = await _itunesSearchUseCase.call(SearchParams(term: event.term));

        result.fold(
          (l) => emit(ItunesStateFailed(failureConverter(l))),
          (r) => emit(ItunesStateSearchSuccessful(r)),
        );
      },
    );
  }
}
