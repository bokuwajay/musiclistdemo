import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:keysoctest/core/api/api_helper.dart';
import 'package:keysoctest/features/iTunes/data/models/track_model.dart';
import 'package:keysoctest/features/iTunes/domain/usecases/usecase_params.dart';
import 'package:keysoctest/util/logger.dart';

abstract class ItunesRemoteDataSource {
  Future<List<TrackModel>> search(SearchParams params);
}

class ItunesRemoteDataSourceImpl extends ItunesRemoteDataSource {
  final ApiHelper _apiHelper;
  ItunesRemoteDataSourceImpl(this._apiHelper);

  @override
  Future<List<TrackModel>> search(SearchParams params) async {
    try {
      final response = await _apiHelper.execute(
        method: Method.get,
        baseUrl: dotenv.env['itunesBaseURL'],
        endpoint: '/search?term=${params.term.replaceAll(' ', '+')}&limit=200&media=music',
      );
      var result = response['results'] as List;
      final trackModels = result.map((e) => TrackModel.fromJson(e)).toList();
      return trackModels;
    } catch (exception) {
      logger.e('Logger in search of ItunesRemoteDatasourceImpl\nrethrow: $exception');
      rethrow;
    }
  }
}
