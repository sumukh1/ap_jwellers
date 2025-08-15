import 'package:myapp/core/widget/styles.dart';
import 'package:flutter/material.dart';

class AppCustomListViewBuilder extends StatelessWidget {
  const AppCustomListViewBuilder({
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
    this.physics,
    this.shrinkWrap,
    this.isExpand = true,
    this.onRefresh,
    this.padding,
    this.scrollDirection = Axis.vertical,
    super.key,
    this.reverse,
    this.controller,
  });
  final Widget? Function(BuildContext context, int i) itemBuilder;
  final Widget Function(BuildContext context, int i)? separatorBuilder;
  final int itemCount;
  final ScrollPhysics? physics;
  final bool? shrinkWrap;
  final bool isExpand;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final Future<void> Function()? onRefresh;
  final bool? reverse;
  final ScrollController? controller;

  Widget __listView() {
    return separatorBuilder != null
        ? ListView.separated(
            controller: controller,
            separatorBuilder: separatorBuilder!,
            padding: padding ?? Styles.edgeInsetsOnlyT10,
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            scrollDirection: scrollDirection,
            physics: physics ?? NeverScrollableScrollPhysics(),
            shrinkWrap: shrinkWrap ?? false,
          )
        : ListView.builder(
            controller: controller,
            reverse: reverse ?? false,
            padding: padding ?? Styles.edgeInsetsOnlyT10,
            itemCount: itemCount,
            scrollDirection: scrollDirection,
            itemBuilder: itemBuilder,
            shrinkWrap: shrinkWrap ?? false,
            physics: physics ?? NeverScrollableScrollPhysics(),
          );
  }

  @override
  Widget build(BuildContext context) {
    final builder = onRefresh != null
        ? RefreshIndicator.adaptive(onRefresh: onRefresh!, child: __listView())
        : __listView();

    return isExpand ? Expanded(child: builder) : builder;
  }
}
