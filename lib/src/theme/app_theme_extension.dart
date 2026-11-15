import 'package:material_ui/material_ui.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  static const defaultLight = AppThemeExtension(
    primary: Color(0xFF52bc49),
    surface: Color(0xFFF5F5F5),
    surface2: Color(0xFFF2F2F2),
    border: Color(0xFFD9D9D9),
    textPrimary: Color(0xFF1C1B1F),
    textSecondary: Color(0xFF6B7280),
    textDim: Color(0xFF9CA3AF),
    scaffoldBg: Color(0xFFF5F5F5),
    neonGreen: Color(0xFF22C55E),
    neonRed: Color(0xFFEF4444),
    neonOrange: Color(0xFFF97316),
    neonBlue: Color(0xFF3B82F6),
    neonPurple: Color(0xFFA855F7),
    neonCyan: Color(0xFF06B6D4),
  );
  static const defaultDark = AppThemeExtension(
    primary: Color(0xFF52bc49),
    surface: Color(0xFF1B1B1F),
    surface2: Color(0xFF262529),
    border: Color(0xFF49454F),
    textPrimary: Color(0xFFE6E1E5),
    textSecondary: Color(0xFFCAC4D0),
    textDim: Color(0xFF938F99),
    scaffoldBg: Color(0xFF1B1B1F),
    neonGreen: Color(0xFF4ADE80),
    neonRed: Color(0xFFF87171),
    neonOrange: Color(0xFFFB923C),
    neonBlue: Color(0xFF60A5FA),
    neonPurple: Color(0xFFC084FC),
    neonCyan: Color(0xFF22D3EE),
  );
  final Color primary;
  final Color surface;
  final Color surface2;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDim;
  final Color scaffoldBg;
  final Color neonGreen;
  final Color neonRed;
  final Color neonOrange;
  final Color neonBlue;

  final Color neonPurple;

  final Color neonCyan;

  const AppThemeExtension({
    required this.primary,
    required this.surface,
    required this.surface2,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDim,
    required this.scaffoldBg,
    required this.neonGreen,
    required this.neonRed,
    required this.neonOrange,
    required this.neonBlue,
    required this.neonPurple,
    required this.neonCyan,
  });

  @override
  AppThemeExtension copyWith({
    Color? primary,
    Color? surface,
    Color? surface2,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textDim,
    Color? scaffoldBg,
    Color? neonGreen,
    Color? neonRed,
    Color? neonOrange,
    Color? neonBlue,
    Color? neonPurple,
    Color? neonCyan,
  }) {
    return AppThemeExtension(
      primary: primary ?? this.primary,
      surface: surface ?? this.surface,
      surface2: surface2 ?? this.surface2,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textDim: textDim ?? this.textDim,
      scaffoldBg: scaffoldBg ?? this.scaffoldBg,
      neonGreen: neonGreen ?? this.neonGreen,
      neonRed: neonRed ?? this.neonRed,
      neonOrange: neonOrange ?? this.neonOrange,
      neonBlue: neonBlue ?? this.neonBlue,
      neonPurple: neonPurple ?? this.neonPurple,
      neonCyan: neonCyan ?? this.neonCyan,
    );
  }

  @override
  AppThemeExtension lerp(covariant AppThemeExtension other, double t) {
    return AppThemeExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surface2: Color.lerp(surface2, other.surface2, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textDim: Color.lerp(textDim, other.textDim, t)!,
      scaffoldBg: Color.lerp(scaffoldBg, other.scaffoldBg, t)!,
      neonGreen: Color.lerp(neonGreen, other.neonGreen, t)!,
      neonRed: Color.lerp(neonRed, other.neonRed, t)!,
      neonOrange: Color.lerp(neonOrange, other.neonOrange, t)!,
      neonBlue: Color.lerp(neonBlue, other.neonBlue, t)!,
      neonPurple: Color.lerp(neonPurple, other.neonPurple, t)!,
      neonCyan: Color.lerp(neonCyan, other.neonCyan, t)!,
    );
  }
}
