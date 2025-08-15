
import 'dart:async';

import 'package:flutter/material.dart';

class TimerByDate extends StatefulWidget{
  final DateTime date;

  const TimerByDate({super.key, required this.date});
  @override
  State<StatefulWidget> createState() =>_TimerByDateState();

}

class _TimerByDateState extends State<TimerByDate>{
  late Timer _timer;
  Duration remainingTime = Duration.zero;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime = widget.date.difference(DateTime.now());
        if (remainingTime.isNegative) {
          _timer.cancel();
          remainingTime = Duration.zero;
        }
      });
    });
  }
  String formatTime(Duration duration) {
    // Get the number of days, hours, minutes, and seconds
    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;

    // Return the formatted string
    return '${days}Day ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Text(formatTime(remainingTime),
      style: const TextStyle(
      color: Colors.red,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),);
  }

}