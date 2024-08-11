import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_bloc.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_event.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_state.dart';
import 'package:keysoctest/features/iTunes/presentation/pages/search_view.dart';
import 'package:mocktail/mocktail.dart';

class MockItunesBloc extends MockBloc<ItunesEvent, ItunesState> implements ItunesBloc {}

// here we test 3 things
// 1: the state of the app should change from Initial to Loading
// 2: display progress indicator
// 3: display the list of song when State Successful

void main() {
  late MockItunesBloc mockItunesBloc;

  setUp(() {
    mockItunesBloc = MockItunesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<ItunesBloc>(
      create: (context) => mockItunesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testTrackEntity = TrackEntity(
    trackName: 'Surrender',
    collectionName: 'Surrender - Single',
    image: 'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/2c/23/0f/2c230f3c-db35-43ea-f0dc-45284dad6bc7/886448400653.jpg/100x100bb.jpg',
    artistName: 'Natalie Taylor',
  );

  testWidgets('text field should trigger state from initial to loading', (widgetTester) async {
    // arrange
    when(() => mockItunesBloc.state).thenReturn(ItunesStateInitial());

    // act
    await widgetTester.runAsync(() async {
      await widgetTester.pumpWidget(_makeTestableWidget(const SearchView()));
      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await widgetTester.enterText(textField, 'Taylor');
      await widgetTester.pump();
      expect(find.text('Taylor'), findsOneWidget);
    });
  });

  testWidgets('should show progress indicator when state is loading', (widgetTester) async {
    // arrange
    when(() => mockItunesBloc.state).thenReturn(const ItunesStateLoading());

    // act
    await widgetTester.pumpWidget(_makeTestableWidget(const SearchView()));

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show widget contain data when state is successful', (widgetTester) async {
    // arrange
    when(() => mockItunesBloc.state).thenReturn(const ItunesStateSearchSuccessful([testTrackEntity]));

    // act
    await widgetTester.pumpWidget(_makeTestableWidget(const SearchView()));

    // assert
    expect(find.byKey(const Key('song list')), findsOneWidget);
  });
}
