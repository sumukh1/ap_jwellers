import 'package:myapp/static/AppColors.dart';
import 'package:flutter/material.dart';

void loadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents user from closing it
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Loading..."),
            ],
          ),
        ),
      );
    },
  );
}

class LoadingWidget {
  static Widget get circularProgressIndicatorExpandRow {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [circularProgressIndicator],
      ),
    );
  }

  static Widget get circularProgressIndicatorWithRow {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [circularProgressIndicator],
    );
  }

  static Widget get circularProgressIndicator {
    return const _ColorChangingProgressIndicator();
  }

  static Widget get circularProgressIndicatorWithOutRowSmall {
    return SizedBox(width: 20, height: 20, child: circularProgressIndicator);
  }

  static Widget get circularProgressIndicatorCenter {
    return Center(child: circularProgressIndicator);
  }

  static Widget circularProgressIndicatorValue(double? value) {
    return SizedBox(
        width: 18,
        height: 18,
        child: Center(
            child: _ColorChangingProgressIndicator(value: value ?? 0.0)));
  }
}

// TODO : Need Review
class _ColorChangingProgressIndicator extends StatefulWidget {
  const _ColorChangingProgressIndicator({this.value});
  final double? value;
  @override
  _ColorChangingProgressIndicatorState createState() =>
      _ColorChangingProgressIndicatorState();
}

class _ColorChangingProgressIndicatorState
    extends State<_ColorChangingProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _colorAnimation = ColorTween(
      begin: AppColors.primary,
      end: AppColors.primary,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      strokeWidth: 8,
      valueColor: _colorAnimation,
      value: widget.value,
      strokeCap: StrokeCap.round,
    );
  }
}
