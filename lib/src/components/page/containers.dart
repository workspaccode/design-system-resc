import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../theme/app_theme_extension.dart';
import '../../theme/theme_extensions.dart';
import 'glass_container.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppContainer
// ─────────────────────────────────────────────────────────────────────────────

/// Themed container with optional padding, radius, and border.
/// Replaces raw `Container` across the app for consistent styling.
class AppContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? color;
  final Color? borderColor;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final bool showBorder;
  final List<BoxShadow>? shadows;

  const AppContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 12,
    this.color,
    this.borderColor,
    this.width,
    this.height,
    this.onTap,
    this.showBorder = false,
    this.shadows,
  });

  factory AppContainer.neon({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? neonColor,
    double borderRadius = 12,
  }) =>
      _NeonContainer(
        padding: padding,
        margin: margin,
        borderRadius: borderRadius,
        neonColor: neonColor,
        child: child,
      );

  factory AppContainer.surface({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double borderRadius = 12,
    VoidCallback? onTap,
  }) =>
      AppContainer(
        padding: padding,
        margin: margin,
        borderRadius: borderRadius,
        showBorder: true,
        onTap: onTap,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    Widget box = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? colors.surface2,
        borderRadius: BorderRadius.circular(borderRadius),
        border: showBorder
            ? Border.all(color: borderColor ?? colors.border, width: 0.8)
            : null,
        boxShadow: shadows,
      ),
      child: child,
    );

    if (onTap != null) {
      box = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: box,
        ),
      );
    }

    return box;
  }
}

/// Thin horizontal rule using the `border` design token.
class AppDivider extends StatelessWidget {
  final double thickness;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  const AppDivider({
    super.key,
    this.thickness = 0.8,
    this.margin,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      height: thickness,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      color: color ?? colors.border,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppSection
// ─────────────────────────────────────────────────────────────────────────────

/// Glassmorphism panel — uses existing GlassContainer with a backdrop blur.
/// Great for overlapping data panels, overlays, and floating info cards.
class AppGlassPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double? width;
  final double? height;
  final double borderWidth;

  const AppGlassPanel({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 16,
    this.width,
    this.height,
    this.borderWidth = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      borderRadius: borderRadius,
      border: borderWidth,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    )
        .animate()
        .fadeIn(duration: 350.ms)
        .slideY(begin: 0.06, end: 0, duration: 350.ms, curve: Curves.easeOut);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppDivider
// ─────────────────────────────────────────────────────────────────────────────

/// Section with a title header and content slot.
/// Optional trailing action widget (e.g. "See all" button or refresh icon).
class AppSection extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final bool animate;

  const AppSection({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.padding,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    Widget content = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );

    if (animate) {
      content = content
          .animate()
          .fadeIn(duration: 300.ms)
          .slideY(begin: 0.04, end: 0, duration: 300.ms);
    }

    return content;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppSpacer
// ─────────────────────────────────────────────────────────────────────────────

/// Named spacing helpers for consistent layout rhythm.
///
/// Usage: `AppSpacer.md()` instead of `SizedBox(height: 16)`.
class AppSpacer extends StatelessWidget {
  final double size;
  final bool horizontal;

  const AppSpacer({super.key, required this.size, this.horizontal = false});

  /// 24px
  factory AppSpacer.lg({bool horizontal = false}) =>
      AppSpacer(size: 24, horizontal: horizontal);

  /// 16px
  factory AppSpacer.md({bool horizontal = false}) =>
      AppSpacer(size: 16, horizontal: horizontal);

  /// 8px
  factory AppSpacer.sm({bool horizontal = false}) =>
      AppSpacer(size: 8, horizontal: horizontal);

  /// 32px
  factory AppSpacer.xl({bool horizontal = false}) =>
      AppSpacer(size: 32, horizontal: horizontal);

  /// 4px
  factory AppSpacer.xs({bool horizontal = false}) =>
      AppSpacer(size: 4, horizontal: horizontal);

  /// 48px
  factory AppSpacer.xxl({bool horizontal = false}) =>
      AppSpacer(size: 48, horizontal: horizontal);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: horizontal ? size : 0,
      height: horizontal ? 0 : size,
    );
  }
}

/// Colored pill badge for device or system status display.
class AppStatusBadge extends StatelessWidget {
  final String label;
  final AppStatusBadgeType type;
  final Color? customColor;
  final IconData? icon;
  final bool animate;

  const AppStatusBadge({
    super.key,
    required this.label,
    this.type = AppStatusBadgeType.info,
    this.customColor,
    this.icon,
    this.animate = false,
  });

  factory AppStatusBadge.error(String label) => AppStatusBadge(
        label: label,
        type: AppStatusBadgeType.error,
        icon: Icons.error_outline,
      );

  factory AppStatusBadge.offline(String label) => AppStatusBadge(
        label: label,
        type: AppStatusBadgeType.offline,
        icon: Icons.circle,
      );

  factory AppStatusBadge.online(String label) => AppStatusBadge(
        label: label,
        type: AppStatusBadgeType.online,
        icon: Icons.circle,
        animate: true,
      );

  factory AppStatusBadge.warning(String label) => AppStatusBadge(
        label: label,
        type: AppStatusBadgeType.warning,
        icon: Icons.warning_amber_rounded,
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = _resolveColor(colors);

    Widget badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 10, color: color),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );

    if (animate) {
      badge = badge
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .fadeIn(duration: 600.ms)
          .then()
          .fadeOut(duration: 600.ms);
    }

    return badge;
  }

  Color _resolveColor(AppThemeExtension colors) {
    switch (type) {
      case AppStatusBadgeType.online:
        return colors.neonGreen;
      case AppStatusBadgeType.offline:
        return colors.textDim;
      case AppStatusBadgeType.warning:
        return colors.neonOrange;
      case AppStatusBadgeType.error:
        return colors.neonRed;
      case AppStatusBadgeType.info:
        return colors.neonBlue;
      case AppStatusBadgeType.custom:
        return customColor ?? colors.primary;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppStatusBadge
// ─────────────────────────────────────────────────────────────────────────────

enum AppStatusBadgeType { online, offline, warning, error, info, custom }

// ─────────────────────────────────────────────────────────────────────────────
// AppGlassPanel
// ─────────────────────────────────────────────────────────────────────────────

class _NeonContainer extends AppContainer {
  final Color? neonColor;

  const _NeonContainer({
    required super.child,
    super.padding,
    super.margin,
    super.borderRadius,
    this.neonColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final glow = neonColor ?? colors.primary;

    return AppContainer(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      borderColor: glow.withValues(alpha: 0.5),
      showBorder: true,
      shadows: [
        BoxShadow(
          color: glow.withValues(alpha: 0.15),
          blurRadius: 16,
          spreadRadius: 2,
        ),
      ],
      child: child,
    );
  }
}
