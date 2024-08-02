import 'package:flutter/material.dart';

class AccordionView extends StatefulWidget {
  final Widget topWidget;
  final Widget bottomWidget;

  const AccordionView(
      {super.key, required this.topWidget, required this.bottomWidget});

  @override
  State<AccordionView> createState() => _AccordionViewState();
}

class _AccordionViewState extends State<AccordionView> {
  bool _toggle = false;

  void _toggleAccordion() {
    setState(() {
      _toggle = !_toggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: _toggleAccordion,
          child: widget.topWidget,
        ),
        if (_toggle) widget.bottomWidget,
      ],
    );
  }
}
