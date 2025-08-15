import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/widget/custom_screen.dart';
import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/features/auth/presentation/widgets/verify_view.dart';
import 'package:myapp/static/AppColors.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({super.key});

  static const routeName = "/VerifyPage";
  static String route() => routeName;

  static Widget builder(GoRouterState state) => const VerifyPage();

  @override
  Widget build(BuildContext context) {
    return CustomMaterialScreen(
      padding: Styles.edgeAll16 + Styles.edgeInsetsOnlyT30,
      backgroundColor: AppColors.background,
      body: VerifyView(),
    );
  }
}
