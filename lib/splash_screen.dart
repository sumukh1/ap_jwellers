import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = "/SplashScreen";
  static String route() => '/SplashScreen';
  static Widget builder(GoRouterState state) {
    return const SplashScreen();
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // AppNavigator.pushReplacement(FirstScreenPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Loading...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
