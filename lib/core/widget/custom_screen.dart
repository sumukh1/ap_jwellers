import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/static/AppColors.dart';
import 'package:myapp/static/AppNavigator.dart';
import 'package:flutter/material.dart';

class CustomScreen extends StatelessWidget {
  const CustomScreen(
      {super.key,
      required this.title,
      this.centerTitle = true,
      this.actions,
      this.body,
      this.floatingActionButton,
      this.backgroundColor,
      this.onBack});
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? body;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final Function()? onBack;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.buttonText,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                if (onBack != null) {
                  onBack!();
                } else {
                  AppNavigator.pop(context);
                }
              },
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.buttonText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}

class CustomMaterialScreen extends StatelessWidget {
  const CustomMaterialScreen({
    super.key,
    required this.body,
    this.padding,
    this.backgroundColor,
  });
  final Widget body;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ColoredBox(
        color: backgroundColor ?? AppColors.background,
        child: Padding(
          padding: padding ?? Styles.edgeAll16,
          child: body,
        ),
      ),
    );
  }
}
