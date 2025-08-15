import 'package:go_router/go_router.dart';
import 'package:myapp/di/injection.dart';
import 'package:myapp/features/auth/presentation/pages/get_started_page.dart';
import 'package:myapp/features/auth/presentation/pages/login_page.dart';
import 'package:myapp/features/auth/presentation/pages/second_screen_page.dart';
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
      GoRoute(
        path: GetStartedPage.routeName,
        builder: (context, state) => GetStartedPage.builder(state),
      ),
      GoRoute(
        path: SecondScreenPage.routeName,
        builder: (context, state) => SecondScreenPage.builder(state),
      ),
      GoRoute(
        path: LoginPage.routeName,
        builder: (context, state) => LoginPage.builder(state),
      ),
    ],
  );
}
