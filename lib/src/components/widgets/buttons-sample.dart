import 'package:material_ui/material_ui.dart';

/// Design system button component
class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  final Widget child;
  final AppButtonVariant variant;
  final IconData? icon;
  final IconPosition iconPosition;
  final AppButtonSize size;
  final bool expanded;
  final double? customIconSize;
  final EdgeInsetsGeometry? customPadding;
  final double borderRadius;
  final Color? customColor;
  final Color? customBgColor;
  final Color? customBorderColor;
  final Widget? Function(Widget child)? customBuilder;
  final List<BoxShadow>? boxShadow;
  final bool? isDisabled;
  final DefaultTextStyle? defaultTextStyle;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.onLongPress,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.iconPosition = IconPosition.start,
    this.size = AppButtonSize.md,
    this.expanded = false,
    this.customIconSize,
    this.customPadding,
    this.borderRadius = 8,
    this.customColor,
    this.customBgColor,
    this.customBorderColor,
    this.customBuilder,
    this.boxShadow,
    this.isDisabled,
    this.defaultTextStyle,
  });

  double get _iconSize {
    switch (size) {
      case AppButtonSize.sm:
        return 16;
      case AppButtonSize.md:
        return 20;
      case AppButtonSize.lg:
        return 24;
      case AppButtonSize.custom:
        return customIconSize ?? 20;
    }
  }

  EdgeInsets get _padding {
    if (customPadding != null) return customPadding! as EdgeInsets;
    switch (size) {
      case AppButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case AppButtonSize.md:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case AppButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
      case AppButtonSize.custom:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final effectiveIcon = icon;

    final content = _buildContent(effectiveIcon);

    Widget button;
    switch (variant) {
      case AppButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: _getStyle(colors),
          child: content,
        );
      case AppButtonVariant.text:
        button = TextButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: _getStyle(colors),
          child: content,
        );
      case AppButtonVariant.custom:
        if (customBuilder != null) {
          button = customBuilder!(content) ?? content;
        } else {
          button = GestureDetector(
            onTap: onPressed,
            onLongPress: onLongPress,
            child: Container(
              padding: _padding,
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: customBgColor,
                borderRadius: BorderRadius.circular(borderRadius),
                border: customBorderColor != null
                    ? Border.all(color: customBorderColor!)
                    : null,
                boxShadow: boxShadow,
              ),
              child: defaultTextStyle ??
                  DefaultTextStyle(
                    style: TextStyle(color: customColor),
                    child: content,
                  ),
            ),
          );
        }
      default:
        button = ElevatedButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: _getStyle(colors),
          child: content,
        );
    }

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }

  Widget _buildContent(IconData? icon) {
    if (icon == null) return child;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconPosition == IconPosition.start) ...[
          Icon(icon, size: _iconSize),
          const SizedBox(width: 8),
        ],
        child,
        if (iconPosition == IconPosition.end) ...[
          const SizedBox(width: 8),
          Icon(icon, size: _iconSize),
        ],
      ],
    );
  }

  ButtonStyle _getStyle(ColorScheme colors) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          padding: _padding,
          shape: shape,
        );
      case AppButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.secondary,
          foregroundColor: colors.onSecondary,
          padding: _padding,
          shape: shape,
        );
      case AppButtonVariant.outlined:
        return OutlinedButton.styleFrom(
          foregroundColor: customColor ?? colors.primary,
          side: BorderSide(color: customBorderColor ?? colors.primary),
          padding: _padding,
          shape: shape,
        );
      case AppButtonVariant.text:
        return TextButton.styleFrom(
          foregroundColor: customColor ?? colors.primary,
          padding: _padding,
          shape: shape,
        );
      case AppButtonVariant.tonal:
        return ElevatedButton.styleFrom(
          backgroundColor: colors.primaryContainer,
          foregroundColor: colors.onPrimaryContainer,
          padding: _padding,
          shape: shape,
        );
      case AppButtonVariant.custom:
        return TextButton.styleFrom(
          foregroundColor: customColor ?? colors.primary,
          backgroundColor: customBgColor,
          side: customBorderColor != null
              ? BorderSide(color: customBorderColor!)
              : null,
          padding: _padding,
          shape: shape,
        );
    }
  }
}

class AppButtonGestureDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BoxShadow? boxShadow;
  final EdgeInsetsGeometry? padding;
  final ShapeBorder? shape;
  final bool? enabled;
  final bool? isLoading;
  final double? width;
  final double? height;
  final double? borderRadius;
  final List<Color>? loadingColors;

  const AppButtonGestureDetector(
      {super.key,
      required this.child,
      this.onTap,
      this.backgroundColor,
      this.boxShadow,
      this.padding,
      this.shape,
      this.enabled,
      this.isLoading,
      this.width,
      this.height,
      this.borderRadius,
      this.loadingColors});

  @override
  State<AppButtonGestureDetector> createState() =>
      _AppButtonGestureDetectorState();
}

class _AppButtonGestureDetectorState extends State<AppButtonGestureDetector>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 0, end: 360).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    if (widget.isLoading == true) _controller.repeat();
  }

  @override
  void didUpdateWidget(AppButtonGestureDetector old) {
    super.didUpdateWidget(old);
    if (widget.isLoading == true) {
      _controller.repeat();
    } else {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = widget.isLoading == true;
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: widget.padding ?? const EdgeInsetsDirectional.all(8.0),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: loading ? null : widget.backgroundColor,
          boxShadow: widget.boxShadow != null ? [widget.boxShadow!] : null,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
        ),
        child: loading
            ? AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 8),
                      gradient: SweepGradient(
                        colors: widget.loadingColors ?? [
                          widget.backgroundColor ?? colors.surface,
                          colors.primary.withValues(alpha: 0.4),
                          colors.primary,
                          colors.primary.withValues(alpha: 0.4),
                          widget.backgroundColor ?? colors.surface,
                        ],
                        transform: GradientRotation(
                          _animation.value * 3.14159 / 180,
                        ),
                      ),
                    ),
                    child: Center(child: widget.child),
                  );
                },
              )
            : GestureDetector(
                onTap: widget.onTap,
                child: widget.child,
              ),
      ),
    );
  }
}

enum AppButtonSize { sm, md, lg, custom }

enum AppButtonVariant { primary, secondary, outlined, text, tonal, custom }

/// Icon-only button
class AppIconButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final IconData icon;
  final AppButtonSize size;
  final AppButtonVariant variant;
  final double? customIconSize;
  final double? customButtonSize;

  const AppIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = AppButtonSize.md,
    this.variant = AppButtonVariant.primary,
    this.customIconSize,
    this.customButtonSize,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final iconSize = switch (size) {
      AppButtonSize.sm => 20.0,
      AppButtonSize.md => 24.0,
      AppButtonSize.lg => 32.0,
      AppButtonSize.custom => customIconSize ?? 24.0,
    };
    final buttonSize = switch (size) {
      AppButtonSize.sm => 36.0,
      AppButtonSize.md => 48.0,
      AppButtonSize.lg => 56.0,
      AppButtonSize.custom => customButtonSize ?? 48.0,
    };

    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: iconSize),
      iconSize: iconSize,
      style: _getStyle(colors),
      constraints: BoxConstraints(
        minWidth: buttonSize,
        minHeight: buttonSize,
      ),
    );
  }

  ButtonStyle? _getStyle(ColorScheme colors) {
    switch (variant) {
      case AppButtonVariant.primary:
        return IconButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
        );
      case AppButtonVariant.secondary:
        return IconButton.styleFrom(
          backgroundColor: colors.secondary,
          foregroundColor: colors.onSecondary,
        );
      case AppButtonVariant.outlined:
        return IconButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.primary),
        );
      case AppButtonVariant.text:
        return IconButton.styleFrom(
          foregroundColor: colors.primary,
        );
      case AppButtonVariant.tonal:
        return IconButton.styleFrom(
          backgroundColor: colors.primaryContainer,
          foregroundColor: colors.onPrimaryContainer,
        );
      case AppButtonVariant.custom:
        return null;
    }
  }
}

enum IconPosition { start, end }
