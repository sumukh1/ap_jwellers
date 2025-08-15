
import 'package:flutter/material.dart';

class CounterText extends StatelessWidget {
  final num targetValue;
  final int floatingPoints;
  final String pre;
  final String suff;
  final Duration duration;
  final TextStyle textStyle;

  const CounterText({
    super.key,
    required this.targetValue,
    this.duration = const Duration(seconds: 2),
    this.textStyle =  const TextStyle(
        fontSize: 26, fontWeight: FontWeight.bold),
    this.pre = "",
    this.suff = "",
    this.floatingPoints = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: targetValue.toDouble()),
      duration: duration,
      builder: (context, value, child) {
        return Text(
          pre + value.toStringAsFixed(floatingPoints) + suff,
          style: textStyle,
        );
      },
    );
  }
}
