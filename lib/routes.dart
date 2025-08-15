import 'package:go_router/go_router.dart';
import 'package:myapp/di/injection.dart';
import 'package:myapp/splash_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: SplashScreen.routeName,
    navigatorKey: Injection.navigatorState,
    routes: [
      GoRoute(
        path: SplashScreen.routeName,
        builder: (context, state) => SplashScreen.builder(state),
      ),
    ],
  );
}
