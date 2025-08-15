import 'package:myapp/static/constants.dart';
import 'package:flutter/material.dart';

class TypewriterText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Duration speed;
  final VoidCallback? onComplete;

  const TypewriterText({
    super.key,
    required this.text,
    this.textStyle,
    this.speed = const Duration(milliseconds: 50),
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> displayedText = ValueNotifier("");

    _startTyping(displayedText);

    return ValueListenableBuilder<String>(
      valueListenable: displayedText,
      builder: (context, value, child) {
        return Text(
          value,
          style: textStyle ?? TextStyle(fontSize: 18, color: Constants.WHITE),
          textAlign: TextAlign.center,
        );
      },
    );
  }

  void _startTyping(ValueNotifier<String> notifier) async {
    for (int i = 0; i <= text.length; i++) {
      await Future.delayed(speed);
      notifier.value = text.substring(0, i);
    }
    if (onComplete != null) onComplete!(); // Call callback after completion
  }
}
