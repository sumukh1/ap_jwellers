import 'dart:async';
import 'package:myapp/static/constants.dart';
import 'package:flutter/material.dart';

class TimmerCounter extends StatefulWidget {
  final String targetDateTime; // Example: "2025-05-19T10:30:00"
  final double fontSize;
  final Color? color;

  const TimmerCounter({
    Key? key,
    required this.targetDateTime,
    this.fontSize = 12,
    this.color,
  }) : super(key: key);

  @override
  State<TimmerCounter> createState() => _TimmerCounterState();
}

class _TimmerCounterState extends State<TimmerCounter> {
  late Timer _timer;
  late DateTime _endTime;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _endTime = DateTime.tryParse(widget.targetDateTime) ?? DateTime.now();
    _updateRemaining();
    _startTimer();
  }

  void _updateRemaining() {
    final now = DateTime.now();
    _remaining = _endTime.difference(now);
    if (_remaining.isNegative) {
      _remaining = Duration.zero;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _updateRemaining();
        if (_remaining == Duration.zero) {
          _timer.cancel();
        }
      });
    });
  }

  String _formatDuration(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "${days > 0 ? (days.toString() + ' days') : ''} $hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _remaining == Duration.zero ? "Time Over" : _formatDuration(_remaining),
      style: TextStyle(
        fontSize: widget.fontSize,
        fontWeight: FontWeight.bold,
        color: widget.color ?? Constants.BLACK,
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
