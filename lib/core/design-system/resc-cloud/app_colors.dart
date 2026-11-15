import 'package:material_ui/material_ui.dart';

/// **RESC IoT — Calm Saudi Premium tokens**
///
/// Neutral surface hierarchy (primary / secondary / tertiary) with shadow-based
/// depth — no glass, no borders. All neutrals are pure gray (no warm tint).
/// All public names preserved for backward compatibility; values updated.
class AppColors {
  /// Brand green deepened slightly so it stays legible on warm sand surfaces.
  /// `oklch(0.62 0.17 142)` → `#3F9D43`. (Was `#51B848`.)
  static const Color primary = Color(0xFF3F9D43);

  // ───────────────────────────────────────────────────────────────────────
  // Brand
  // ───────────────────────────────────────────────────────────────────────
  static const Color primaryLight = Color(0xFFDCEED6);
  static const Color primaryDark = Color(0xFF2E7D32);
  static const Color primaryContainer = Color(0xFFDCEED6);

  /// Secondary is reserved — used only for warning/highlight roles, never decoratively.
  static const Color secondary = Color(0xFFD4A03B); // warm amber

  static const Color secondaryLight = Color(0xFFF5DDA8);
  static const Color secondaryDark = Color(0xFF9C6F1F);
  static const Color secondaryContainer = Color(0xFFF7E6BC);

  /// Scaffold/base background (primary). Light gray, never pure white.
  static const Color surface = Color(0xFFF2F2F2);

  // ─────────────────────────────────────────────────────────────────────────
  // Background hierarchy (primary / secondary / tertiary)
  // ─────────────────────────────────────────────────────────────────────────
  /// Primary background — base scaffold. Light: #F2F2F2, Dark: #0D0D0D.
  static const Color backgroundPrimary = surface;

  /// Secondary background — sits behind content blocks.
  /// Light: #F7F7F7, Dark: #1A1A1A.
  static const Color backgroundSecondary = Color(0xFFF7F7F7);

  /// Tertiary background — elevated containers (cards).
  /// Light: #FFFFFF, Dark: #262626.
  static const Color backgroundTertiary = Color(0xFFFFFFFF);

  // ─────────────────────────────────────────────────────────────────────────
  // Surfaces (light)
  // ─────────────────────────────────────────────────────────────────────────
  /// Raised surface (cards, sheets, top app bar fill) — maps to tertiary bg.
  static const Color surfaceRaised = backgroundTertiary;

  /// Sunken surface (inputs, chart wells, code blocks).
  static const Color surfaceSunken = backgroundSecondary;

  // Material 3 alias names — mapped onto the background hierarchy.
  static const Color surfaceVariant = surfaceRaised;

  static const Color surfaceContainer = surfaceRaised;
  static const Color surfaceContainerHigh = surfaceSunken;
  static const Color surfaceContainerHighest = backgroundSecondary;
  static const Color background = surface;

  static const Color backgroundDark = Color(0xFF0D0D0D);
  // ───────────────────────────────────────────────────────────────────────
  // Text / on-* (light)
  // ───────────────────────────────────────────────────────────────────────
  static const Color onPrimary = Color(0xFFF2F2F2);

  static const Color onSecondary = Color(0xFF1F2620);
  static const Color textPrimary = Color(0xFF0D0D0D);
  static const Color textSecondary = Color(0xFF5C5C5C);
  static const Color textTertiary = Color(0xFF7A7A7A);
  static const Color onSurface = textPrimary;
  static const Color onBackground = textPrimary;
  static const Color onSurfaceVariant = textSecondary;
  // ───────────────────────────────────────────────────────────────────────
  // Status (used **only** for status, never decoratively)
  // ───────────────────────────────────────────────────────────────────────
  static const Color status = Color(0xFF3F8AC9); // info

  static const Color info = Color(0xFF3F8AC9);
  static const Color infoContainer = Color(0xFFD7E8F5);
  static const Color error = Color(0xFFD44B3D);

