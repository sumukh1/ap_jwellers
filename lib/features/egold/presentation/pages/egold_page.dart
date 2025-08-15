import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/egold/presentation/widgets/egold_view.dart';

class EGoldPage extends StatelessWidget {
  const EGoldPage({super.key});

  static const routeName = "/EGoldPage";
  static String route() => routeName;

  static Widget builder(GoRouterState state) => const EGoldPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Gold'),
      ),
      body: const EGoldView(),
    );
  }
}