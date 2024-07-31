import 'package:flutter/material.dart';
import 'package:keysoctest/config/routes/app_route_config.dart';
import 'package:keysoctest/injection_container.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final router = sl.get<AppRouteConfig>().router;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'iTunes Music Search',
      routerConfig: router,
    );
  }
}
