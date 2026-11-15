import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../theme/app_theme_extension.dart';
import '../../theme/theme_extensions.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppLinearProgress
// ─────────────────────────────────────────────────────────────────────────────

/// Notification dot / count badge overlaid on any child widget.
/// Pass `count: null` for a plain dot indicator.
class AppBadge extends StatelessWidget {
  final Widget child;
  final int? count;
  final bool visible;
  final Color? color;

  const AppBadge({
    super.key,
    required this.child,
    this.count,
    this.visible = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final badgeColor = color ?? colors.neonRed;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (visible)
          PositionedDirectional(
            top: -4,
            end: -4,
            child: Container(
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              padding: count != null
                  ? const EdgeInsets.symmetric(horizontal: 5, vertical: 1)
                  : const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: badgeColor,
                shape: count != null ? BoxShape.rectangle : BoxShape.circle,
                borderRadius: count != null ? BorderRadius.circular(8) : null,
              ),
              child: count != null
                  ? Text(
                      count! > 99 ? '99+' : '$count',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ).animate().scale(
                  duration: 200.ms,
                  curve: Curves.elasticOut,
                  begin: const Offset(0, 0),
                  end: const Offset(1, 1),
                ),
          ),
      ],
    );
  }
}

/// Themed circular progress indicator.
/// Determinate variant shows value overlay; indeterminate for loading.
class AppCircularProgress extends StatelessWidget {
  final double? value; // null = indeterminate
  final String? label;
  final Color? color;
  final double size;
  final double strokeWidth;

  const AppCircularProgress({
    super.key,
    this.value,
    this.label,
    this.color,
    this.size = 48,
    this.strokeWidth = 4,
  });

