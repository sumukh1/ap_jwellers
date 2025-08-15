import 'package:flutter/material.dart';

class AppRow extends StatelessWidget {
  final List<AppColumn> children;
  final double? h_space;
  final int units;
  final double? v_space;
  final WrapAlignment? v_align;
  final WrapAlignment? h_align;
  const AppRow(
      {super.key,
      required this.children,
      this.h_space,
      this.v_space,
      this.v_align,
      this.h_align, this.units = 12});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
        double perUnitWidth = constraints.maxWidth /units;
        List<Widget> childrens =[];
        double screenWidth = MediaQuery.of(context).size.width;
        double smBreakpoint = 576; // mobile(0-576)
        double mdBreakpoint = 768; //tablet(576-768)
        double lgBreakpoint = 1499; //window laptop(768-1400) mac(above 1400)
        for(var col in children){
          int ixsm = col.xsm ?? units;
          int ism = col.sm ?? col.xsm ?? units;
          int imd = col.md ?? col.sm ?? col.xsm ?? units;
          int ilg = col.lg ?? col.md ?? col.sm ?? col.xsm ?? units;
          int columnWidth = ixsm; // Default is small
          if (screenWidth >= lgBreakpoint) {
            columnWidth = ilg;
          } else if (screenWidth >= mdBreakpoint) {
            columnWidth = imd;
          }else if(screenWidth >=smBreakpoint){
            columnWidth = ism;
          }
          final margin = col.margin ?? EdgeInsets.zero;
          childrens.add(Padding(
            padding: h_space!=null ? EdgeInsets.symmetric(horizontal: (h_space!/2)): EdgeInsets.zero,
            child: Container(
              color: col.color,
              height: col.height,
              padding: col.padding,
              margin: col.margin,
              decoration: col.decoration,
              width: (perUnitWidth * columnWidth)-(h_space??0)-(margin.horizontal),
              child: col,
            ),
          ));
        }
        return Wrap(
          alignment: h_align ?? WrapAlignment.start,
          runAlignment: v_align ?? WrapAlignment.start,
          runSpacing: v_space ?? 0,
          children: childrens,
        );
      }
    );
  }
}

class AppColumn extends StatelessWidget {
  final int? xsm;
  final int? sm;
  final int? md;
  final int? lg;
  final double? height;
  final Color? color;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final List<Widget> children;
  const AppColumn({
    super.key,
    this.xsm,
    this.sm,
    this.md,
    this.lg,
    required this.children,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.height,
    this.color,
    this.decoration,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment?? CrossAxisAlignment.start,
      mainAxisAlignment: mainAxisAlignment?? MainAxisAlignment.start,
      children: children,
    );
  }
}
