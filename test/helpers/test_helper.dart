import 'package:keysoctest/core/api/api_helper.dart';
import 'package:keysoctest/features/iTunes/data/data_sources/itunes_remote_datasource.dart';
import 'package:keysoctest/features/iTunes/domain/repositories/itunes_repository.dart';
import 'package:keysoctest/features/iTunes/domain/usecases/itunes_search_usecase.dart';
import 'package:mockito/annotations.dart';

// we need the repository (abstract class ItunesRepository) here, but how can we test an abstract class
// the package mockito can help test an abstract class, we put the abstract class into the array

@GenerateMocks(
  [
    ItunesRepository,
    ItunesRemoteDataSource,
    ItunesSearchUseCase,
  ],
  customMocks: [MockSpec<ApiHelper>(as: #MockApiHelper)],
)
void main() {}
