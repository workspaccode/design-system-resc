import 'package:material_ui/material_ui.dart';

import 'app_theme_extension.dart';

extension AppBrightnessX on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;
  bool get isDark => brightness == Brightness.dark;
  bool get isLight => brightness == Brightness.light;
}

extension AppColorsX on BuildContext {
  AppThemeExtension get colors {
    final ext = Theme.of(this).extension<AppThemeExtension>();
    if (ext != null) return ext;
    final isDark = Theme.of(this).brightness == Brightness.dark;
    return isDark
        ? AppThemeExtension.defaultDark
        : AppThemeExtension.defaultLight;
  }
}

extension ScaffoldBgX on BuildContext {
  Color get AppscaffoldBg => colors.scaffoldBg;
}
