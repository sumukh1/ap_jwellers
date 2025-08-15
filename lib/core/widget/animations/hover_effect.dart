import 'package:myapp/static/constants.dart';
import 'package:flutter/material.dart';

class HoverEffect extends StatelessWidget {
  final Widget child;
  final double scaleFactor;
  final double elevation;
  final Duration duration;

  const HoverEffect({
    Key? key,
    required this.child,
    this.scaleFactor = 1.1, // Default scale effect
    this.elevation = 8.0, // Default elevation effect
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isHovered = ValueNotifier(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: isHovered,
        builder: (context, hover, childWidget) {
          return AnimatedContainer(
            duration: duration,
            curve: Curves.easeOut,
            transform: Matrix4.identity()..scale(hover ? scaleFactor : 1.0),
            decoration: BoxDecoration(
              boxShadow: hover
                  ? [
                      BoxShadow(
                        color: Constants.BLACK.withOpacity(0.2),
                        blurRadius: elevation,
                        spreadRadius: 2,
                      )
                    ]
                  : [],
            ),
            child: childWidget,
          );
        },
        child: child,
      ),
    );
  }
}
