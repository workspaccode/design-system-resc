import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../theme/theme_extensions.dart';
import 'text_direction_extension.dart';

class AppSearchField extends StatefulWidget {
  final String? hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final int debounceDurationMs;
  final bool autofocus;

  const AppSearchField({
    super.key,
    this.hint,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.controller,
    this.debounceDurationMs = 400,
    this.autofocus = false,
  });

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late final TextEditingController _ctrl;
  Timer? _debounce;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _ctrl = widget.controller ?? TextEditingController();
    _ctrl.addListener(_onTextChange);
  }

  void _onTextChange() {
    final hasText = _ctrl.text.isNotEmpty;
    if (hasText != _hasText) setState(() => _hasText = hasText);

    if (widget.onChanged != null) {
      _debounce?.cancel();
      _debounce = Timer(
        Duration(milliseconds: widget.debounceDurationMs),
        () => widget.onChanged!(_ctrl.text),
      );
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    if (widget.controller == null) _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return TextField(
      controller: _ctrl,
      autofocus: widget.autofocus,
      onSubmitted: widget.onSubmitted,
      textInputAction: TextInputAction.search,
      textDirection: _ctrl.estimateDirection(),
      style: TextStyle(color: colors.textPrimary, fontSize: 15),
      decoration: InputDecoration(
        hintText: widget.hint ?? 'Search\u2026',
        hintStyle: TextStyle(color: colors.textDim, fontSize: 14),
        prefixIcon: Icon(Icons.search, color: colors.textSecondary, size: 20),
        suffixIcon: _hasText
            ? IconButton(
                icon: Icon(Icons.close, color: colors.textSecondary, size: 18),
                onPressed: () {
                  _ctrl.clear();
                  widget.onClear?.call();
                  widget.onChanged?.call('');
                },
              )
            : null,
        filled: true,
        fillColor: colors.surface2,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
      ),
    ).animate().fadeIn(duration: 250.ms).slideY(begin: -0.05, end: 0);
  }
}
