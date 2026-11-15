import 'package:material_ui/material_ui.dart';

import '../../theme/theme_extensions.dart';

class AppSegmentedField<T extends Object> extends StatelessWidget {
  final String? label;
  final Map<T, Widget> segments;
  final T selected;
  final ValueChanged<T>? onChanged;

  const AppSegmentedField({
    super.key,
    required this.segments,
    required this.selected,
    this.label,
    this.onChanged,
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
        SegmentedButton<T>(
          segments: segments.entries
              .map((e) => ButtonSegment<T>(value: e.key, label: e.value))
              .toList(),
          selected: {selected},
          onSelectionChanged: onChanged != null
              ? (s) => onChanged!(s.first)
              : null,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return colors.primary.withValues(alpha: 0.18);
              }
              return colors.surface2;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return colors.primary;
              }
              return colors.textSecondary;
            }),
            side: WidgetStatePropertyAll(
                BorderSide(color: colors.border)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
