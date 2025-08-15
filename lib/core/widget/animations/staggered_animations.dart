import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedColumn extends StatelessWidget {
  const AnimatedColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: List.generate(
          children.length,
          (index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 600),
            child: SlideAnimation(
              verticalOffset: 100,
              child: FadeInAnimation(child: children[index]),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedRow extends StatelessWidget {
  const AnimatedRow({
    super.key,
    required this.children,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: List.generate(
          children.length,
          (index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 600),
            child: SlideAnimation(
              verticalOffset: 100,
              child: FadeInAnimation(child: children[index]),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedListView extends StatelessWidget {
  const AnimatedListView({
    super.key,
    required this.children,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.physics,
  });
  final List<Widget> children;
  final Axis scrollDirection;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView(
        scrollDirection: scrollDirection,
        padding: padding,
        physics: physics,
        children: List.generate(
          children.length,
          (index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 600),
            child: SlideAnimation(
              verticalOffset: 100,
              child: FadeInAnimation(child: children[index]),
            ),
          ),
        ),
      ),
    );
  }
}
