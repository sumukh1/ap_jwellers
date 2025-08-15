import 'package:myapp/core/widget/styles.dart';
import 'package:flutter/material.dart';

class MouseOverEffect extends StatefulWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? circleSize;
  final double circleOpacity;
  final Color? circleColor;
  final double? blurIntensity;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;

  const MouseOverEffect({
    Key? key,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.circleSize,
    this.circleColor,
    this.blurIntensity,
    this.child,
    this.borderRadius,
    this.circleOpacity = 0.35,
  }) : super(key: key);

  @override
  _MouseOverEffectState createState() => _MouseOverEffectState();
}

class _MouseOverEffectState extends State<MouseOverEffect> {
  Offset? _cursorPosition;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      onHover: (event) {
        setState(() {
          _cursorPosition =
              Offset(event.localPosition.dx, event.localPosition.dy);
        });
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        child: Padding(
          padding: EdgeInsets.zero,
          child: ClipRRect(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
            child: Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor
                    ?.withOpacity(0.8), // Semi-transparent
                borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
              ),
              child: Stack(
                children: [
                  if (_isHovered && _cursorPosition != null)
                    Positioned(
                      left: _cursorPosition!.dx - (widget.circleSize ?? 80) / 2,
                      top:
                          (_cursorPosition!.dy - (widget.circleSize ?? 80) / 4),
                      child: IgnorePointer(
                        child: AnimatedOpacity(
                          opacity: _isHovered ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            width: widget.circleSize,
                            height: (widget.circleSize ?? 80) / 2,
                            decoration: BoxDecoration(
                              borderRadius: Styles.borderRadius50,
                              boxShadow: [
                                BoxShadow(
                                  color: widget.circleColor != null
                                      ? widget.circleColor!
                                          .withOpacity(widget.circleOpacity)
                                      : Colors.pink
                                          .withOpacity(widget.circleOpacity),
                                  blurRadius: widget.blurIntensity ?? 100,
                                  spreadRadius:
                                      widget.blurIntensity ?? 100 / 2.5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                      padding: widget.padding ?? EdgeInsets.zero,
                      child: widget.child),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
