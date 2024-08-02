import 'package:flutter/material.dart';

class ScrollableView extends StatelessWidget {
  final Widget child;
  final bool horizontal;

  const ScrollableView(
      {super.key, required this.child, this.horizontal = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: horizontal ? Axis.horizontal : Axis.vertical,
      child: child,
    );
  }
}
