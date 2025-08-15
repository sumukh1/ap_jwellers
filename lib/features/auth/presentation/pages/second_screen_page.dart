import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/widget/custom_screen.dart';
import 'package:myapp/features/auth/presentation/widgets/second_screen_view.dart';

class SecondScreenPage extends StatelessWidget {
  const SecondScreenPage({super.key});

  static const routeName = "/SecondScreenPage";
  static String route() => routeName;

  static Widget builder(GoRouterState state) => const SecondScreenPage();

  @override
  Widget build(BuildContext context) {
    return const CustomMaterialScreen(
      padding: EdgeInsets.zero,
      body: SecondScreenView(),
    );
  }
}
