import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = FlexColorScheme.light(
    scheme: FlexScheme.indigoM3,
    useMaterial3: true,
  ).toTheme;
  static ThemeData darkTheme = FlexColorScheme.dark(
    scheme: FlexScheme.indigoM3,
    useMaterial3: true,
  ).toTheme;
}
