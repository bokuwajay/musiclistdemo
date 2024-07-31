import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:keysoctest/app.dart';

void main() async {
  if (kDebugMode) {
    await dotenv.load(fileName: 'assets/env/.env.development');
  } else {
    await dotenv.load(fileName: 'assets/env/.env.production');
  }

  runApp(const MyApp());
}
