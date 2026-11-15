import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/core/design-system/resc-cloud/app_colors.dart';


class AppGradients {
  AppGradients._();

  static const LinearGradient greenGradient = LinearGradient(
    colors: [AppColors.gradientGreenStart, AppColors.gradientGreenEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [AppColors.gradientBackgroundStart, AppColors.gradientBackgroundEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
