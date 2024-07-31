import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:keysoctest/app.dart';
import 'package:keysoctest/injection_container.dart';
import 'package:keysoctest/util/observer.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  if (kDebugMode) {
    await dotenv.load(fileName: 'assets/env/.env.development');
  } else {
    await dotenv.load(fileName: 'assets/env/.env.production');
  }

  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Hive.initFlutter(),
    getTemporaryDirectory().then((path) async {
      HydratedBloc.storage =
          await HydratedStorage.build(storageDirectory: path);
    })
  ]);

  await initializeDependencies();

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}
