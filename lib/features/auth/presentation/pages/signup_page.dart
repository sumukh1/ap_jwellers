import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/widget/custom_screen.dart';
import 'package:myapp/core/widget/lenear_progress_widget.dart';
import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/features/auth/presentation/widgets/domain_view.dart';
import 'package:myapp/features/auth/presentation/widgets/logoPage_view.dart';
import 'package:myapp/features/auth/presentation/widgets/signup_form.dart';
import 'package:myapp/static/AppColors.dart';
import 'package:myapp/static/AppNavigator.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static const routeName = "/SignupPage";
  static String route() => routeName;

  static Widget builder(GoRouterState state) => const SignupPage();

  @override
  State<StatefulWidget> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  List pages = [];
  int index = 0;
  void onNext() {
    if (index < pages.length - 1) {
      setState(() {
        index++;
      });
    }
  }

  void onPrevious() {
    if (index > 0) {
      setState(() {
        index--;
      });
    } else {
      AppNavigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    pages = [
      SignupForm(onNext: onNext),
      DomainView(onNext: onNext),
      LogoPageView(onNext: onNext),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomMaterialScreen(
        padding: EdgeInsets.zero,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: Styles.edgeH16 + Styles.edgeInsetsOnlyT16,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onPrevious,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.buttonText,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  Styles.gap10,
                  Expanded(
                    child: LenearProgressWidget(
                      total: pages.length,
                      value: index,
                    ),
                  ),
                ],
              ),
            ),
            if (pages.isNotEmpty)
              Expanded(
                child: pages[index],
              ),
          ],
        ));
  }
}
