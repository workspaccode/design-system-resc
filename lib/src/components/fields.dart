import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/theme_extensions.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppSearchField
// ─────────────────────────────────────────────────────────────────────────────

/// Debounced search bar with animated focus state and a clear button.
/// Use for filtering device lists, history logs, or register search.
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
      style: TextStyle(color: colors.textPrimary, fontSize: 15),
      decoration: InputDecoration(
        hintText: widget.hint ?? 'Search…',
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

// ─────────────────────────────────────────────────────────────────────────────
// AppDropdownField
// ─────────────────────────────────────────────────────────────────────────────

/// Styled DropdownButtonFormField wrapper with label and validation.
/// Use for protocol selection, baud rate, or register type pickers.
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

// ─────────────────────────────────────────────────────────────────────────────
// AppSwitchField
// ─────────────────────────────────────────────────────────────────────────────

/// Labeled toggle row — enable/disable a single inverter parameter or feature.
class AppSwitchField extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;

  const AppSwitchField({
    super.key,
    required this.label,
    required this.value,
    this.subtitle,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(color: colors.textSecondary, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeThumbColor: colors.neonGreen,
            activeTrackColor: colors.neonGreen.withValues(alpha: 0.35),
            inactiveThumbColor: colors.textSecondary,
            inactiveTrackColor: colors.border.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppSliderField
// ─────────────────────────────────────────────────────────────────────────────

/// Labeled slider with min/max labels and a live value display.
/// Use for threshold configurations, brightness, or volume settings.
class AppSliderField extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final String? unit;
  final ValueChanged<double>? onChanged;
  final bool enabled;

  const AppSliderField({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    this.divisions,
    this.unit,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final displayValue =
        value == value.truncateToDouble() ? value.toInt().toString() : value.toStringAsFixed(1);

    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  unit != null ? '$displayValue $unit' : displayValue,
                  style: TextStyle(
                    color: colors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: colors.primary,
              inactiveTrackColor: colors.border,
              thumbColor: colors.primary,
              overlayColor: colors.primary.withValues(alpha: 0.15),
              trackHeight: 3,
            ),
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              divisions: divisions,
              onChanged: enabled ? onChanged : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  unit != null ? '$min $unit' : '$min',
                  style: TextStyle(color: colors.textDim, fontSize: 11),
                ),
                Text(
                  unit != null ? '$max $unit' : '$max',
                  style: TextStyle(color: colors.textDim, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppCheckboxField
// ─────────────────────────────────────────────────────────────────────────────

/// Labeled checkbox — for multi-select settings and permission confirmations.
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

// ─────────────────────────────────────────────────────────────────────────────
// AppSegmentedField
// ─────────────────────────────────────────────────────────────────────────────

/// Segmented control for mutually exclusive options.
/// e.g. Day / Week / Month chart selector, or AC / DC mode selector.
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

// ─────────────────────────────────────────────────────────────────────────────
// Field Size
// ─────────────────────────────────────────────────────────────────────────────

enum AppFieldSize { sm, md, lg }

// ─────────────────────────────────────────────────────────────────────────────
// AppValidators
// ─────────────────────────────────────────────────────────────────────────────

class AppValidators {
  AppValidators._();

  static String? required(String? v, [String msg = 'This field is required']) {
    if (v == null || v.trim().isEmpty) return msg;
    return null;
  }

  static String? email(String? v, [String msg = 'Enter a valid email']) {
    if (v == null || v.trim().isEmpty) return msg;
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : msg;
  }

  static String? Function(String?)? minLength(int min, [String? msg]) {
    return (v) {
      if (v == null || v.trim().length < min) {
        return msg ?? 'At least $min characters';
      }
      return null;
    };
  }

  static String? Function(String?)? match(
      String other, [String msg = 'Passwords do not match']) {
    return (v) => v == other ? null : msg;
  }

  static String? phone(String? v,
      [String msg = 'Enter a valid phone number']) {
    if (v == null || v.trim().isEmpty) return msg;
    final ok = RegExp(r'^\+?[\d\s\-()]{7,15}$').hasMatch(v.trim());
    return ok ? null : msg;
  }

  static String? Function(String?)? compose(
    List<String? Function(String?)?> validators,
  ) {
    return (v) {
      for (final fn in validators) {
        if (fn == null) continue;
        final r = fn(v);
        if (r != null) return r;
      }
      return null;
    };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppTextField
// ─────────────────────────────────────────────────────────────────────────────

/// Themed text input with size variants, password toggle, and validation.
class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? initialValue;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusColor;
  final Color? labelColor;
  final Color? textColor;
  final Color? errorColor;
  final AppFieldSize size;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.initialValue,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.keyboardType,
    this.textInputAction,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.contentPadding,
    this.borderRadius = 12,
    this.fillColor,
    this.borderColor,
    this.focusColor,
    this.labelColor,
    this.textColor,
    this.errorColor,
    this.size = AppFieldSize.md,
  });

  /// Email field with built-in email icon and email validator.
  factory AppTextField.email({
    Key? key,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    bool autofocus = false,
  }) =>
      AppTextField(
        key: key,
        controller: controller,
        label: 'Email',
        hint: 'Enter your email',
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        prefixIcon: const Icon(Icons.email_outlined),
        validator: validator ?? AppValidators.email,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        enabled: enabled,
        autofocus: autofocus,
      );

  /// Password field with built-in lock icon and visibility toggle.
  factory AppTextField.password({
    Key? key,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    bool autofocus = false,
    String? label,
  }) =>
      _AppPasswordField(
        key: key,
        controller: controller,
        label: label ?? 'Password',
        validator: validator,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        enabled: enabled,
        autofocus: autofocus,
      );

  /// Phone / mobile number field with phone icon and phone validator.
  factory AppTextField.phone({
    Key? key,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    String? label,
  }) =>
      AppTextField(
        key: key,
        controller: controller,
        label: label ?? 'Phone',
        hint: 'Enter your phone number',
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        prefixIcon: const Icon(Icons.phone_outlined),
        validator: validator ?? AppValidators.phone,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        enabled: enabled,
      );

  /// Username field with person icon, no spaces, lowercase.
  factory AppTextField.username({
    Key? key,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    String? label,
  }) =>
      AppTextField(
        key: key,
        controller: controller,
        label: label ?? 'Username',
        hint: 'Enter your username',
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        prefixIcon: const Icon(Icons.person_outlined),
        validator: validator ?? AppValidators.minLength(3),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        enabled: enabled,
      );

  /// Full name field with user icon.
  factory AppTextField.name({
    Key? key,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    String? label,
  }) =>
      AppTextField(
        key: key,
        controller: controller,
        label: label ?? 'Full Name',
        hint: 'Enter your full name',
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        prefixIcon: const Icon(Icons.badge_outlined),
        validator: validator ?? AppValidators.required,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        enabled: enabled,
      );

  /// Multiline text area — for notes, descriptions, comments.
  factory AppTextField.multiline({
    Key? key,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    String? label,
    String? hint,
    int? maxLines,
    int? minLines,
  }) =>
      AppTextField(
        key: key,
        controller: controller,
        label: label ?? 'Notes',
        hint: hint ?? 'Enter your text',
        maxLines: maxLines ?? 4,
        minLines: minLines ?? 3,
        textInputAction: TextInputAction.newline,
        onChanged: onChanged,
        validator: validator,
        enabled: enabled,
      );

  /// Compact size field — for codes, OTPs, short inputs.
  factory AppTextField.small({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? hint,
    int? maxLength,
    TextInputType? keyboardType,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
  }) =>
      AppTextField(
        key: key,
        controller: controller,
        label: label,
        hint: hint,
        maxLength: maxLength,
        keyboardType: keyboardType,
        size: AppFieldSize.sm,
        onChanged: onChanged,
        validator: validator,
      );

  /// Full custom control — override fill, border, focus, text, label colors
  /// plus borderRadius, size, contentPadding, prefix, suffix, readonly, maxLength.
  factory AppTextField.custom({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? hint,
    Color? fillColor,
    Color? borderColor,
    Color? focusColor,
    Color? textColor,
    Color? labelColor,
    double borderRadius = 12,
    AppFieldSize size = AppFieldSize.md,
    EdgeInsetsGeometry? contentPadding,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Widget? prefix,
    Widget? suffix,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    bool readOnly = false,
    int? maxLength,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    bool autofocus = false,
  }) =>
      AppTextField(
        key: key,
        controller: controller,
        label: label,
        hint: hint,
        fillColor: fillColor,
        borderColor: borderColor,
        focusColor: focusColor,
        textColor: textColor,
        labelColor: labelColor,
        borderRadius: borderRadius,
        size: size,
        contentPadding: contentPadding,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefix: prefix,
        suffix: suffix,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        validator: validator,
        enabled: enabled,
        readOnly: readOnly,
        maxLength: maxLength,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        autofocus: autofocus,
      );

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscured = false;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  EdgeInsetsGeometry _resolvePadding() {
    if (widget.contentPadding != null) return widget.contentPadding!;
    switch (widget.size) {
      case AppFieldSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case AppFieldSize.md:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 14);
      case AppFieldSize.lg:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 18);
    }
  }

  double _resolveFontSize() {
    switch (widget.size) {
      case AppFieldSize.sm:
        return 13;
      case AppFieldSize.md:
        return 15;
      case AppFieldSize.lg:
        return 17;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final effectiveFill = widget.fillColor ??
        (widget.enabled
            ? colors.surface2
            : colors.surface2.withValues(alpha: 0.5));
    final effectiveBorder = widget.borderColor ?? colors.border;
    final effectiveFocus = widget.focusColor ?? colors.primary;
    final effectiveError = widget.errorColor ?? colors.neonRed;
    final effectiveText = widget.textColor ?? colors.textPrimary;
    final effectiveLabel = widget.labelColor ?? colors.textPrimary;
    final fontSize = _resolveFontSize();

    Widget field = TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      obscureText: _obscured,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLength: widget.maxLength,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      cursorColor: effectiveFocus,
      style: TextStyle(
        color: widget.enabled ? effectiveText : colors.textDim,
        fontSize: fontSize,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        labelStyle: TextStyle(color: effectiveLabel, fontSize: fontSize - 1),
        hintStyle: TextStyle(color: colors.textDim, fontSize: fontSize - 1),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: colors.textSecondary,
                  size: 20,
                ),
                onPressed: () => setState(() => _obscured = !_obscured),
              )
            : widget.suffixIcon,
        prefix: widget.prefix,
        suffix: widget.suffix,
        filled: true,
        fillColor: effectiveFill,
        contentPadding: _resolvePadding(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: effectiveBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: effectiveBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: effectiveFocus, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: effectiveError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: effectiveError, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:
              BorderSide(color: effectiveBorder.withValues(alpha: 0.4)),
        ),
      ),
    );

    return field
        .animate()
        .fadeIn(duration: 250.ms)
        .slideY(begin: -0.03, end: 0, duration: 250.ms);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _AppPasswordField
// ─────────────────────────────────────────────────────────────────────────────

class _AppPasswordField extends AppTextField {
  _AppPasswordField({
    super.key,
    super.controller,
    required super.label,
    super.validator,
    super.onChanged,
    super.onSubmitted,
    super.enabled,
    super.autofocus,
  }) : super(
          obscureText: true,
          hint: 'Enter your password',
          prefixIcon: const Icon(Icons.lock_outlined),
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
        );
}
