import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class OnView extends StatefulWidget {
  const OnView(
      {super.key,
      required this.mykey,
      required this.child,
      this.fraction = 0.5});
  final Key mykey;
  final Widget child;
  final double fraction;
  @override
  State<OnView> createState() => _OnViewState();
}

class _OnViewState extends State<OnView> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.mykey,
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > widget.fraction) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: _isVisible
          ? widget.child
          : const SizedBox(
              height: 30,
              width: 30,
            ),
    );
  }
}
