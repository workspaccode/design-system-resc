import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../theme/theme_extensions.dart';
import 'text_direction_extension.dart';

enum AppFieldSize { sm, md, lg }

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
  final AppTextFieldXType type;
  final bool scribbleEnabled;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final FormFieldSetter<String>? onSaved;
  final Color? colorContainer;
  final List<BoxShadow>? boxShadow;

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
    this.type = AppTextFieldXType.text,
    this.scribbleEnabled = false,
    this.scrollController,
    this.scrollPhysics,
    this.onSaved,
    this.colorContainer,
    this.boxShadow,
  });

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
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    void Function(String)? onSubmitted,
    bool obscureText = false,
    FormFieldSetter<String>? onSaved,
    ScrollController? scrollController,
    ScrollPhysics? scrollPhysics,
    Color? colorContainer,
    List<BoxShadow>? boxShadow,
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
        onChanged: onChanged,
        validator: validator,
        enabled: enabled,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        obscureText: obscureText,
        scribbleEnabled: false,
        scrollController: scrollController,
        scrollPhysics: scrollPhysics,
        onSaved: onSaved,
        colorContainer: colorContainer,
        boxShadow: boxShadow,
      );

  factory AppTextField.email({
    Key? key,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    bool autofocus = false,
    String? hint,
    String? label,
  }) =>
      AppTextField(
        key: key,
        controller: controller,
        label: label ?? 'Email',
        hint: hint ?? 'Enter your email',
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        prefixIcon: const Icon(Icons.email_outlined),
        validator: validator ?? AppValidators.email,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        enabled: enabled,
        autofocus: autofocus,
        scribbleEnabled: false,
        scrollController: null,
        scrollPhysics: null,
      );

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
        scribbleEnabled: false,
        scrollController: null,
        scrollPhysics: null,
        onSaved: null,
      );

  factory AppTextField.name({
    Key? key,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    String? label,
    String? hint,
  }) =>
      AppTextField(
        key: key,
        controller: controller,
        label: label ?? 'Full Name',
        hint: hint ?? 'Enter your full name',
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        prefixIcon: const Icon(Icons.badge_outlined),
        validator: validator ?? AppValidators.required,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        enabled: enabled,
        scribbleEnabled: false,
        scrollController: null,
        scrollPhysics: null,
        onSaved: null,
      );

  factory AppTextField.password({
    Key? key,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    bool autofocus = false,
    String? label,
    String? hint,
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

  factory AppTextField.phone({
    Key? key,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    String? label,
    String? hint,
  }) =>
      AppTextField(
        key: key,
        controller: controller,
        label: label ?? 'Phone',
        hint: hint ?? 'Enter your phone number',
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        prefixIcon: const Icon(Icons.phone_outlined),
        validator: validator ?? AppValidators.phone,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        enabled: enabled,
        type: AppTextFieldXType.phone,
        scribbleEnabled: false,
        scrollController: null,
        scrollPhysics: null,
        onSaved: null,
      );

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

  factory AppTextField.username({
    Key? key,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    String? label,
    String? hint,
  }) =>
      AppTextField(
        key: key,
        controller: controller,
        label: label ?? 'Username',
        hint: hint ?? 'Enter your username',
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        prefixIcon: const Icon(Icons.person_outlined),
        validator: validator ?? AppValidators.minLength(3),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        enabled: enabled,
        scribbleEnabled: false,
        scrollController: null,
        scrollPhysics: null,
        onSaved: null,
      );

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

enum AppTextFieldXType { text, number, phone, email, url, togglebtn }

class AppValidators {
  AppValidators._();

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

  static String? email(String? v, [String msg = 'Enter a valid email']) {
    if (v == null || v.trim().isEmpty) return msg;
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : msg;
  }

  static String? Function(String?)? match(String other,
      [String msg = 'Passwords do not match']) {
    return (v) => v == other ? null : msg;
  }

  static String? Function(String?)? minLength(int min, [String? msg]) {
    return (v) {
      if (v == null || v.trim().length < min) {
        return msg ?? 'At least $min characters';
      }
      return null;
    };
  }

  static String? phone(String? v, [String msg = 'Enter a valid phone number']) {
    if (v == null || v.trim().isEmpty) return msg;
    final ok = RegExp(r'^\+?[\d\s\-()]{7,15}$').hasMatch(v.trim());
    return ok ? null : msg;
  }

  static String? required(String? v, [String msg = 'This field is required']) {
    if (v == null || v.trim().isEmpty) return msg;
    return null;
  }
}

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

class _AppTextFieldState extends State<AppTextField> {
  bool _obscured = false;
  bool _toggleValue = false;

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

    Widget field = Container(
      decoration: BoxDecoration(
        color: widget.colorContainer,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: widget.boxShadow,
      ),
      child: TextFormField(
        controller: widget.controller,
        initialValue: widget.initialValue,
        stylusHandwritingEnabled: widget.scribbleEnabled,
        scrollController: widget.scrollController,
        scrollPhysics: widget.scrollPhysics,
        onSaved: widget.onSaved,
        obscureText: _obscured,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        textDirection: widget.controller?.estimateDirection(),
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        minLines: widget.minLines,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        validator: widget.validator,
        inputFormatters: _getInputFormatters(),
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
          suffixIcon: _resolveSuffixIcon(colors),
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
            borderSide: BorderSide(color: effectiveBorder.withValues(alpha: 0.4)),
          ),
        ),
      ),
    );

    return field
        .animate()
        .fadeIn(duration: 250.ms)
        .slideY(begin: -0.03, end: 0, duration: 250.ms);
  }

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  List<TextInputFormatter>? _getInputFormatters() {
    if (widget.inputFormatters != null) return widget.inputFormatters;

    switch (widget.type) {
      case AppTextFieldXType.number:
        return [FilteringTextInputFormatter.digitsOnly];
      case AppTextFieldXType.phone:
        return [FilteringTextInputFormatter.digitsOnly];
      default:
        return null;
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

  Widget? _resolveSuffixIcon(colors) {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: colors.textSecondary,
          size: 20,
        ),
        onPressed: () => setState(() => _obscured = !_obscured),
      );
    }
    if (widget.type == AppTextFieldXType.togglebtn) {
      return Switch(
        value: _toggleValue,
        onChanged: (v) => setState(() => _toggleValue = v),
        activeThumbColor: colors.neonGreen,
        activeTrackColor: colors.neonGreen.withValues(alpha: 0.35),
        inactiveThumbColor: colors.textSecondary,
        inactiveTrackColor: colors.border.withValues(alpha: 0.5),
      );
    }
    return widget.suffixIcon;
  }
}
