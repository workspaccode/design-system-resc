import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart';


@immutable
class LiquidNavStyle {
  const LiquidNavStyle({
    this.backgroundColor,
    this.containerColor,
    this.liquidColor,
    this.activeIconColor,
    this.inactiveIconColor,
    this.activeLabelColor,
    this.inactiveLabelColor,
    this.border,
    this.borderSide,
    this.borderRadius,
    this.boxShadow,
    this.labelStyle,
    this.activeLabelStyle,
    this.showLabel = false,
    this.blurSigma,
  });

  final Color? backgroundColor;
  final Color? containerColor;
  final Color? liquidColor;
  final Color? activeIconColor;
  final Color? inactiveIconColor;
  final Color? activeLabelColor;
  final Color? inactiveLabelColor;
  final Border? border;
  final BorderSide? borderSide;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final TextStyle? labelStyle;
  final TextStyle? activeLabelStyle;
  final bool showLabel;
  final double? blurSigma;

  Border? resolveBorder() {
    if (border != null) return border;
    if (borderSide != null) return Border.fromBorderSide(borderSide!);
    return null;
  }

  LiquidNavStyle mergeWith(covariant LiquidNavStyle? other) {
    if (other == null) return this;
    return copyWith(
      backgroundColor: other.backgroundColor,
      containerColor: other.containerColor,
      liquidColor: other.liquidColor,
      activeIconColor: other.activeIconColor,
      inactiveIconColor: other.inactiveIconColor,
      activeLabelColor: other.activeLabelColor,
      inactiveLabelColor: other.inactiveLabelColor,
      border: other.border,
      borderSide: other.borderSide,
      borderRadius: other.borderRadius,
      boxShadow: other.boxShadow,
      labelStyle: other.labelStyle,
      activeLabelStyle: other.activeLabelStyle,
      showLabel: other.showLabel,
      blurSigma: other.blurSigma,
    );
  }

  LiquidNavStyle resolve(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeExtension>()!;
    final isLight = colors == AppThemeExtension.defaultLight;
    return LiquidNavStyle(
      backgroundColor: backgroundColor ?? const Color(0x00000000),
      containerColor: containerColor ??
          (isLight ? const Color(0xCCF7F7F8) : const Color(0xCC1C1C1E)),
      liquidColor: liquidColor ?? colors.primary,
      activeIconColor: activeIconColor ?? Colors.white,
      inactiveIconColor:
          inactiveIconColor ?? (isLight ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF)),
      activeLabelColor: activeLabelColor ?? colors.textPrimary,
      inactiveLabelColor: inactiveLabelColor ?? (isLight ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF)),
      borderSide:
          borderSide ?? BorderSide(color: (isLight ? Colors.black : Colors.white).withValues(alpha: 0.07), width: 0.8),
      borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(28)),
      boxShadow: boxShadow ?? const [
        BoxShadow(
          color: Color(0x0D000000),
          blurRadius: 18,
          offset: Offset(0, 6),
        ),
      ],
      labelStyle: labelStyle,
      activeLabelStyle: activeLabelStyle,
      showLabel: showLabel,
      blurSigma: blurSigma ?? 16,
    );
  }

  LiquidNavStyle copyWith({
    Color? backgroundColor,
    Color? containerColor,
    Color? liquidColor,
    Color? activeIconColor,
    Color? inactiveIconColor,
    Color? activeLabelColor,
    Color? inactiveLabelColor,
    Border? border,
    BorderSide? borderSide,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    TextStyle? labelStyle,
    TextStyle? activeLabelStyle,
    bool? showLabel,
    double? blurSigma,
  }) {
    return LiquidNavStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      containerColor: containerColor ?? this.containerColor,
      liquidColor: liquidColor ?? this.liquidColor,
      activeIconColor: activeIconColor ?? this.activeIconColor,
      inactiveIconColor: inactiveIconColor ?? this.inactiveIconColor,
      activeLabelColor: activeLabelColor ?? this.activeLabelColor,
      inactiveLabelColor: inactiveLabelColor ?? this.inactiveLabelColor,
      border: border ?? this.border,
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
      boxShadow: boxShadow ?? this.boxShadow,
      labelStyle: labelStyle ?? this.labelStyle,
      activeLabelStyle: activeLabelStyle ?? this.activeLabelStyle,
      showLabel: showLabel ?? this.showLabel,
      blurSigma: blurSigma ?? this.blurSigma,
    );
  }
}
