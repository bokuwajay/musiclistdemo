import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keysoctest/config/routes/app_route.dart';

class AppRouteConfig {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.initialScreen.path,
    routes: [
      GoRoute(
        path: AppRoute.initialScreen.path,
        name: AppRoute.initialScreen.name,
        builder: (context, state) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ],
  );
}
