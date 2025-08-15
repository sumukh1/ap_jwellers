import 'package:go_router/go_router.dart';
import 'package:myapp/di/injection.dart';
import 'package:myapp/features/auth/presentation/pages/get_started_page.dart';
import 'package:myapp/features/auth/presentation/pages/login_page.dart';
import 'package:myapp/features/auth/presentation/pages/second_screen_page.dart';
import 'package:myapp/features/auth/presentation/pages/signup_page.dart';
import 'package:myapp/features/egold/presentation/pages/egold_page.dart';
import 'package:myapp/features/gifts/presentation/pages/gifts_page.dart';
import 'package:myapp/features/home/presentation/pages/home_page.dart';
import 'package:myapp/features/you/presentation/pages/you_page.dart';
import 'package:myapp/features/categories/presentation/pages/categories_page.dart';
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
        path: SignupPage.routeName,
        builder: (context, state) => SignupPage.builder(state),
      ),
      GoRoute(
        path: LoginPage.routeName,
        builder: (context, state) => LoginPage.builder(state),
      ),
      GoRoute(
        path: HomePage.routeName,
        builder: (context, state) => HomePage.builder(state),
      ),
      GoRoute(
        path: CategoriesPage.routeName,
        builder: (context, state) => CategoriesPage.builder(state),
      ),
      GoRoute(
        path: GiftsPage.routeName,
        builder: (context, state) => GiftsPage.builder(state),
      ),
      GoRoute(
        path: EGoldPage.routeName,
        builder: (context, state) => EGoldPage.builder(state),
      ),
      GoRoute(
        path: YouPage.routeName,
        builder: (context, state) => YouPage.builder(state),
      ),
    ],
  );
}
