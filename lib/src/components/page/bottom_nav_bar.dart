import 'dart:ui' show ImageFilter;

import 'package:material_ui/material_ui.dart';

import '../../theme/theme_extensions.dart';

/// Fully custom bottom navigation bar with liquid glass effect,
/// animated active indicator, and platform-adaptive layout.
class AppBottomNavBar extends StatefulWidget {
  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final double height;
  final double borderRadius;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;
  final Color? surfaceColor;
  final Color? activeIndicatorColor;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BottomNavPlatform? platform;
  final bool glassEffect;
  final double? blurSigma;
  final TextStyle? labelStyle;
  final TextStyle? activeLabelStyle;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final Color? badgeBorderColor;
  final TextStyle? badgeTextStyle;
  final double? iconSize;

  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.height = 64,
    this.borderRadius = 20,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
    this.surfaceColor,
    this.activeIndicatorColor,
    this.border,
    this.boxShadow,
    this.margin,
    this.padding,
    this.platform,
    this.glassEffect = true,
    this.blurSigma,
    this.labelStyle,
    this.activeLabelStyle,
    this.badgeColor,
    this.badgeTextColor,
    this.badgeBorderColor,
    this.badgeTextStyle,
    this.iconSize,
  });

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

/// A single item in [AppBottomNavBar].
class AppBottomNavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String? label;
  final int? badge;

  const AppBottomNavItem({
    required this.icon,
    this.activeIcon,
    this.label,
    this.badge,
  });
}

/// Platform variant for bottom nav appearance.
enum BottomNavPlatform { android, ios }

class _AppBottomNavBarState extends State<AppBottomNavBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController;
  late final Animation<double> _bounce;

  BottomNavPlatform get _platform =>
      widget.platform ??
      (Theme.of(context).platform == TargetPlatform.iOS
          ? BottomNavPlatform.ios
          : BottomNavPlatform.android);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = context.isDark;
    final isIOS = _platform == BottomNavPlatform.ios;

    final activeColor = widget.activeColor ?? colors.primary;
    final inactiveColor = widget.inactiveColor ??
        (isDark ? colors.textDim : colors.textSecondary);
    final bgColor = widget.backgroundColor ?? Colors.transparent;
    final surfaceColor = widget.surfaceColor ?? colors.surface;
    final activeIndicatorColor = widget.activeIndicatorColor ?? activeColor;
    final resolvedMargin = widget.margin ?? EdgeInsets.zero;
    final resolvedPadding = widget.padding ?? EdgeInsets.zero;
    final effectiveIconSize = widget.iconSize ?? (isIOS ? 26.0 : 24.0);
    final badgeBgColor = widget.badgeColor ?? colors.neonRed;
    final badgeTextColor = widget.badgeTextColor ?? Colors.white;
    final badgeBorderColor = widget.badgeBorderColor ?? surfaceColor;
    final effectiveBadgeStyle = widget.badgeTextStyle ??
        const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
        );
    final effectiveBlurSigma = widget.blurSigma ?? 16;

    final screenWidth = MediaQuery.of(context).size.width;
    final barRadius = widget.borderRadius;
    final horizontalMargin =
        barRadius + (isIOS ? 8 : 0) + resolvedMargin.horizontal / 2;
    final availableWidth =
        screenWidth - horizontalMargin * 2 - resolvedPadding.horizontal;
    final itemWidth = availableWidth / widget.items.length;
    final indicatorLeft =
        widget.currentIndex * itemWidth + (itemWidth - 32) / 2;

    Widget bar = SizedBox(
      height: widget.height + MediaQuery.of(context).padding.bottom,
      child: Stack(
        children: [
          // Animated indicator pill
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOutCubic,
            bottom: isIOS ? null : 0,
            top: isIOS ? 0 : null,
            left: indicatorLeft +
                horizontalMargin +
                resolvedPadding.horizontal / 2,
            child: AnimatedBuilder(
              animation: _bounce,
              builder: (context, _) {
                return Transform.scale(
                  scale: 1.0 + _bounce.value * 0.2,
                  child: Container(
                    width: 32,
                    height: 3,
                    decoration: BoxDecoration(
                      color: activeIndicatorColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              },
            ),
          ),
          // Tabs
          Padding(
            padding: EdgeInsets.only(
              left: horizontalMargin + resolvedPadding.horizontal / 2,
              right: horizontalMargin + resolvedPadding.vertical / 2,
            ),
            child: Row(
              children: List.generate(widget.items.length, (i) {
                final item = widget.items[i];
                final isActive = widget.currentIndex == i;

                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      widget.onTap(i);
                      _bounceController
                        ..reset()
                        ..forward();
                    },
                    child: Padding(
                      padding: resolvedPadding,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(
                                isActive
                                    ? (item.activeIcon ?? item.icon)
                                    : item.icon,
                                size: effectiveIconSize,
                                color: isActive ? activeColor : inactiveColor,
                              ),
                              if (item.badge != null && item.badge! > 0)
                                PositionedDirectional(
                                  top: -4,
                                  end: -8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: badgeBgColor,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: badgeBorderColor,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Text(
                                      item.badge! > 99
                                          ? '99+'
                                          : '${item.badge}',
                                      style: effectiveBadgeStyle.copyWith(
                                        color: badgeTextColor,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (item.label != null)
                            Padding(
                              padding: EdgeInsets.only(top: isIOS ? 2 : 4),
                              child: Text(
                                item.label!,
                                style: isActive
                                    ? (widget.activeLabelStyle ??
                                        TextStyle(
                                          fontSize: isIOS ? 10 : 11,
                                          fontWeight: FontWeight.w600,
                                          color: activeColor,
                                        ))
                                    : (widget.labelStyle ??
                                        TextStyle(
                                          fontSize: isIOS ? 10 : 11,
                                          fontWeight: FontWeight.w400,
                                          color: inactiveColor,
                                        )),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );

    // Wrap in glass effect or plain container
    if (widget.glassEffect) {
      bar = ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(barRadius),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: effectiveBlurSigma,
            sigmaY: effectiveBlurSigma,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: bgColor.withValues(alpha: 0.7),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(barRadius),
              ),
              border: widget.border ??
                  BoxBorder.all(
                    color: isDark ? Colors.white12 : Colors.white38,
                    width: 0.5,
                  ),
            ),
            child: bar,
          ),
        ),
      );
    } else {
      bar = Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(barRadius),
          ),
          border: widget.border,
          boxShadow: widget.boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
        ),
        child: bar,
      );
    }

    if (resolvedMargin != EdgeInsets.zero) {
      bar = Padding(padding: resolvedMargin, child: bar);
    }

    return bar;
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _bounce = CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    );
  }
}
