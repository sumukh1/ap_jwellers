import 'package:flutter/material.dart';
import 'package:myapp/features/categories/presentation/widgets/categories_view.dart';
import 'package:go_router/go_router.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  static const routeName = "/CategoriesPage";
  static String route() => routeName;

  static Widget builder(GoRouterState state) => const CategoriesPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: CategoriesView(),
    );
  }
}