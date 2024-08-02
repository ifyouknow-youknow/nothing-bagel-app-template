import 'package:flutter/material.dart';

class SpacerView extends StatelessWidget {
  final double height;
  const SpacerView({super.key, this.height = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
    );
  }
}
