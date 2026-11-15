import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';

import '../../theme/theme_extensions.dart';

class AppSwitchField extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final Widget? leading;
  final bool isDestructive;
  final bool useCupertino;
  final Widget? suffix;
  final Color? activeThumbColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;

  const AppSwitchField({
    super.key,
    required this.label,
    required this.value,
    this.subtitle,
    this.onChanged,
    this.enabled = true,
    this.leading,
    this.isDestructive = false,
    this.useCupertino = false,
    this.suffix,
    this.activeThumbColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
  });

  factory AppSwitchField.card({
    Key? key,
    required String label,
    required bool value,
    String? subtitle,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Widget? leading,
    bool isDestructive = false,
    Color? activeThumbColor,
    Color? activeTrackColor,
    Color? inactiveThumbColor,
    Color? inactiveTrackColor,
  }) =>
      AppSwitchField(
        key: key,
        label: label,
        value: value,
        subtitle: subtitle,
        onChanged: onChanged,
        enabled: enabled,
        leading: leading,
        isDestructive: isDestructive,
      );

  factory AppSwitchField.compact({
    Key? key,
    required String label,
    required bool value,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    bool useCupertino = false,
  }) =>
      AppSwitchField(
        key: key,
        label: label,
        value: value,
        onChanged: onChanged,
        enabled: enabled,
        useCupertino: useCupertino,
      );

  factory AppSwitchField.danger({
    Key? key,
    required String label,
    required bool value,
    String? subtitle,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Color? activeThumbColor,
    Color? activeTrackColor,
    Color? inactiveThumbColor,
    Color? inactiveTrackColor,
  }) =>
      AppSwitchField(
        key: key,
        label: label,
        value: value,
        subtitle: subtitle,
        onChanged: onChanged,
        enabled: enabled,
        isDestructive: true,
      );

  factory AppSwitchField.platformAdaptive({
    Key? key,
    required String label,
    required bool value,
    String? subtitle,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Widget? leading,
  }) =>
      AppSwitchField(
        key: key,
        label: label,
        value: value,
        subtitle: subtitle,
        onChanged: onChanged,
        enabled: enabled,
        leading: leading,
        useCupertino: true,
      );

  factory AppSwitchField.settings({
    Key? key,
    required String label,
    required bool value,
    required IconData icon,
    String? subtitle,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    bool isDestructive = false,
  }) =>
      AppSwitchField(
        key: key,
        label: label,
        value: value,
        subtitle: subtitle,
        onChanged: onChanged,
        enabled: enabled,
        leading: Icon(icon, size: 22),
        isDestructive: isDestructive,
      );

  factory AppSwitchField.withAvatar({
    Key? key,
    required String label,
    required bool value,
    required Widget avatar,
    String? subtitle,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Color? activeThumbColor,
    Color? activeTrackColor,
    Color? inactiveThumbColor,
    Color? inactiveTrackColor,
  }) =>
      AppSwitchField(
        key: key,
        label: label,
        value: value,
        subtitle: subtitle,
        onChanged: onChanged,
        enabled: enabled,
        leading: SizedBox(width: 36, height: 36, child: avatar),
      );

  factory AppSwitchField.withIcon({
    Key? key,
    required String label,
    required bool value,
    required IconData icon,
    String? subtitle,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Color? activeThumbColor,
    Color? activeTrackColor,
    Color? inactiveThumbColor,
    Color? inactiveTrackColor,
  }) =>
      AppSwitchField(
        key: key,
        label: label,
        value: value,
        subtitle: subtitle,
        onChanged: onChanged,
        enabled: enabled,
        leading: Icon(icon, size: 22),
      );

  factory AppSwitchField.withSuffix({
    Key? key,
    required String label,
    required bool value,
    required Widget suffix,
    String? subtitle,
    ValueChanged<bool>? onChanged,
    bool enabled = true,
    Widget? leading,
  }) =>
      AppSwitchField(
        key: key,
        label: label,
        value: value,
        subtitle: subtitle,
        onChanged: onChanged,
        enabled: enabled,
        leading: leading,
        suffix: suffix,
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accentColor = isDestructive ? colors.neonRed : colors.neonGreen;

    final switchWidget = useCupertino
        ? CupertinoSwitch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeTrackColor: activeTrackColor ?? accentColor,
            //activeTrackColor: activeThumbColor ?? accentColor,
          )
        : Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeThumbColor: activeThumbColor ?? accentColor,
            activeTrackColor:
                activeTrackColor ?? accentColor.withValues(alpha: 0.35),
            inactiveThumbColor: inactiveThumbColor ?? colors.textSecondary,
            inactiveTrackColor:
                inactiveTrackColor ?? colors.border.withValues(alpha: 0.5),
          );

    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
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
                    color: isDestructive ? colors.neonRed : colors.textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: isDestructive
                          ? colors.neonRed.withValues(alpha: 0.7)
                          : colors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (!useCupertino && isDestructive)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(
                Icons.warning_amber_rounded,
                size: 18,
                color: colors.neonRed.withValues(alpha: 0.6),
              ),
            ),
          switchWidget,
          if (suffix != null) ...[
            const SizedBox(width: 8),
            suffix!,
          ],
        ],
      ),
    );
  }
}
