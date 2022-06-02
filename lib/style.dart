import 'package:flutter/material.dart';

class Style {
  TextStyle numbers() {
    return const TextStyle(
      color: Colors.deepPurple,
      fontSize: 40,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle simbol() {
    return const TextStyle(
      color: Colors.red,
      fontSize: 50,
      fontWeight: FontWeight.w700,
    );
  }

  SizedBox sizedBox() {
    return const SizedBox(width: 35);
  }

  double scaleTimerSmall() {
    return 1.0;
  }

  double scaleTimerGigant() {
    return 1.4;
  }
}
