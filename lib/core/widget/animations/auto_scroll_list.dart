import 'package:flutter/material.dart';
import 'dart:async';

class AutoScrollingList extends StatefulWidget {
  const AutoScrollingList(
      {super.key,
      required this.itemSize,
      this.scrollDirection = Axis.vertical,
      this.physics,
      required this.itemBuilder,
      this.duration,
      required this.itemCount,
      this.scrollDirectionChange = false});

  @override
  _AutoScrollingListState createState() => _AutoScrollingListState();

  final double itemSize;
  final Axis scrollDirection;
  final int itemCount;
  final ScrollPhysics? physics;
  final Duration? duration;
  final bool scrollDirectionChange;
  final Widget Function(BuildContext context, int index) itemBuilder;
}

class _AutoScrollingListState extends State<AutoScrollingList> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;
  double scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    if (_scrollController.hasClients && widget.scrollDirectionChange) {
      setState(() {
        scrollOffset = _scrollController.position.maxScrollExtent;
      });
    }
    _timer =
        Timer.periodic(widget.duration ?? const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        if (widget.scrollDirectionChange) {
          if (scrollOffset == 0) {
            scrollOffset = maxScroll;
          } else {
            scrollOffset -= widget
                .itemSize; // 🔹 Adjust height to match item height + spacing
          }
          if (scrollOffset < 0) {
            scrollOffset = 0; // 🔄 Restart scrolling from the top
          }
        } else {
          if (scrollOffset == maxScroll) {
            scrollOffset = 0;
          } else {
            scrollOffset += widget
                .itemSize; // 🔹 Adjust height to match item height + spacing
          }
          if (scrollOffset > maxScroll) {
            scrollOffset = maxScroll; // 🔄 Restart scrolling from the top
          }
        }
        _scrollController.animateTo(
          scrollOffset,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.itemCount,
      scrollDirection: widget.scrollDirection,
      physics: widget.physics, // Disable manual scroll
      itemBuilder: (context, index) {
        return SizedBox(
          height: widget.itemSize,
          width: widget.itemSize,
          child: widget.itemBuilder(context, index),
        );
      },
    );
  }
}
