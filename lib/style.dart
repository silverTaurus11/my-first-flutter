import 'package:flutter/material.dart';

class CustomStyle {
  static TextStyle? display5(BuildContext context) {
    return const TextStyle(
        color: Colors.black,
        decorationStyle: TextDecorationStyle.wavy,
        fontWeight: FontWeight.bold,
        fontSize: 20.0
    );
  }

  static TextStyle? formEditText(BuildContext context) {
    return const TextStyle(
        color: Colors.black,
        fontSize: 14.0
    );
  }

  static Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

}