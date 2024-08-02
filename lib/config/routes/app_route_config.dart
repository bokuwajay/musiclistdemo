import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keysoctest/config/routes/app_route.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_bloc.dart';
import 'package:keysoctest/features/iTunes/presentation/pages/search_view.dart';
import 'package:keysoctest/injection_container.dart';
import 'package:lottie/lottie.dart';

class AppRouteConfig {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.initialScreen.path,
    routes: [
      GoRoute(
          path: AppRoute.initialScreen.path,
          name: AppRoute.initialScreen.name,
          builder: (context, state) {
            Timer(const Duration(seconds: 3), () {
              context.goNamed(AppRoute.iTunes.name);
            });

            return Center(
              child: LottieBuilder.asset('assets/lotties/transitionAnimation.json'),
            );
          }),
      GoRoute(
        path: AppRoute.iTunes.path,
        name: AppRoute.iTunes.name,
        builder: (context, state) {
          return BlocProvider<ItunesBloc>(
            create: (context) => sl.get<ItunesBloc>(),
            child: const SearchView(),
          );
        },
      ),
    ],
  );
}
