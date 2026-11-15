import 'package:material_ui/material_ui.dart';

import '../../theme/theme_extensions.dart';

class AppDropdownField<T> extends StatelessWidget {
  final String? label;
  final String? hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final bool enabled;
  final double borderRadius;
  final IconData? prefixIcon;

  const AppDropdownField({
    super.key,
    this.label,
    this.hint,
    this.value,
    required this.items,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.borderRadius = 12,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        DropdownButtonFormField<T>(
          // ignore: deprecated_member_use
          value: value,
          items: items,
          onChanged: enabled ? onChanged : null,
          validator: validator,
          dropdownColor: colors.surface2,
          style: TextStyle(color: colors.textPrimary, fontSize: 15),
          icon: Icon(Icons.keyboard_arrow_down, color: colors.textSecondary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: colors.textDim, fontSize: 14),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: colors.textSecondary, size: 20)
                : null,
            filled: true,
            fillColor: enabled
                ? colors.surface2
                : colors.surface2.withValues(alpha: 0.5),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: colors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: colors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: colors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: colors.neonRed),
            ),
          ),
        ),
      ],
    );
  }
}
