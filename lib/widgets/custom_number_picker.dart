import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomNumberPicker extends StatefulWidget {
  const CustomNumberPicker({super.key, required this.onValueChanged});

  final void Function(int) onValueChanged;

  @override
  State<CustomNumberPicker> createState() => _CustomNumberPickerState();
}

class _CustomNumberPickerState extends State<CustomNumberPicker> {
  int _value = 25;

  void _onValueChanged(int newValue) {
    setState(() {
      _value = newValue;
    });
    widget.onValueChanged(_value);
  }

  @override
  Widget build(BuildContext context) {
    return NumberPicker(
      value: _value,
      minValue: 1,
      maxValue: 60,
      onChanged: _onValueChanged,
      axis: Axis.horizontal,
    );
  }
}
