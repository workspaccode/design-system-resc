import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../theme/theme_extensions.dart';

class AppToggleButton extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final IconData? icon;
  final bool isLoading;
  final Color? activeColor;
  final Color? inactiveColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const AppToggleButton({
    super.key,
    required this.label,
    required this.value,
    this.subtitle,
    this.onChanged,
    this.icon,
    this.isLoading = false,
    this.activeColor,
    this.inactiveColor,
    this.borderRadius = 12,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final effectiveActive = activeColor ?? colors.neonGreen;
    final effectiveInactive = inactiveColor ?? colors.textSecondary;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface2,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: value
              ? effectiveActive.withValues(alpha: 0.4)
              : colors.border,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading || onChanged == null
              ? null
              : () => onChanged!(!value),
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding ??
                const EdgeInsetsDirectional.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 20,
                    color: value ? effectiveActive : effectiveInactive,
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                isLoading
                    ? SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: effectiveActive,
                        ),
                      )
                    : Switch(
                        value: value,
                        onChanged: onChanged,
                        activeThumbColor: effectiveActive,
                        activeTrackColor:
                            effectiveActive.withValues(alpha: 0.35),
                        inactiveThumbColor: effectiveInactive,
                        inactiveTrackColor:
                            colors.border.withValues(alpha: 0.5),
                      ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 220.ms)
        .slideX(begin: 0.04, end: 0, duration: 220.ms);
  }
}
