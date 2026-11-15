import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_design_system/flutter_design_system.dart'
    hide AppColors; // Added for AppThemeExtension

import 'app_colors.dart';
import 'app_radii.dart';

/// **RESC IoT — Calm Saudi Premium theme.**
///
/// Light by default (sandy off-white surface), auto-switches to a warm dark
/// theme. Built on Material 3 + tokens from [AppColors] / [AppRadii].
class AppTheme {
  AppTheme._();

  // ────────────────────────────────────────────────────────────────────────
  // LIGHT
  // ────────────────────────────────────────────────────────────────────────
  static ThemeData get lightTheme {
    const scheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.primaryDark,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      //secondaryContainer: AppColors.secondaryContainer,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceContainer: AppColors.surfaceRaised,
      surfaceContainerHigh: AppColors.surfaceSunken,
      surfaceContainerHighest: AppColors.surfaceContainerHighest,
      onSurfaceVariant: AppColors.textSecondary,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      outline: AppColors.border,
      outlineVariant: AppColors.neutral30,
      shadow: AppColors.shadow,
      scrim: Color(0xCC1B1815),
    );

    return _baseTheme(
      scheme,
      Brightness.light,
    ).copyWith(scaffoldBackgroundColor: AppColors.surface);
  }

  // ────────────────────────────────────────────────────────────────────────
  // DARK
  // ────────────────────────────────────────────────────────────────────────
  static ThemeData get darkTheme {
    // Solid neutral dark theme — no glass. Brand-bright green accent.
    const scheme = ColorScheme.dark(
      primary: AppColors.darkPrimary,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF1F3D22),
      onPrimaryContainer: AppColors.primaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      surfaceContainer: Color(0xFF1A1A1A),
      surfaceContainerHigh: Color(0xFF262626),
      surfaceContainerHighest: Color(0xFF333333),
      onSurfaceVariant: AppColors.darkNeutral60,
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: Color(0xFF4A1612),
      onErrorContainer: AppColors.errorContainer,
      outline: Color(0xFF3A3A3A),
      outlineVariant: Color(0xFF2A2A2A),
      shadow: Color(0xFF000000),
      scrim: Color(0xCC000000),
    );

    return _baseTheme(
      scheme,
      Brightness.dark,
    ).copyWith(scaffoldBackgroundColor: const Color(0xFF0D0D0D));
  }

  // ────────────────────────────────────────────────────────────────────────
  // Shared base — everything below adapts to whichever ColorScheme is given.
  // ────────────────────────────────────────────────────────────────────────
  static ThemeData _baseTheme(ColorScheme s, Brightness b) {
    final isDark = b == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: b,
      colorScheme: s,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,

      // ── App bar — flat, on surface, NOT brand-filled ────────────────────
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
        titleTextStyle: TextStyle(
          color: s.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 1.2,
        ),
        iconTheme: IconThemeData(color: s.onSurface),
      ),

      // ── Cards — shadow-based depth, no border ───────────────────────────
      cardTheme: CardThemeData(
        elevation: 0,
        color:
            isDark ? AppColors.darkSurfaceRaised : AppColors.backgroundTertiary,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.card,
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Buttons ─────────────────────────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: s.primary,
          foregroundColor: s.onPrimary,
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.input),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          elevation: 0,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: s.primary,
          foregroundColor: s.onPrimary,
          elevation: 0,
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.input),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: s.primary,
          side: BorderSide(color: s.primary, width: 1),
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.input),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: s.primary,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),

      // ── Inputs ──────────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor:
            isDark ? AppColors.darkSurfaceSunken : AppColors.surfaceSunken,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: const OutlineInputBorder(
          borderRadius: AppRadii.input,
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AppRadii.input,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadii.input,
          borderSide: BorderSide(color: s.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadii.input,
          borderSide: BorderSide(color: s.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadii.input,
          borderSide: BorderSide(color: s.error, width: 2),
        ),
        labelStyle: TextStyle(color: s.onSurfaceVariant, fontSize: 14),
        hintStyle: TextStyle(
          color: isDark ? AppColors.darkNeutral60 : AppColors.textTertiary,
          fontSize: 14,
        ),
        errorStyle: TextStyle(color: s.error, fontSize: 12),
      ),

      // ── Bottom navigation ───────────────────────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.transparent,
        unselectedItemColor: s.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        indicatorColor: s.primaryContainer,
        elevation: 0,
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: s.primary, size: 24);
          }
          return IconThemeData(color: s.onSurfaceVariant, size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            color: selected ? s.primary : s.onSurfaceVariant,
            fontSize: 11,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          );
        }),
      ),

      // ── Tabs ────────────────────────────────────────────────────────────
      tabBarTheme: TabBarThemeData(
        labelColor: s.primary,
        unselectedLabelColor: s.onSurfaceVariant,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: s.primary, width: 2),
        ),
        dividerColor: s.outline,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),

      // ── Chips ───────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor:
            isDark ? AppColors.darkSurfaceRaised : AppColors.surfaceSunken,
        selectedColor: s.primaryContainer,
        labelStyle: TextStyle(
          color: s.onSurface,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide.none,
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.chip),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      // ── Dividers ────────────────────────────────────────────────────────
      dividerTheme: DividerThemeData(color: s.outline, thickness: 1, space: 1),

      // ── Bottom sheets ───────────────────────────────────────────────────
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: s.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.sheet),
        showDragHandle: true,
        dragHandleColor: s.outline,
        modalBackgroundColor: s.surface,
        modalElevation: 0,
        elevation: 0,
      ),

      // ── Dialogs ─────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: s.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.lg)),
        ),
        elevation: 0,
        titleTextStyle: TextStyle(
          color: s.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        contentTextStyle: TextStyle(
          color: s.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),

      // ── List tiles ──────────────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        iconColor: s.onSurfaceVariant,
        textColor: s.onSurface,
        tileColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        minVerticalPadding: 12,
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.input),
      ),

      // ── Switches ────────────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return s.onPrimary;
          return s.onSurfaceVariant;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return s.primary;
          return isDark ? AppColors.darkNeutral40 : AppColors.surfaceSunken;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // ── Progress indicators ─────────────────────────────────────────────
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: s.primary,
        linearTrackColor:
            isDark ? AppColors.darkNeutral30 : AppColors.surfaceSunken,
        circularTrackColor:
            isDark ? AppColors.darkNeutral30 : AppColors.surfaceSunken,
      ),

      // ── Cupertino integration (so iOS gets warm theme too) ──────────────
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: b,
        primaryColor: s.primary,
        scaffoldBackgroundColor: s.surface,
        barBackgroundColor: s.surface,
        textTheme: CupertinoTextThemeData(
          primaryColor: s.primary,
          textStyle: TextStyle(color: s.onSurface, fontSize: 15),
        ),
      ),

      // ── Page transitions ────────────────────────────────────────────────
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
        },
      ),
      extensions: [
        isDark ? AppThemeExtension.defaultDark : AppThemeExtension.defaultLight,
      ],
    );
  }

  /// Locale-aware font family resolver. Used by [MaterialApp.theme] consumer.
  static String? getFontFamily(Locale locale) {
    switch (locale.languageCode) {
      case 'ar':
        return 'Tajawal';
      default:
        return 'PlusJakartaSans';
    }
  }
}
