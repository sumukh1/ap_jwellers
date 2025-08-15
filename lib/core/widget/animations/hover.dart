import 'package:flutter/material.dart';

class Hover extends StatefulWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final BoxDecoration? onHoverDecoration;
  final Duration? duration;
  final Curve? curve;
  final Widget? child;
  final Function(bool)? onHover;
  const Hover({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.child,
    this.decoration,
    this.onHoverDecoration,
    this.duration,
    this.curve,
    this.onHover,
  });

  @override
  State<Hover> createState() => _HoverState();
}

class _HoverState extends State<Hover> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _isHovered = true;
        if (widget.onHover != null) {
          widget.onHover!(true);
        }
      }),
      onExit: (_) => setState(() {
        _isHovered = false;
        if (widget.onHover != null) {
          widget.onHover!(false);
        }
      }),
      child: AnimatedContainer(
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        padding: widget.padding,
        curve: widget.curve ?? Curves.easeInOut,
        duration: widget.duration ?? const Duration(milliseconds: 500),
        decoration: _isHovered ? widget.onHoverDecoration : widget.decoration,
        child: widget.child,
      ),
    );
  }
}
