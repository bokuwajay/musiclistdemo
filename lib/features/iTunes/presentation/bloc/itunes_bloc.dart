import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keysoctest/core/error/failure_conventer.dart';
import 'package:keysoctest/features/iTunes/domain/usecase/itunes_search_usecase.dart';
import 'package:keysoctest/features/iTunes/domain/usecase/usecase_params.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/iTunes_event.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/iTunes_state.dart';

class ItunesBloc extends Bloc<ItunesEvent, ItunesState> {
  final ItunesSearchUseCase _itunesSearchUseCase;

  ItunesBloc(this._itunesSearchUseCase) : super(ItunesStateInitial()) {
    on<ItunesEventSearch>(
      (event, emit) async {
        final result =
            await _itunesSearchUseCase.call(SearchParams(term: event.term));

        result.fold(
          (l) => emit(ItunesStateFailed(failureConverter(l))),
          (r) => emit(ItunesStateSearchSuccessful(r)),
        );
      },
    );
  }
}
