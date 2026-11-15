import 'package:material_ui/material_ui.dart';

import '../../theme/theme_extensions.dart';

class AppCheckboxField extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final bool enabled;
  final bool tristate;

  const AppCheckboxField({
    super.key,
    required this.label,
    required this.value,
    this.subtitle,
    this.onChanged,
    this.enabled = true,
    this.tristate = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: InkWell(
        onTap: enabled && onChanged != null
            ? () => onChanged!(!value)
            : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: value,
                tristate: tristate,
                onChanged: enabled ? onChanged : null,
                activeColor: colors.primary,
                checkColor: Colors.white,
                side: BorderSide(color: colors.border, width: 1.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: TextStyle(
                            color: colors.textSecondary, fontSize: 12),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
