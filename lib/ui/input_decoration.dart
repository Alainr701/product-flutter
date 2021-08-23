import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String labelText,
    required String hintText,
    IconData? icon,
  }) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: Colors.red,
              )
            : null);
  }
}