  static const Color critical = Color(0xFFD44B3D);
  static const Color errorContainer = Color(0xFFF8DCD7);
  static const Color onError = Color(0xFFF2F2F2);
  static const Color onErrorContainer = Color(0xFF4A1612);
  static const Color success = Color(0xFF3DA855);

  static const Color successContainer = Color(0xFFD3ECD8);
  static const Color warning = Color(0xFFD4A03B);
  static const Color warningContainer = Color(0xFFF5E5BD);
  // ───────────────────────────────────────────────────────────────────────
  // Gradients (kept for back-compat; used sparingly — prefer flat surfaces)
  // ───────────────────────────────────────────────────────────────────────
  static const Color gradientGreenStart = Color(0xFF2E7D32);

  static const Color gradientGreenEnd = Color(0xFF6FBE6B);
  static const Color gradientBackgroundStart = surface;

  static const Color gradientBackgroundEnd = surfaceRaised;
  // ─────────────────────────────────────────────────────────────────────────
  // Neutral scale (light) — neutral gray hierarchy.
  // ─────────────────────────────────────────────────────────────────────────
  static const Color neutral0 = Color(0xFFF2F2F2);

  static const Color neutral10 = Color(0xFFE6E6E6);
  static const Color neutral20 = Color(0xFFD0D0D0);
  static const Color neutral30 = Color(0xFFB8B8B8);
  static const Color neutral40 = Color(0xFF9A9A9A);
  static const Color neutral50 = Color(0xFF7A7A7A);
  static const Color neutral60 = Color(0xFF5C5C5C);
  static const Color neutral70 = Color(0xFF404040);
  static const Color neutral80 = Color(0xFF2A2A2A);
  static const Color neutral90 = Color(0xFF1A1A1A);
  static const Color neutral100 = Color(0xFF0D0D0D);
  static const Color neutral = neutral60;

  // ─────────────────────────────────────────────────────────────────────────
  // Surfaces (dark) — neutral near-black hierarchy.
  // ─────────────────────────────────────────────────────────────────────────
  static const Color darkSurface = Color(0xFF0D0D0D);

  static const Color darkBackground = Color(0xFF0D0D0D);
  static const Color darkSurfaceRaised = Color(0xFF262626);
  static const Color darkSurfaceSunken = Color(0xFF1A1A1A);
  static const Color darkSurfaceVariant = darkSurfaceRaised;
  static const Color darkOnSurface = Color(0xFFF0F0F0);
  static const Color darkOnBackground = Color(0xFFF0F0F0);
  static const Color darkPrimary = Color(
    0xFF5BB955,
  ); // brand brightened for dark

  // ───────────────────────────────────────────────────────────────────────
  // Misc / decoration
  // ───────────────────────────────────────────────────────────────────────
  static const Color accent = Color(0xFFD4A03B);

  static const Color highlight = Color(0xFF3DA855);
  static const Color border = Color(0xFFD6D6D6);

  static const Color divider = Color(0xFFD6D6D6);
  static const Color shadow = Color(0x14000000); // 8% black

  static const Color shadowDark = Color(
    0x29000000,
  ); // 16% pure-black under dark
  // Dark neutral scale — neutral gray hierarchy.
  static const Color darkNeutral10 = Color(0xFF0D0D0D);

  static const Color darkNeutral20 = Color(0xFF1A1A1A);
  static const Color darkNeutral30 = Color(0xFF262626);
  static const Color darkNeutral40 = Color(0xFF3A3A3A);
  static const Color darkNeutral50 = Color(0xFF555555);
  static const Color darkNeutral60 = Color(0xFF7A7A7A);
  static const Color darkNeutral70 = Color(0xFFB0B0B0);
  static const Color darkNeutral80 = Color(0xFFD0D0D0);
  static const Color darkNeutral90 = Color(0xFFF0F0F0);
  AppColors._();
}

