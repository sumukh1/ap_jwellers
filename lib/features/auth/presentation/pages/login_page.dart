import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/widget/custom_screen.dart';
import 'package:myapp/features/auth/presentation/widgets/login_view.dart';
import 'package:myapp/static/constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const routeName = "/LoginPage";
  static String route() => routeName;

  static Widget builder(GoRouterState state) => const LoginPage();

  @override
  Widget build(BuildContext context) {
    return CustomMaterialScreen(
      padding: EdgeInsets.zero,
      backgroundColor: Constants.primary,
      body: LoginView(),
    );
  }
}
