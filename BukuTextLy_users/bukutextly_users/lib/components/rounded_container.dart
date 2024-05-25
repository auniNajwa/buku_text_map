import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundedContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showborder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const RoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = 16,
    this.child,
    this.showborder = false,
    this.borderColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showborder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
