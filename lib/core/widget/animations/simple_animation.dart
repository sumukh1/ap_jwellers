import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomAnimatedWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final bool fade;
  final bool slide;
  final bool scale;

  const CustomAnimatedWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.fade = true,
    this.slide = false,
    this.scale = false,
  });

  @override
  Widget build(BuildContext context) {
    var animation = child.animate();

    if (fade) {
      animation = animation.fadeIn(duration: duration);
    }
    if (slide) {
      animation = animation.slideY(begin: 0.3, end: 0, duration: duration);
    }
    if (scale) {
      animation = animation.scale(duration: duration);
    }

    return animation;
  }
}
