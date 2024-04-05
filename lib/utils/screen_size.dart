import 'package:flutter/material.dart';

class ScreenSize {
  static double width = 0;
  static double height = 0;

  static void init(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }
}
