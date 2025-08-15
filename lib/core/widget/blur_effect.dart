import 'dart:ui';
import 'package:flutter/material.dart';

class BlurEffect extends StatelessWidget {
  final bool isBlur;
  final Widget child;
  final double sigmaX;
  final double sigmaY;

  const BlurEffect({
    Key? key,
    required this.isBlur,
    required this.child,
    this.sigmaX = 5.0,
    this.sigmaY = 5.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isBlur) return child;

    return Stack(
      children: [
        child,
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
            child: Container(
              color: Colors.transparent, // Needed for blur to take effect
            ),
          ),
        ),
      ],
    );
  }
}
