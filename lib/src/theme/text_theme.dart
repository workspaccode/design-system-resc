import 'package:material_ui/material_ui.dart';

/// Text theme configuration for the design system
class AppTextTheme {
  AppTextTheme._();

  /// Material Design 3 text theme
  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 57,
      fontWeight: FontWeight.w400,
      height: 1.12,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 45,
      fontWeight: FontWeight.w400,
      height: 1.16,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 32,
      fontWeight: FontWeight.w400,
      height: 1.25,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 22,
      fontWeight: FontWeight.w400,
      height: 1.27,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.50,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.43,
    ),
  );
}
