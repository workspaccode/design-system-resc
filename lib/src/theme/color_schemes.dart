import 'package:material_ui/material_ui.dart';

/// Complete Material Design 3 color schemes for the design system
class AppColorSchemes {
  AppColorSchemes._();

  /// Light color scheme
  static const ColorScheme light = ColorScheme.light(
    primary: Color(0xFF52bc49),
    onPrimary: Color(0xFF000000),
    primaryContainer: Color(0xFFb8ffaf),
    onPrimaryContainer: Color(0xFF000000),
    primaryFixed: Color(0xFFb8ffaf),
    primaryFixedDim: Color(0xFF94e68a),
    onPrimaryFixed: Color(0xFF002200),
    onPrimaryFixedVariant: Color(0xFF067000),

    secondary: Color(0xFFf5f5f5),
    onSecondary: Color(0xFF000000),
    secondaryContainer: Color(0xFFf5f5f5),
    onSecondaryContainer: Color(0xFF000000),
    secondaryFixed: Color(0xFFf5f5f5),
    secondaryFixedDim: Color(0xFFe6e6e6),
    onSecondaryFixed: Color(0xFF000000),
    onSecondaryFixedVariant: Color(0xFF4d4d4d),

    tertiary: Color(0xFFf0f5f0),
    onTertiary: Color(0xFF000000),
    tertiaryContainer: Color(0xFFf5f5f5),
    onTertiaryContainer: Color(0xFF000000),
    tertiaryFixed: Color(0xFFf0f5f0),
    tertiaryFixedDim: Color(0xFFd4dcd4),
    onTertiaryFixed: Color(0xFF000000),
    onTertiaryFixedVariant: Color(0xFF3d4d3d),

    error: Color(0xFFBA1A1A),
    onError: Color(0xFFf5f5f5),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    surface: Color(0xFFf5f5f5),
    onSurface: Color(0xFF1C1B1F),
    surfaceDim: Color(0xFFDED8E1),
    surfaceBright: Color(0xFFf5f5f5),
    surfaceContainerLowest: Color(0xFFf5f5f5),
    surfaceContainerLow: Color(0xFFF7F2FA),
    surfaceContainer: Color(0xFFF3EDF7),
    surfaceContainerHigh: Color(0xFFECE6F0),
    surfaceContainerHighest: Color(0xFFE7E0EC),
    onSurfaceVariant: Color(0xFF49454F),

    outline: Color(0xFF79747E),
    outlineVariant: Color(0xFFCAC4D0),

    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),

    inverseSurface: Color(0xFF313033),
    onInverseSurface: Color(0xFFF4EFF4),
    inversePrimary: Color(0xFFb8ffaf),
    surfaceTint: Color(0xFF52bc49),
  );

  /// Dark color scheme
  static const ColorScheme dark = ColorScheme.dark(
    primary: Color(0xFF52bc49),
    onPrimary: Color(0xFF000000),
    primaryContainer: Color(0xFF067000),
    onPrimaryContainer: Color(0xFFf5f5f5),
    primaryFixed: Color(0xFFb8ffaf),
    primaryFixedDim: Color(0xFF52bc49),
    onPrimaryFixed: Color(0xFF002200),
    onPrimaryFixedVariant: Color(0xFF067000),

    secondary: Color(0xFFf5f5f5),
    onSecondary: Color(0xFF000000),
    secondaryContainer: Color(0xFFb3b3b3),
    onSecondaryContainer: Color(0xFF000000),
    secondaryFixed: Color(0xFFf5f5f5),
    secondaryFixedDim: Color(0xFFe6e6e6),
    onSecondaryFixed: Color(0xFF000000),
    onSecondaryFixedVariant: Color(0xFF4d4d4d),

    tertiary: Color(0xFFf0f5f0),
    onTertiary: Color(0xFF000000),
    tertiaryContainer: Color(0xFFa3a9a3),
    onTertiaryContainer: Color(0xFF000000),
    tertiaryFixed: Color(0xFFf0f5f0),
    tertiaryFixedDim: Color(0xFFd4dcd4),
    onTertiaryFixed: Color(0xFF000000),
    onTertiaryFixedVariant: Color(0xFF3d4d3d),

    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),

    surface: Color(0xF171717),
    onSurface: Color(0xFFE6E1E5),
    surfaceDim: Color(0xFF0F0F0F),
    surfaceBright: Color(0xFF363438),
    surfaceContainerLowest: Color(0xFF0A0A0C),
    surfaceContainerLow: Color(0xFF171719),
    surfaceContainer: Color(0xFF1B1B1F),
    surfaceContainerHigh: Color(0xFF262529),
    surfaceContainerHighest: Color(0xFF313033),
    onSurfaceVariant: Color(0xFFCAC4D0),

    outline: Color(0xFF938F99),
    outlineVariant: Color(0xFF49454F),

    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),

    inverseSurface: Color(0xFFE6E1E5),
    onInverseSurface: Color(0xFF313033),
    inversePrimary: Color(0xFF52bc49),
    surfaceTint: Color(0xFF52bc49),
  );
}
