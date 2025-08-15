import 'package:flutter/material.dart';

extension AppThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ThemeData get themeData => Theme.of(this);
  ButtonStyle get textThemeButtonStyle => themeData.textButtonTheme.style!;
  ButtonStyle get elevatedButtonStyle => themeData.elevatedButtonTheme.style!;
}
