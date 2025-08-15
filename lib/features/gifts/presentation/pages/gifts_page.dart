import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/gifts/presentation/widgets/gifts_view.dart';

class GiftsPage extends StatelessWidget {
  const GiftsPage({super.key});

  static const routeName = "/GiftsPage";
  static String route() => routeName;

  static Widget builder(GoRouterState state) => const GiftsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gifts'),
      ),
      body: const GiftsView(),
    );
  }
}