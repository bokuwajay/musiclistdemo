// Mocks generated by Mockito 5.4.4 from annotations
// in keysoctest/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:fpdart/fpdart.dart' as _i4;
import 'package:keysoctest/core/api/api_helper.dart' as _i11;
import 'package:keysoctest/core/error/failures.dart' as _i5;
import 'package:keysoctest/features/iTunes/data/data_sources/itunes_remote_datasource.dart'
    as _i9;
import 'package:keysoctest/features/iTunes/data/models/track_model.dart'
    as _i10;
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart'
    as _i6;
import 'package:keysoctest/features/iTunes/domain/repositories/itunes_repository.dart'
    as _i2;
import 'package:keysoctest/features/iTunes/domain/usecases/itunes_search_usecase.dart'
    as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [ItunesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockItunesRepository extends _i1.Mock implements _i2.ItunesRepository {
  MockItunesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Either<_i5.Failure, List<_i6.TrackEntity>>> search(
          _i7.Params? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #search,
          [params],
        ),
        returnValue:
            _i3.Future<_i4.Either<_i5.Failure, List<_i6.TrackEntity>>>.value(
                _i8.dummyValue<_i4.Either<_i5.Failure, List<_i6.TrackEntity>>>(
          this,
          Invocation.method(
            #search,
            [params],
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, List<_i6.TrackEntity>>>);
}

/// A class which mocks [ItunesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockItunesRemoteDataSource extends _i1.Mock
    implements _i9.ItunesRemoteDataSource {
  MockItunesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i10.TrackModel>> search(_i7.Params? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #search,
          [params],
        ),
        returnValue:
            _i3.Future<List<_i10.TrackModel>>.value(<_i10.TrackModel>[]),
      ) as _i3.Future<List<_i10.TrackModel>>);
}

/// A class which mocks [ItunesSearchUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockItunesSearchUseCase extends _i1.Mock
    implements _i7.ItunesSearchUseCase {
  MockItunesSearchUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Either<_i5.Failure, List<_i6.TrackEntity>>> call(
          _i7.Params? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i3.Future<_i4.Either<_i5.Failure, List<_i6.TrackEntity>>>.value(
                _i8.dummyValue<_i4.Either<_i5.Failure, List<_i6.TrackEntity>>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, List<_i6.TrackEntity>>>);
}

/// A class which mocks [ApiHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiHelper extends _i1.Mock implements _i11.ApiHelper {
  MockApiHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<Map<String, dynamic>> execute({
    required _i11.Method? method,
    String? baseUrl,
    required String? endpoint,
    dynamic payload,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
          {
            #method: method,
            #baseUrl: baseUrl,
            #endpoint: endpoint,
            #payload: payload,
          },
        ),
        returnValue:
            _i3.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i3.Future<Map<String, dynamic>>);
}
