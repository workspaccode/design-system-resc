import 'dart:ui' show ImageFilter;

import 'package:material_ui/material_ui.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final double border;
  final EdgeInsetsGeometry? padding;
  final double sigma;
  final Color? backgroundColor;
  final bool isGlass;
  final bool? isBorder;
  final List<BoxShadow>? boxShadow;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 16,
    this.border = 1,
    this.padding,
    this.sigma = 8,
    this.backgroundColor,
    this.boxShadow,
    this.isGlass = true,
    this.isBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tint = isDark ? Colors.white10 : Colors.white60;
    final borderColor = isDark ? Colors.white12 : Colors.white38;

    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: isGlass
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: backgroundColor ?? tint,
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: isBorder ?? true
                        ? Border.all(color: borderColor, width: border)
                        : null,
                  ),
                  child: Padding(
                    padding: padding ?? EdgeInsets.zero,
                    child: child,
                  ),
                ),
              )
            : Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: backgroundColor ?? tint,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: isBorder ?? true
                      ? Border.all(color: borderColor, width: border)
                      : null,
                  boxShadow: boxShadow ?? [],
                ),
                child: Padding(
                  padding: padding ?? EdgeInsets.zero,
                  child: child,
                ),
              ));
  }
}

class GlassContainer2 extends StatelessWidget {
  final double wd, ht;
  final Widget child;
  final Color? colorText, bg, border;
  final List<BoxShadow>? boxShadow;
  final void Function()? onTap;
  final Widget? leading;
  final Widget? trailing;
  const GlassContainer2(
      {super.key,
      required this.wd,
      required this.ht,
      required this.child,
      required this.colorText,
      required this.bg,
      required this.border,
      required this.boxShadow,
      required this.onTap,
      this.leading,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16),
            boxShadow: boxShadow ??
                [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
          ),
          child: Row(
            children: [
              if (leading != null) leading!,
              Expanded(child: child),
              if (trailing != null) trailing!,
            ],
          )),
    );
  }
}