  factory AppCircularProgress.indeterminate({
    Color? color,
    double size = 48,
  }) =>
      AppCircularProgress(value: null, color: color, size: size);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final effectiveColor = color ?? colors.primary;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value,
            color: effectiveColor,
            backgroundColor: colors.border.withValues(alpha: 0.3),
            strokeWidth: strokeWidth,
            strokeCap: StrokeCap.round,
          ),
          if (label != null)
            Text(
              label!,
              style: TextStyle(
                color: effectiveColor,
                fontSize: size * 0.22,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppCircularProgress
// ─────────────────────────────────────────────────────────────────────────────

/// Themed horizontal progress bar using neon color tokens.
/// Used for battery charge level, solar output percentage, load %.
class AppLinearProgress extends StatelessWidget {
  final double value; // 0.0 – 1.0
  final String? label;
  final String? trailingLabel;
  final Color? color;
  final double height;
  final bool animate;

  const AppLinearProgress({
    super.key,
    required this.value,
    this.label,
    this.trailingLabel,
    this.color,
    this.height = 8,
    this.animate = true,
  });

  factory AppLinearProgress.battery({
    required double value,
    String? label,
  }) =>
      _BatteryProgress(value: value, label: label);

  factory AppLinearProgress.solar({
    required double value,
    String? label,
  }) =>
      AppLinearProgress(
        value: value,
        label: label,
        color: null, // uses neonGreen from build
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final clampedValue = value.clamp(0.0, 1.0);

    // Auto color based on value if no custom color
    final effectiveColor = color ??
        (clampedValue < 0.2
            ? colors.neonRed
            : clampedValue < 0.5
                ? colors.neonOrange
                : colors.neonGreen);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null || trailingLabel != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (trailingLabel != null)
                Text(
                  trailingLabel!,
                  style: TextStyle(
                    color: effectiveColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: SizedBox(
            width: double.infinity,
            child: Stack(
            children: [
              // Track
              Container(
                height: height,
                color: colors.border.withValues(alpha: 0.5),
              ),
              // Fill
              FractionallySizedBox(
                widthFactor: clampedValue,
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        effectiveColor.withValues(alpha: 0.7),
                        effectiveColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(height / 2),
                    boxShadow: [
                      BoxShadow(
                        color: effectiveColor.withValues(alpha: 0.4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ).animate(target: animate ? 1 : 0).custom(
                    duration: 600.ms,
                    curve: Curves.easeOut,
                    // ignore: unnecessary_non_null_assertion
                    builder: (context, progress, child) => child!,
                  ),
            ],
          ),
        ),
      ),
      ],
    );
  }
}

/// Animated pulsing dot — indicates live BLE streaming data or active monitoring.
/// Color maps to neon tokens: green = live, red = fault, orange = warning.
class AppPulseDot extends StatelessWidget {
  final Color? color;
  final double size;
  final bool active;

  const AppPulseDot({
    super.key,
    this.color,
    this.size = 10,
    this.active = true,
  });

  factory AppPulseDot.fault({double size = 10}) => _FaultPulseDot(size: size);

  factory AppPulseDot.live({double size = 10}) => AppPulseDot(size: size);

  factory AppPulseDot.warning({double size = 10}) =>
      _WarningPulseDot(size: size);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dotColor = color ?? colors.neonGreen;

    if (!active) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: colors.textDim,
          shape: BoxShape.circle,
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // Pulsing outer ring
        Container(
          width: size * 2.2,
          height: size * 2.2,
          decoration: BoxDecoration(
            color: dotColor.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
        )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .scaleXY(
              begin: 0.5,
              end: 1.0,
              duration: 1.seconds,
              curve: Curves.easeOut,
            )
            .fadeIn(duration: 800.ms),
        // Solid inner dot
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: dotColor.withValues(alpha: 0.6),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Small colored chip for live inverter / BLE status display.
/// Color variants map directly to neon tokens.
class AppStatusChip extends StatelessWidget {
  final String label;
  final AppStatusChipColor chipColor;
  final IconData? icon;
  final bool compact;

  const AppStatusChip({
    super.key,
    required this.label,
    this.chipColor = AppStatusChipColor.green,
    this.icon,
    this.compact = false,
  });

  factory AppStatusChip.connected(String label) => AppStatusChip(
        label: label,
        chipColor: AppStatusChipColor.green,
        icon: Icons.bluetooth_connected,
      );

  factory AppStatusChip.disconnected(String label) => AppStatusChip(
        label: label,
        chipColor: AppStatusChipColor.dim,
        icon: Icons.bluetooth_disabled,
      );

  factory AppStatusChip.fault(String label) => AppStatusChip(
        label: label,
        chipColor: AppStatusChipColor.red,
        icon: Icons.error_outline,
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = _resolveColor(colors);
    final hPad = compact ? 8.0 : 10.0;
    final vPad = compact ? 3.0 : 5.0;
    final fontSize = compact ? 11.0 : 12.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.35), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: compact ? 11 : 13, color: color),
            SizedBox(width: compact ? 4 : 5),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Color _resolveColor(AppThemeExtension colors) {
    switch (chipColor) {
      case AppStatusChipColor.green:
        return colors.neonGreen;
      case AppStatusChipColor.red:
        return colors.neonRed;
      case AppStatusChipColor.orange:
        return colors.neonOrange;
      case AppStatusChipColor.blue:
        return colors.neonBlue;
      case AppStatusChipColor.purple:
        return colors.neonPurple;
      case AppStatusChipColor.dim:
        return colors.textDim;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppBadge
// ─────────────────────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────────────────────
// AppStatusChip
// ─────────────────────────────────────────────────────────────────────────────

enum AppStatusChipColor { green, red, orange, blue, purple, dim }

// ─────────────────────────────────────────────────────────────────────────────
// AppPulseDot
// ─────────────────────────────────────────────────────────────────────────────

/// Labeled value row: "Voltage · 220 V" with color-coded neon value.
/// Perfect for register readout rows, status dashboards, and parameter cards.
class AppValueIndicator extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final Color? valueColor;
  final IconData? icon;
  final bool highlight;
  final Widget? trailing;

  const AppValueIndicator({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    this.valueColor,
    this.icon,
    this.highlight = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final effectiveValueColor = valueColor ?? colors.neonCyan;

    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: highlight
            ? effectiveValueColor.withValues(alpha: 0.07)
            : colors.surface2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: highlight
              ? effectiveValueColor.withValues(alpha: 0.3)
              : colors.border,
          width: highlight ? 1 : 0.6,
        ),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: effectiveValueColor),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 13,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: effectiveValueColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 3),
                Text(
                  unit!,
                  style: TextStyle(
                    color: colors.textDim,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
          if (trailing != null) ...[const SizedBox(width: 8), trailing!],
        ],
      ),
    );
  }
}

class _BatteryProgress extends AppLinearProgress {
  const _BatteryProgress({required super.value, super.label});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final clampedValue = value.clamp(0.0, 1.0);
    final effectiveColor = clampedValue < 0.2
        ? colors.neonRed
        : clampedValue < 0.4
            ? colors.neonOrange
            : colors.neonGreen;

    return AppLinearProgress(
      value: value,
      label: label,
      trailingLabel: '${(clampedValue * 100).toInt()}%',
      color: effectiveColor,
      height: 10,
    );
  }
}

class _FaultPulseDot extends AppPulseDot {
  const _FaultPulseDot({super.size});

  @override
  Widget build(BuildContext context) =>
      AppPulseDot(color: context.colors.neonRed, size: size);
}

// ─────────────────────────────────────────────────────────────────────────────
// AppValueIndicator
// ─────────────────────────────────────────────────────────────────────────────

class _WarningPulseDot extends AppPulseDot {
  const _WarningPulseDot({super.size});

  @override
  Widget build(BuildContext context) =>
      AppPulseDot(color: context.colors.neonOrange, size: size);
}
