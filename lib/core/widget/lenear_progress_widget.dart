import 'package:flutter/material.dart';
import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/static/AppColors.dart';

class LenearProgressWidget extends StatelessWidget {
  final int value;
  final int total;

  const LenearProgressWidget(
      {super.key, required this.value, required this.total});

  @override
  Widget build(BuildContext context) {
    double progressValue = (value + 1) / total;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0.0,
        end: progressValue,
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.white,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          minHeight: 10,
          borderRadius: Styles.borderRadius08,
        );
      },
    );
  }
}