/// Theme-aware color helpers. Use these inside widgets instead of hardcoded
/// `Colors.white` / `Colors.black` / `AppColors.primary` etc.
extension AppColorsExtension on BuildContext {
  Color get accentColor => AppColors.accent;

  Color get blackText => Colors.black;

  Color get borderColor => borderSubtle;
  Color get borderSubtle => isDark ? AppColors.darkNeutral40 : AppColors.border;
  Color get brandSoft => primaryContainerColor;
  // ── Component helpers (legacy) ────────────────────────────────────────
  Color get cardBackground => surfaceRaised;
  Color get cardBorder => borderSubtle;
  ColorScheme get colors => Theme.of(this).colorScheme;
  Color get dividerColor => borderSubtle;

  Color get iconColorPrimary => colors.onSurface;
  Color get iconColorSecondary => colors.onSurfaceVariant;
  Color get inputBackground => surfaceSunken;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  /// Card fill: warm off-white in light, translucent white in dark.
  Color get liquidCardFill =>
      isDark ? const Color(0x0BFFFFFF) : AppColors.onPrimary;

  /// Card shadow matching the fill mode.
  List<BoxShadow> get liquidCardShadow => isDark
      ? const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 24,
            offset: Offset(0, 4),
          ),
        ]
      : const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ];
  // ── Text ──────────────────────────────────────────────────────────────
  Color get onSurfaceColor => colors.onSurface;

  Color get onSurfaceVariantColor => colors.onSurfaceVariant;
  // ── Borders / dividers ────────────────────────────────────────────────
  Color get outlineColor => colors.outline;
  // ── Brand / accents ───────────────────────────────────────────────────
  Color get primaryColor => isDark ? AppColors.darkPrimary : AppColors.primary;
  Color get primaryContainerColor =>
      isDark ? const Color(0xFF1F3D22) : AppColors.primaryContainer;
  Color get progressTrackColor => surfaceSunken;

  /// Page scaffold background: near-black in dark, light gray in light.
  Color get scaffoldBg => isDark ? const Color(0xFF0D0D0D) : AppColors.surface;
  Color get secondaryColor => AppColors.secondary;
  // ── Shadows ───────────────────────────────────────────────────────────
  Color get shadowColor => colors.shadow;

  Color get shadowColorLight => shadowSoft;
  Color get shadowSoft => isDark
      ? const Color(0x33000000) // 20% black for dark elevations
      : const Color(0x14000000); // 8% black for light elevations
  Color get subtleBackground => surfaceSunken;
  // ── Surfaces ──────────────────────────────────────────────────────────
  Color get surfaceColor => colors.surface;
  Color get surfaceContainerHighestColor => colors.surfaceContainerHighest;

  Color get surfaceRaised =>
      isDark ? const Color(0xFF262626) : AppColors.surfaceRaised;
  Color get surfaceSunken => isDark ? Colors.transparent : Colors.transparent;
  Color get surfaceTransparent => isDark
      ? const Color(0x0BFFFFFF)
      : const Color.fromARGB(255, 255, 255, 255);

  Color get surfaceTransparent2 => isDark
      ? const Color(0x00000000)
      : const Color.fromARGB(255, 255, 255, 255);
  Color get tabBarBackground => surfaceRaised;

  Color get tabIndicatorColor => primaryColor;
  Color get tabSelectedTextColor => AppColors.onPrimary;
  Color get tabUnselectedTextColor => textSecondaryColor;
  Color get textHintColor => textTertiaryColor;

  Color get textOnPrimaryColor => AppColors.onPrimary;

  // ── Liquid-glass card ─────────────────────────────────────────────────
  Color get textPrimaryColor => colors.onSurface;

  Color get textSecondaryColor => colors.onSurfaceVariant;

  Color get textTertiaryColor =>
      isDark ? AppColors.darkNeutral60 : AppColors.textTertiary;
}
