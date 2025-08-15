import 'package:flutter/material.dart';

class ExpandingText extends StatelessWidget {
  final String text;
  final int defaultLines;
  final TextStyle? style;

  const ExpandingText({
    Key? key,
    required this.text,
    this.style,
    this.defaultLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> expanded = ValueNotifier(false);

    return GestureDetector(
      onTap: () => expanded.value = !expanded.value,
      child: ValueListenableBuilder<bool>(
        valueListenable: expanded,
        builder: (context, isExpanded, child) {
          return Text(
            text,
            style: style ?? const TextStyle(fontSize: 16),
            textAlign: TextAlign.start,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            maxLines: isExpanded ? null : defaultLines,
          );
        },
      ),
    );
  }
}
