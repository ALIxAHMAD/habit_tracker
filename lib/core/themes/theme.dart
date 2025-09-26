import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = FlexColorScheme.light(
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 15,
    appBarStyle: FlexAppBarStyle.scaffoldBackground,
    scheme: FlexScheme.indigoM3,
    useMaterial3: true,
  ).toTheme;
  static ThemeData darkTheme = FlexColorScheme.dark(
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 15,
    appBarStyle: FlexAppBarStyle.scaffoldBackground,
    scheme: FlexScheme.indigoM3,
    useMaterial3: true,
  ).toTheme;
}
