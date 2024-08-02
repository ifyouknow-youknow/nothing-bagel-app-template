import 'package:flutter/material.dart';

class DropdownView extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String>? onChanged;

  const DropdownView({
    super.key,
    required this.items,
    required this.onChanged,
  });

  @override
  _DropdownViewState createState() => _DropdownViewState();
}

class _DropdownViewState extends State<DropdownView> {
  late String _selectedItem = "One";

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _selectedItem,
      items: widget.items.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedItem = value.toString();
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value.toString());
        }
      },
    );
  }
}
