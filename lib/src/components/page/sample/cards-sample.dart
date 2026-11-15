import 'dart:ui' show ImageFilter;
import 'package:material_ui/material_ui.dart';

/// Design system card component
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.elevation,
    this.margin,
    this.padding,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double? elevation;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 2,
      margin: margin ?? const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}

/// Liquid glass card with frosted blur effect — no external packages
class AppLiquidGlassCard extends StatelessWidget {
  const AppLiquidGlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.borderRadius = 16,
    this.sigma = 10,
    this.tint = Colors.white24,
    this.borderColor = Colors.white12,
    this.gradientColors,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double sigma;
  final Color tint;
  final Color borderColor;
  final List<Color>? gradientColors;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveGradient = gradientColors ??
        (isDark
            ? [Colors.white.withValues(alpha: 0.08), Colors.white.withValues(alpha: 0.02)]
            : [Colors.white.withValues(alpha: 0.6), Colors.white.withValues(alpha: 0.15)]);

    final effectiveTint = isDark ? Colors.white10 : Colors.white24;
    final effectiveBorder = isDark ? Colors.white12 : Colors.white30;

    return Container(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(borderRadius),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: effectiveTint,
                  gradient: LinearGradient(
                    colors: effectiveGradient,
                    begin: gradientBegin,
                    end: gradientEnd,
                  ),
                  border: Border.all(
                    color: effectiveBorder,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: padding ?? const EdgeInsets.all(20),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
