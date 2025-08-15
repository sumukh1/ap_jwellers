import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/you/presentation/widgets/you_view.dart';

class YouPage extends StatelessWidget {
  const YouPage({super.key});

  static const routeName = "/YouPage";
  static String route() => routeName;

  static Widget builder(GoRouterState state) => const YouPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('You'),
      ),
      body: const Center(
        child: YouView(),
      ),
    );
  }
}