import 'dart:async';
import 'package:flutter/material.dart';

enum AnimatedTextType { typing, scale, bounce }

class AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final AnimatedTextType type;
  final Duration duration; // per-character animation duration
  final Duration? repeatDuration; // null = no repeat

  const AnimatedText({
    super.key,
    required this.text,
    required this.type,
    this.style,
    this.duration = const Duration(milliseconds: 200),
    this.repeatDuration,
  });

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _displayedText = "";
  int _typingIndex = 0;
  Timer? _typingTimer;
  Timer? _repeatTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.text.length * widget.duration.inMilliseconds + 200,
      ),
    );

    _startAnimation();

    if (widget.repeatDuration != null) {
      _repeatTimer = Timer.periodic(widget.repeatDuration!, (timer) {
        _restartAnimation();
      });
    }
  }

  void _startAnimation() {
    if (widget.type == AnimatedTextType.typing) {
      _startTyping();
    } else {
      _controller.forward(from: 0);
    }
  }

  void _restartAnimation() {
    if (widget.type == AnimatedTextType.typing) {
      setState(() {
        _displayedText = "";
        _typingIndex = 0;
      });
      _startTyping();
    } else {
      _controller.forward(from: 0);
    }
  }

  void _startTyping() {
    _typingTimer?.cancel();
    _typingTimer = Timer.periodic(widget.duration, (timer) {
      if (_typingIndex < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_typingIndex];
          _typingIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _typingTimer?.cancel();
    _repeatTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == AnimatedTextType.typing) {
      return Text(_displayedText, style: widget.style);
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.text.length, (index) {
            final char = widget.text[index];
            final charStart = index / widget.text.length;
            final charEnd = charStart + (1 / widget.text.length);

            final animation = Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  charStart,
                  charEnd,
                  curve: widget.type == AnimatedTextType.scale
                      ? Curves.easeOutBack
                      : Curves.bounceOut,
                ),
              ),
            );

            if (widget.type == AnimatedTextType.scale) {
              return Transform.scale(
                scale: animation.value,
                child: Text(char, style: widget.style),
              );
            } else {
              return Transform.translate(
                offset: Offset(0, -10 * animation.value),
                child: Text(char, style: widget.style),
              );
            }
          }),
        );
      },
    );
  }
}
