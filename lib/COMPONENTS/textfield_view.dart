import 'package:flutter/material.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/colors.dart';

class TextfieldView extends StatefulWidget {
  final bool isAutoCorrect;
  final bool isAutoFocus;
  final String placeholder;
  final double size;
  final Color color;
  final Color backgroundColor;
  final double paddingV;
  final double paddingH;
  final bool enabled;
  final double borderWidth;
  final Color borderColor;
  final double radius;
  final TextInputType keyboardType;
  final int max;
  final int maxLines;
  final int minLines;
  final bool isPassword;
  final ValueChanged<String>? onChanged; // Add a callback for text change

  const TextfieldView({
    super.key,
    this.isAutoCorrect = false,
    this.isAutoFocus = false,
    this.placeholder = "Enter text here...",
    this.size = 16,
    this.color = Colors.black,
    this.backgroundColor = Colors.black12,
    this.paddingV = 10,
    this.paddingH = 16,
    this.enabled = true,
    this.borderWidth = 0,
    this.borderColor = Colors.black,
    this.radius = 8,
    this.keyboardType = TextInputType.text,
    this.max = 0,
    this.maxLines = 1,
    this.minLines = 1,
    this.isPassword = false,
    this.onChanged, // Initialize the callback
  });

  @override
  _TextfieldViewState createState() => _TextfieldViewState();
}

class _TextfieldViewState extends State<TextfieldView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // Ensure there is a Material widget
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        child: TextField(
          controller: _controller,
          onChanged: widget.onChanged, // Use the callback for text change
          autocorrect: widget.isAutoCorrect,
          autofocus: widget.isAutoFocus,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            contentPadding: EdgeInsets.symmetric(
              vertical: widget.paddingV,
              horizontal: widget.paddingH,
            ),
            border: widget.borderWidth == 0
                ? InputBorder.none
                : OutlineInputBorder(
                    borderSide: BorderSide(
                        width: widget.borderWidth, color: widget.borderColor),
                    borderRadius: BorderRadius.circular(widget.radius)),
          ),
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          style: TextStyle(fontSize: widget.size, color: widget.color),
          maxLength: widget.max > 0 ? widget.max : null,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          minLines: widget.minLines,
          obscureText: widget.isPassword,
        ),
      ),
    );
  }
}
