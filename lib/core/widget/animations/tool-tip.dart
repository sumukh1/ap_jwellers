import 'dart:math';
import 'package:myapp/static/constants.dart';
import 'package:flutter/material.dart';

class HoverTooltip extends StatefulWidget {
  final Widget child;
  final Widget tipChild;
  final BoxDecoration? tipDecoration;
  final bool down;

  const HoverTooltip({
    super.key,
    required this.child,
    required this.tipChild,
    this.tipDecoration,
    this.down = false,
  });

  @override
  State<HoverTooltip> createState() => _HoverTooltipState();
}

class _HoverTooltipState extends State<HoverTooltip>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _rotationAnimation =
        Tween<double>(begin: -pi / 2, end: widget.down ? -pi : 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool hovering) {
    setState(() {
      _isHovered = hovering;
      if (hovering) {
        _controller.forward(); // Start animation on hover
      } else {
        _controller.reverse(); // Reverse animation when hover ends
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: Stack(
        alignment: widget.down ? Alignment.bottomCenter : Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          widget.child,
          Positioned(
            child: AnimatedOpacity(
              opacity: _isHovered ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value, // Apply rotation
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        const SizedBox(),
                        Positioned(
                            top: -50,
                            child: Transform.rotate(
                              angle: widget.down ? pi : 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: widget.tipDecoration ??
                                    BoxDecoration(
                                      color: Constants.BLACK,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Constants.WHITE,
                                            blurRadius: 3)
                                      ],
                                    ),
                                child: widget.tipChild,
                              ),
                            ))
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
