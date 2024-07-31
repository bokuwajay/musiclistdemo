enum AppRoute {
  initialScreen(path: '/'),
  iTunes(path: '/iTunes');

  final String path;
  const AppRoute({required this.path});
}
