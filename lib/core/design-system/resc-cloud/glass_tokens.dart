import 'package:material_ui/material_ui.dart';

/// **RESC Glass tokens** — dark-mode glassmorphic values.
///
/// Kept for backward compatibility with widgets still referencing
/// `RescGlass` constants (radii, gradients, status colors). The main
/// theme (`app_theme.dart`) no longer uses these — it relies on
/// `AppColors` solid tokens for both light and dark modes.
///
/// All colors are constants so they can be used in `const` constructors.
class RescGlass {
  RescGlass._();

  // ── Base canvas ──────────────────────────────────────────────────────
  /// Deep green-black. Legacy dark scaffold background.
  static const Color bg = Color(0xFF080E0A);
  static const Color bgDeep = Color(0xFF040805);

  // ── Glass card surfaces ──────────────────────────────────────────────
  static const Color card = Color(0x0BFFFFFF);
  static const Color cardHover = Color(0x12FFFFFF);
  static const Color subTile = Color(0x0AFFFFFF);

  // ── Borders ──────────────────────────────────────────────────────────
  static const Color border = Color(0x13FFFFFF);
  static const Color borderSubtle = Color(0x0FFFFFFF);
  static const Color borderGreen = Color(0x3851B848);

  // ── Brand greens ─────────────────────────────────────────────────────
  static const Color green = Color(0xFF51B848);
  static const Color greenBright = Color(0xFF72EB62);
  static const Color greenDark = Color(0xFF2E7D32);
  static const Color greenSoft = Color(0x1A51B848);
  static const Color greenSofter = Color(0x0D51B848);

  // ── Text ─────────────────────────────────────────────────────────────
  static const Color textPri = Color(0xEBFFFFFF);
  static const Color textMid = Color(0x9EFFFFFF);
  static const Color textSec = Color(0x6BFFFFFF);
  static const Color textHint = Color(0x4DFFFFFF);

  // ── Status ───────────────────────────────────────────────────────────
  static const Color amber = Color(0xFFFFB300);
  static const Color blue = Color(0xFF3B9EFF);
  static const Color blueDark = Color(0xFF007AFF);
  static const Color red = Color(0xFFFF4040);
  static const Color gold = Color(0xFFFFC840);
  static const Color teal = Color(0xFF00D4AA);

  static const Color redSoft = Color(0x1AFF4040);
  static const Color redBorder = Color(0x40FF4040);

  // ── Shadows ──────────────────────────────────────────────────────────
  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x59000000),
    blurRadius: 24,
    offset: Offset(0, 4),
  );

  static const BoxShadow glowGreen = BoxShadow(
    color: Color(0x1C51B848),
    blurRadius: 28,
  );

  // ── Gradients ────────────────────────────────────────────────────────
  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [greenDark, green],
  );

  static const LinearGradient greenSurface = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0C2B12), Color(0xFF133A1A)],
  );

  // ── Radii ────────────────────────────────────────────────────────────
  static const double radiusCard = 20;
  static const double radiusTile = 12;
  static const double radiusButton = 14;
  static const double radiusInput = 12;
  static const double radiusPill = 9999;

  static const BorderRadius brCard = BorderRadius.all(Radius.circular(20));
  static const BorderRadius brTile = BorderRadius.all(Radius.circular(12));
  static const BorderRadius brButton = BorderRadius.all(Radius.circular(14));
  static const BorderRadius brPill = BorderRadius.all(Radius.circular(9999));
}