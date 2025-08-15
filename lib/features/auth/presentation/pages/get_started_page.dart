import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/widget/custom_screen.dart';
import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/core/widget/form.dart';
import 'package:myapp/features/auth/presentation/pages/second_screen_page.dart';
import 'package:myapp/static/AppImages.dart';
import 'package:myapp/static/AppNavigator.dart';

class FirstScreenPage extends StatelessWidget {
  const FirstScreenPage({super.key});

  static const routeName = "/FirstScreenPage";
  static String route() => routeName;

  static Widget builder(GoRouterState state) => const FirstScreenPage();

  @override
  Widget build(BuildContext context) {
    return CustomMaterialScreen(
      padding: Styles.edgeZero,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const Padding(
            padding: Styles.edgeAll16,
            child: Column(
              children: [
                _Image(
                  path: AppImages.work,
                  flex: 2,
                ),
                Styles.gap10,
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      _Image(path: AppImages.team),
                      Styles.gap10,
                      _Image(path: AppImages.animatedImage),
                    ],
                  ),
                ),
                Styles.gap10,
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _Image(path: AppImages.women),
                            Styles.gap10,
                            _Image(path: AppImages.books2),
                          ],
                        ),
                      ),
                      Styles.gap10,
                      _Image(path: AppImages.smileWomen)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black])),
          )),
          Positioned(
            child: Button(
              height: 50,
              margin: Styles.edgeAll10,
              onTap: () {
                AppNavigator.push(context, SecondScreenPage.route());
              },
              label: "Get Started",
              borderColor: null,
            ),
          ),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({required this.path, this.flex = 1});
  final String path;
  final int flex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: ClipRRect(
        borderRadius: Styles.borderRadius15,
        child: Image.asset(path,
            width: double.infinity, height: double.infinity, fit: BoxFit.cover),
      ),
    );
  }
}
