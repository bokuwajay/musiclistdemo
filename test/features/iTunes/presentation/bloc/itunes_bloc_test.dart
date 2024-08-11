import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:keysoctest/core/error/failures.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/domain/usecases/usecase_params.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_bloc.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_event.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockItunesSearchUseCase mockItunesSearchUseCase;
  late ItunesBloc itunesBloc;

  setUp(() {
    mockItunesSearchUseCase = MockItunesSearchUseCase();
    itunesBloc = ItunesBloc(mockItunesSearchUseCase);
  });

  const testTrackEntity = TrackEntity(
    trackName: 'Surrender',
    collectionName: 'Surrender - Single',
    image: 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/2c/23/0f/2c230f3c-db35-43ea-f0dc-45284dad6bc7/886448400653.jpg/100x100bb.jpg',
    artistName: 'Natalie Taylor',
  );

  const params = SearchParams(term: 'Taylor');

  provideDummy<Either<Failure, List<TrackEntity>>>(const Right([testTrackEntity]));
  Failure failure = InternalServeFailure(suffix: 'in bloc test');
  provideDummy<Either<Failure, List<TrackEntity>>>(Left(failure));

  test('Should be Itunes State Initial', () {
    expect(itunesBloc.state, ItunesStateInitial());
  });

  blocTest<ItunesBloc, ItunesState>(
    'should emit Loading state and Successful state when data is gotten successfully',
    build: () {
      when(mockItunesSearchUseCase.call(params)).thenAnswer((_) async => const Right([testTrackEntity]));
      return itunesBloc;
    },
    act: (bloc) => bloc.add(const ItunesEventSearch(term: 'Taylor')),
    expect: () => [
      const ItunesStateLoading(),
      const ItunesStateSearchSuccessful([testTrackEntity])
    ],
  );

  blocTest<ItunesBloc, ItunesState>(
    'should emit Loading state and Failed state when data is gotten unsuccessfully',
    build: () {
      when(mockItunesSearchUseCase.call(params)).thenAnswer((_) async => Left(failure));
      return itunesBloc;
    },
    act: (bloc) => bloc.add(const ItunesEventSearch(term: 'Taylor')),
    expect: () => [
      const ItunesStateLoading(),
      ItunesStateFailed(failure.message),
    ],
  );
}
