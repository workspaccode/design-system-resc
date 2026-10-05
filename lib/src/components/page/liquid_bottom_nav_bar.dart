import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import 'liquid_nav_item.dart';
import 'liquid_nav_style.dart';

typedef LiquidNavItemIconBuilder = IconData Function(LiquidNavItem item);

/// A liquid-like bottom navigation bar with physics-based blob animation,
/// drag support, and glass-effect background.
///
/// The blob stretches, wobbles, and slides between tabs with velocity-based
/// deformation for a fluid, organic feel.
@immutable
class LiquidBottomNavBar extends StatefulWidget {
  final int currentIndex;

  final List<LiquidNavItem> items;

  /// Preferred callback for tab selection.
  final ValueChanged<int>? onTap;

  /// Backward compatibility callback.
  final ValueChanged<int>? onChanged;

  /// Called when drag gesture ends at nearest tab.
  final ValueChanged<int>? onDrag;

  /// Optional badges map by index.
  final Map<int, int>? badges;

  final LiquidNavStyle style;

  final Color? backgroundColor;

  final Color? containerColor;
  final Color? liquidColor;
  final Color? activeIconColor;
  final Color? inactiveIconColor;
  final Border? border;
  final BorderSide? borderSide;
  final BorderRadiusGeometry? borderRadius;
  final double height;

  final double? width;
  final double iconSize;
  // final Color? color;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Duration animationDuration;

  final Curve curve;
  final List<BoxShadow>? boxShadow;
  final TextStyle? labelStyle;

  final TextStyle? activeLabelStyle;
  final bool? showLabel;
  final LiquidNavItemIconBuilder? activeIcon;

  final LiquidNavItemIconBuilder? inactiveIcon;

  /// Optional blur (glass effect). Null or 0 disables.
  final double? blurSigma;

  final Color badgeColor;

  final Color badgeTextColor;
  final Color? badgeBorderColor;
  final TextStyle? badgeTextStyle;
  final double blobBaseWidthFactor;

  final double blobExpandedWidthFactor;
  final double blobBaseHeight;
  final double blobExpandedHeight;
  final double blobStretchMultiplier;
  final double blobMaxStretch;
  final double blobWobbleInfluenceOnWidth;
  final double blobWobbleInfluenceOnHeight;
  final double shadowOffset;
  final double shadowAlpha;
  final double shadowBlurSigma;
  final double borderAlpha;
  final double borderWidth;
  final double gradientSurfaceAlpha;
  final double gradientPrimaryAlpha1;
  final double gradientPrimaryAlpha2;
  final double dragWaveHeightMultiplier;
  final double dragWavePositionMultiplier;
  final bool showBorder;
  final bool canScroll;

  /// Enables horizontal/vertical scrolling when items exceed [_LiquidBottomNavBarState._maxItemDisplayed].
  final bool enableScroll;
  final Axis scrollDirection;
  final LiquidColorMode colorMode;

  /// Whether to show default drag handles for reordering.
  final bool buildDefaultDragHandles;

  /// Called when an item is dragged to a new position.
  /// Receives (oldIndex, newIndex) — the parent should reorder [items] accordingly.
  final ReorderCallback? onReorder;

  /// Wraps each item during a reorder drag. Default scales to 1.5x.
  final ReorderItemProxyDecorator? proxyDecorator;

  /// Optional controller for drag behavior control.
  final LiquidBottomNavBarController? controller;
  final List<Color>? customGradientColors;
  final Color? borderColor;
  final List<Color>? borderGradientColors;
  final double? gapBetweenIconAndLabel;
  final double iconBackgroundWidth;
  final double iconBackgroundHeight;
  final bool iconBackgroundIsCircular;
  final bool showMainBlob;
  final bool isShow990;
  final bool iconBackgroundAnimated;
  final double iconBackgroundVelocity;
  final double iconBackgroundWobble;
  final double iconBackgroundExpansion;
  const LiquidBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    this.onTap,
    this.onChanged,
    this.onDrag,
    this.badges,
    this.style = const LiquidNavStyle(),
    this.backgroundColor,
    this.containerColor,
    this.liquidColor,
    this.activeIconColor,
    this.inactiveIconColor,
    this.border,
    this.borderSide,
    this.borderRadius,
    this.height = 80,
    this.width,
    this.iconSize = 18,
    this.padding = const EdgeInsets.symmetric(horizontal: 4),
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.animationDuration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOutQuint,
    this.boxShadow,
    this.labelStyle,
    this.activeLabelStyle,
    this.showLabel,
    this.activeIcon,
    this.inactiveIcon,
    this.blurSigma,
    this.badgeColor = const Color(0xFFE53935),
    this.badgeTextColor = const Color(0xFFFFFFFF),
    this.badgeBorderColor,
    this.badgeTextStyle,
    this.blobBaseWidthFactor = 0.88,
    this.blobExpandedWidthFactor = 1.15,
    this.blobBaseHeight = 48,
    this.blobExpandedHeight = 65,
    this.blobStretchMultiplier = 35,
    this.blobMaxStretch = 45,
    this.blobWobbleInfluenceOnWidth = 1,
    this.blobWobbleInfluenceOnHeight = 0.3,
    this.shadowOffset = 3,
    this.shadowAlpha = 0.15,
    this.shadowBlurSigma = 10,
    this.borderAlpha = 0.8,
    this.borderWidth = 1.2,
    this.gradientSurfaceAlpha = 0.95,
    this.gradientPrimaryAlpha1 = 0.18,
    this.gradientPrimaryAlpha2 = 0.45,
    this.dragWaveHeightMultiplier = 3.5,
    this.dragWavePositionMultiplier = 1.4,
    this.showBorder = true,
    this.canScroll = true,
    this.enableScroll = true,
    this.scrollDirection = Axis.horizontal,
    this.colorMode = LiquidColorMode.gradient,
    this.buildDefaultDragHandles = true,
    this.onReorder,
    this.proxyDecorator,
    this.controller,
    this.customGradientColors,
    this.borderColor,
    this.borderGradientColors,
    this.gapBetweenIconAndLabel,
    this.iconBackgroundWidth = 40,
    this.iconBackgroundHeight = 40,
    this.iconBackgroundIsCircular = true,
    this.showMainBlob = true,
    this.isShow990 = false,
    this.iconBackgroundAnimated = false,
    this.iconBackgroundVelocity = 0,
    this.iconBackgroundWobble = 0,
    this.iconBackgroundExpansion = 0,
  })  : assert(items.length >= 2, 'items must contain at least 2 entries'),
        assert(onTap != null || onChanged != null,
            'Provide onTap or onChanged callback');

  @override
  State<LiquidBottomNavBar> createState() => _LiquidBottomNavBarState();
}

/// Controller for programmatically controlling drag and reorder behavior.
class LiquidBottomNavBarController extends ChangeNotifier {
  bool _dragEnabled = true;
  bool _reorderEnabled = true;
  bool _tapEnabled = true;

  /// Whether swipe-to-change-tabs is enabled.
  bool get dragEnabled => _dragEnabled;

  /// Whether long-press drag-to-reorder is enabled.
  bool get reorderEnabled => _reorderEnabled;

  /// Whether individual item taps are enabled.
  bool get tapEnabled => _tapEnabled;

  /// Enable or disable swipe-to-change-tabs.
  void setDragEnabled(bool enabled) {
    if (_dragEnabled != enabled) {
      _dragEnabled = enabled;
      notifyListeners();
    }
  }

  /// Enable or disable long-press drag-to-reorder.
  void setReorderEnabled(bool enabled) {
    if (_reorderEnabled != enabled) {
      _reorderEnabled = enabled;
      notifyListeners();
    }
  }

  /// Enable or disable individual item taps.
  void setTapEnabled(bool enabled) {
    if (_tapEnabled != enabled) {
      _tapEnabled = enabled;
      notifyListeners();
    }
  }
}

enum LiquidColorMode { single, gradient }

class _IOSLiquidPainter extends CustomPainter {
  final double position;

  final double itemWidth;
  final double velocity;
  final double expansion;
  final double wobble;
  final double dragWobble;
  final double horizontalInset;
  final Color primaryColor;
  final Color surfaceColor;
  final double blobBaseWidthFactor;
  final double blobExpandedWidthFactor;
  final double blobBaseHeight;
  final double blobExpandedHeight;
  final double blobStretchMultiplier;
  final double blobMaxStretch;
  final double blobWobbleInfluenceOnWidth;
  final double blobWobbleInfluenceOnHeight;
  final double shadowOffset;
  final double shadowAlpha;
  final double shadowBlurSigma;
  final double borderAlpha;
  final double borderWidth;
  final double gradientSurfaceAlpha;
  final double gradientPrimaryAlpha1;
  final double gradientPrimaryAlpha2;
  final double dragWaveHeightMultiplier;
  final double dragWavePositionMultiplier;
  final bool showBorder;
  final bool isVertical;
  final TextDirection textDirection;
  final double centerYOffset;
  final LiquidColorMode colorMode;
  final List<Color>? customGradientColors;
  final Color? borderColor;
  final List<Color>? borderGradientColors;
  final bool buildDefaultDragHandles;
  final double iconSize;
  final double iconBackgroundWidth;
  final double iconBackgroundHeight;
  final bool iconBackgroundIsCircular;
  final bool showMainBlob;
  final bool isShow990;
  final bool iconBackgroundAnimated;
  final double iconBackgroundVelocity;
  final double iconBackgroundWobble;
  final double iconBackgroundExpansion;
  _IOSLiquidPainter({
    required this.position,
    required this.itemWidth,
    required this.velocity,
    required this.expansion,
    required this.wobble,
    required this.dragWobble,
    required this.horizontalInset,
    required this.primaryColor,
    required this.surfaceColor,
    required this.blobBaseWidthFactor,
    required this.blobExpandedWidthFactor,
    required this.blobBaseHeight,
    required this.blobExpandedHeight,
    required this.blobStretchMultiplier,
    required this.blobMaxStretch,
    required this.blobWobbleInfluenceOnWidth,
    required this.blobWobbleInfluenceOnHeight,
    required this.shadowOffset,
    required this.shadowAlpha,
    required this.shadowBlurSigma,
    required this.borderAlpha,
    required this.borderWidth,
    required this.gradientSurfaceAlpha,
    required this.gradientPrimaryAlpha1,
    required this.gradientPrimaryAlpha2,
    required this.dragWaveHeightMultiplier,
    required this.dragWavePositionMultiplier,
    required this.showBorder,
    required this.isVertical,
    required this.textDirection,
    this.centerYOffset = 0,
    required this.colorMode,
    this.customGradientColors,
    this.borderColor,
    this.borderGradientColors,
    required this.buildDefaultDragHandles,
    required this.iconSize,
    this.iconBackgroundWidth = 40,
    this.iconBackgroundHeight = 40,
    this.iconBackgroundIsCircular = true,
    this.showMainBlob = true,
    this.isShow990 = false,
    this.iconBackgroundAnimated = false,
    this.iconBackgroundVelocity = 0,
    this.iconBackgroundWobble = 0,
    this.iconBackgroundExpansion = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final posFromStart = horizontalInset + (position * itemWidth) + (itemWidth / 2);
    final pos = textDirection == TextDirection.rtl ? size.width - posFromStart : posFromStart;
    final centerX = isVertical ? size.width / 2 : pos;
    final centerY = (isVertical ? pos : size.height / 2) - centerYOffset;

    final baseWidth = itemWidth * blobBaseWidthFactor;
    final expandedWidth = itemWidth * blobExpandedWidthFactor;
    var currentWidth =
        lerpDouble(baseWidth, expandedWidth, expansion) ?? baseWidth;

    final stretch =
        (velocity.abs() * blobStretchMultiplier).clamp(0.0, blobMaxStretch);
    currentWidth += stretch + (wobble * blobWobbleInfluenceOnWidth);

    final baseHeight = blobBaseHeight;
    final expandedHeight = blobExpandedHeight;
    var currentHeight =
        lerpDouble(baseHeight, expandedHeight, expansion) ?? baseHeight;

    currentHeight -= wobble * blobWobbleInfluenceOnHeight;
    final dragWave =
        math.sin(dragWobble * math.pi * 2) * velocity.abs().clamp(0.0, 1.0);
    currentHeight += dragWave * dragWaveHeightMultiplier;

    final dx = isVertical ? 0.0 : dragWave * dragWavePositionMultiplier;
    final dy = isVertical ? dragWave * dragWavePositionMultiplier : 0.0;

    final rect = Rect.fromCenter(
      center: Offset(centerX + dx, centerY + dy),
      width: currentWidth,
      height: currentHeight,
    );

    final rrect =
        RRect.fromRectAndRadius(rect, Radius.circular(currentHeight / 2));

    // Create a smaller rounded background around the icon
    // Position the icon background slightly above center to account for label offset
    final iconBackgroundCenterY = (centerY + dy) - centerYOffset;

    // Apply animation effects to icon background if enabled
    double animatedIconWidth = iconBackgroundWidth;
    double animatedIconHeight = iconBackgroundHeight;
    double iconDx = dx;
    double iconDy = dy;

    if (iconBackgroundAnimated) {
      // Apply expansion
      final expandedIconWidth =
          iconBackgroundWidth * (1 + iconBackgroundExpansion);
      final expandedIconHeight =
          iconBackgroundHeight * (1 + iconBackgroundExpansion);
      animatedIconWidth =
          lerpDouble(iconBackgroundWidth, expandedIconWidth, expansion) ??
              iconBackgroundWidth;
      animatedIconHeight =
          lerpDouble(iconBackgroundHeight, expandedIconHeight, expansion) ??
              iconBackgroundHeight;

      // Apply wobble
      animatedIconWidth += iconBackgroundWobble * 2;
      animatedIconHeight -= iconBackgroundWobble;

      // Apply velocity-based movement
      final iconVelocityDx = isVertical ? 0.0 : iconBackgroundVelocity * 2;
      final iconVelocityDy = isVertical ? iconBackgroundVelocity * 2 : 0.0;
      iconDx += iconVelocityDx;
      iconDy += iconVelocityDy;
    }

    final iconBackgroundRect = Rect.fromCenter(
      center: Offset(centerX + iconDx, iconBackgroundCenterY + iconDy),
      width: animatedIconWidth,
      height: animatedIconHeight,
    );
    final iconBackgroundRRect = iconBackgroundIsCircular
        ? RRect.fromRectAndRadius(
            iconBackgroundRect,
            Radius.circular(animatedIconWidth / 2),
          )
        : RRect.fromRectAndRadius(
            iconBackgroundRect,
            Radius.circular(8),
          );

    Paint liquidPaint;
    if (colorMode == LiquidColorMode.single) {
      liquidPaint = Paint()
        ..color = primaryColor.withValues(alpha: gradientPrimaryAlpha1);
    } else {
      final gradientColors = customGradientColors ??
          [
            surfaceColor.withValues(alpha: gradientSurfaceAlpha),
            primaryColor.withValues(alpha: gradientPrimaryAlpha1),
            primaryColor.withValues(alpha: gradientPrimaryAlpha2),
          ];
      liquidPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ).createShader(rect);
    }

    // Draw main blob only if enabled
    if (showMainBlob) {
      canvas.drawRRect(
        rrect.shift(Offset(0, shadowOffset)),
        Paint()
          ..color = primaryColor.withValues(alpha: shadowAlpha)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlurSigma),
      );

      canvas.drawRRect(rrect, liquidPaint);

      if (showBorder) {
        Paint borderPaint;
        if (borderGradientColors != null && borderGradientColors!.length > 1) {
          borderPaint = Paint()
            ..shader = LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: borderGradientColors!,
            ).createShader(rect)
            ..style = PaintingStyle.stroke
            ..strokeWidth = borderWidth;
        } else {
          final finalBorderColor = borderColor ?? surfaceColor;
          borderPaint = Paint()
            ..color = finalBorderColor.withValues(alpha: borderAlpha)
            ..style = PaintingStyle.stroke
            ..strokeWidth = borderWidth;
        }
        canvas.drawRRect(rrect, borderPaint);
      }
    }

    // Draw icon background
    final iconBackgroundPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.15);
    canvas.drawRRect(iconBackgroundRRect, iconBackgroundPaint);
  }

  @override
  bool shouldRepaint(_IOSLiquidPainter oldDelegate) {
    return oldDelegate.position != position ||
        oldDelegate.itemWidth != itemWidth ||
        oldDelegate.velocity != velocity ||
        oldDelegate.expansion != expansion ||
        oldDelegate.wobble != wobble ||
        oldDelegate.dragWobble != dragWobble ||
        oldDelegate.horizontalInset != horizontalInset ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.surfaceColor != surfaceColor ||
        oldDelegate.blobBaseWidthFactor != blobBaseWidthFactor ||
        oldDelegate.blobExpandedWidthFactor != blobExpandedWidthFactor ||
        oldDelegate.blobBaseHeight != blobBaseHeight ||
        oldDelegate.blobExpandedHeight != blobExpandedHeight ||
        oldDelegate.blobStretchMultiplier != blobStretchMultiplier ||
        oldDelegate.blobMaxStretch != blobMaxStretch ||
        oldDelegate.blobWobbleInfluenceOnWidth != blobWobbleInfluenceOnWidth ||
        oldDelegate.blobWobbleInfluenceOnHeight !=
            blobWobbleInfluenceOnHeight ||
        oldDelegate.shadowOffset != shadowOffset ||
        oldDelegate.shadowAlpha != shadowAlpha ||
        oldDelegate.shadowBlurSigma != shadowBlurSigma ||
        oldDelegate.borderAlpha != borderAlpha ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.gradientSurfaceAlpha != gradientSurfaceAlpha ||
        oldDelegate.gradientPrimaryAlpha1 != gradientPrimaryAlpha1 ||
        oldDelegate.gradientPrimaryAlpha2 != gradientPrimaryAlpha2 ||
        oldDelegate.dragWaveHeightMultiplier != dragWaveHeightMultiplier ||
        oldDelegate.dragWavePositionMultiplier != dragWavePositionMultiplier ||
        oldDelegate.showBorder != showBorder ||
        oldDelegate.isVertical != isVertical ||
        oldDelegate.textDirection != textDirection ||
        oldDelegate.colorMode != colorMode ||
        oldDelegate.customGradientColors != customGradientColors ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.borderGradientColors != borderGradientColors ||
        oldDelegate.iconSize != iconSize ||
        oldDelegate.iconBackgroundWidth != iconBackgroundWidth ||
        oldDelegate.iconBackgroundHeight != iconBackgroundHeight ||
        oldDelegate.iconBackgroundIsCircular != iconBackgroundIsCircular ||
        oldDelegate.showMainBlob != showMainBlob ||
        oldDelegate.isShow990 != isShow990 ||
        oldDelegate.iconBackgroundAnimated != iconBackgroundAnimated ||
        oldDelegate.iconBackgroundVelocity != iconBackgroundVelocity ||
        oldDelegate.iconBackgroundWobble != iconBackgroundWobble ||
        oldDelegate.iconBackgroundExpansion != iconBackgroundExpansion;
  }
}

class _LiquidBottomNavBarState extends State<LiquidBottomNavBar>
    with TickerProviderStateMixin {
  static const int _maxItemDisplayed = 5;

  late final AnimationController _expansionController;
  late final AnimationController _snapController;
  late final AnimationController _wobbleController;
  late final AnimationController _dragWobbleController;
  late final AnimationController _visualController;

  final ScrollController _scrollController = ScrollController();

  double _dragPosition = 0;
  bool _isDragging = false;
  bool _isReordering = false;
  double _velocity = 0;
  double? _snapTarget;
  Animation<double>? _currentAnimation;
  VoidCallback? _snapListener;
  // Animated visual property values
  double _animatedShadowOffset = 3;
  double _animatedShadowAlpha = 0.15;
  double _animatedShadowBlurSigma = 10;
  double _animatedBorderAlpha = 0.8;
  double _animatedBorderWidth = 1.2;
  double _animatedGradientSurfaceAlpha = 0.95;
  double _animatedGradientPrimaryAlpha1 = 0.18;
  double _animatedGradientPrimaryAlpha2 = 0.45;
  double _animatedDragWaveHeightMultiplier = 3.5;
  double _animatedDragWavePositionMultiplier = 1.4;
  double _animatedBlobWobbleInfluenceOnWidth = 1;
  double _animatedBlobWobbleInfluenceOnHeight = 0.3;
  // Target values for animation
  double? _targetShadowOffset;

  double? _targetShadowAlpha;
  double? _targetShadowBlurSigma;
  double? _targetBorderAlpha;
  double? _targetBorderWidth;
  double? _targetGradientSurfaceAlpha;
  double? _targetGradientPrimaryAlpha1;
  double? _targetGradientPrimaryAlpha2;
  double? _targetDragWaveHeightMultiplier;
  double? _targetDragWavePositionMultiplier;
  double? _targetBlobWobbleInfluenceOnWidth;
  double? _targetBlobWobbleInfluenceOnHeight;
  bool get _isDragEnabled => widget.controller?.dragEnabled ?? widget.canScroll;
  bool get _isReorderEnabled =>
      widget.controller?.reorderEnabled ?? (widget.onReorder != null);

  bool get _isTapEnabled => widget.controller?.tapEnabled ?? true;

  void animateVisualProperties({
    double? shadowOffset,
    double? shadowAlpha,
    double? shadowBlurSigma,
    double? borderAlpha,
    double? borderWidth,
    double? gradientSurfaceAlpha,
    double? gradientPrimaryAlpha1,
    double? gradientPrimaryAlpha2,
    double? dragWaveHeightMultiplier,
    double? dragWavePositionMultiplier,
    double? blobWobbleInfluenceOnWidth,
    double? blobWobbleInfluenceOnHeight,
  }) {
    if (shadowOffset != null) _targetShadowOffset = shadowOffset;
    if (shadowAlpha != null) _targetShadowAlpha = shadowAlpha;
    if (shadowBlurSigma != null) _targetShadowBlurSigma = shadowBlurSigma;
    if (borderAlpha != null) _targetBorderAlpha = borderAlpha;
    if (borderWidth != null) _targetBorderWidth = borderWidth;
    if (gradientSurfaceAlpha != null)
      _targetGradientSurfaceAlpha = gradientSurfaceAlpha;
    if (gradientPrimaryAlpha1 != null)
      _targetGradientPrimaryAlpha1 = gradientPrimaryAlpha1;
    if (gradientPrimaryAlpha2 != null)
      _targetGradientPrimaryAlpha2 = gradientPrimaryAlpha2;
    if (dragWaveHeightMultiplier != null)
      _targetDragWaveHeightMultiplier = dragWaveHeightMultiplier;
    if (dragWavePositionMultiplier != null)
      _targetDragWavePositionMultiplier = dragWavePositionMultiplier;
    if (blobWobbleInfluenceOnWidth != null)
      _targetBlobWobbleInfluenceOnWidth = blobWobbleInfluenceOnWidth;
    if (blobWobbleInfluenceOnHeight != null)
      _targetBlobWobbleInfluenceOnHeight = blobWobbleInfluenceOnHeight;

    _visualController.stop();
    _visualController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final int safeIndex = widget.currentIndex.clamp(0, widget.items.length - 1);
    // final colors = context.colors;

    final style = widget.style
        .copyWith(
          backgroundColor: widget.backgroundColor,
          containerColor: widget.containerColor,
          liquidColor: widget.liquidColor,
          activeIconColor: widget.activeIconColor,
          inactiveIconColor: widget.inactiveIconColor,
          border: widget.border,
          borderSide: widget.borderSide,
          borderRadius: widget.borderRadius,
          boxShadow: widget.boxShadow,
          labelStyle: widget.labelStyle,
          activeLabelStyle: widget.activeLabelStyle,
          showLabel: widget.showLabel,
          blurSigma: widget.blurSigma,
        )
        .resolve(context);

    return Container(
      color: style.backgroundColor,
      margin: widget.margin,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isVertical = widget.scrollDirection == Axis.vertical;
          final availableWidth = constraints.maxWidth.isFinite
              ? constraints.maxWidth
              : MediaQuery.sizeOf(context).width;
          final maxWidth = math.max(0.0, widget.width ?? availableWidth);
          final resolvedPadding =
              widget.padding.resolve(Directionality.of(context));
          final innerHeight =
              math.max(48.0, widget.height - resolvedPadding.vertical);

          final visibleCount = widget.enableScroll
              ? math.min(_maxItemDisplayed, widget.items.length)
              : widget.items.length;
          final totalWidth =
              math.max(0.0, maxWidth - _horizontalPadding(widget.padding));
          final cellSize = isVertical
              ? math.max(1.0, innerHeight / visibleCount)
              : math.max(0.0, totalWidth / visibleCount);
          final overflow =
              widget.enableScroll && widget.items.length > _maxItemDisplayed;
          final listViewPad = overflow ? cellSize / 2 : 0.0;
          final itemInset =
              isVertical ? resolvedPadding.top : resolvedPadding.left;

          Widget navBar = ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(overscroll: false),
            child: SizedBox(
              width: maxWidth,
              height: widget.height,
              child: Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onPanStart: !_isReordering && _isDragEnabled
                      ? (_) {
                          setState(() => _isDragging = true);
                          _expansionController.forward();
                          _wobbleController.stop();
                          _snapController.stop();
                          _dragWobbleController.repeat();
                        }
                      : null,
                  onPanUpdate: !_isReordering && _isDragEnabled
                      ? (details) {
                          setState(() {
                            final delta = isVertical
                                ? details.delta.dy
                                : details.delta.dx;
                            _velocity = delta / cellSize;
                            _dragPosition = (_dragPosition + _velocity).clamp(
                              0.0,
                              (widget.items.length - 1).toDouble(),
                            );
                          });
                        }
                      : null,
                  onPanEnd: !_isReordering && _isDragEnabled
                      ? (_) {
                          setState(() {
                            _isDragging = false;
                            _velocity = 0;
                          });
                          _dragWobbleController.stop();
                          _expansionController.reverse();
                          final nearestTab = _dragPosition
                              .round()
                              .clamp(0, widget.items.length - 1);
                          _animateTo(nearestTab);
                          widget.onDrag?.call(nearestTab);
                          _selectIndex(nearestTab);
                        }
                      : null,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: style.borderRadius,
                      boxShadow: style.boxShadow,
                    ),
                    child: Container(
                      height: innerHeight,
                      decoration: BoxDecoration(
                        borderRadius: style.borderRadius,
                        //border: style.resolveBorder(),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          widget.isShow990 == true
                              ? Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: style.borderRadius!,
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: style.blurSigma ?? 0,
                                        sigmaY: style.blurSigma ?? 0,
                                      ),
                                      child: ColoredBox(
                                          color: style.containerColor!),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                          Positioned.fill(
                            child: AnimatedBuilder(
                              animation: Listenable.merge([
                                _expansionController,
                                _snapController,
                                _wobbleController,
                                _dragWobbleController,
                                _visualController,
                                _scrollController,
                                ...widget.controller != null
                                    ? [widget.controller!]
                                    : [],
                              ]),
                              builder: (context, _) {
                                final wobbleVal = math.sin(
                                        _wobbleController.value * math.pi * 4) *
                                    (1 - _wobbleController.value) *
                                    15.0;
                                final scrollOffset =
                                    _scrollController.hasClients
                                        ? _scrollController.offset
                                        : 0.0;
                                final effectivePosition =
                                    _dragPosition - scrollOffset / cellSize;
                                final iconOffset =
                                    style.showLabel ? (2.0 + 9.0) / 2 : 0.0;
                                return CustomPaint(
                                  painter: _IOSLiquidPainter(
                                      position: effectivePosition,
                                      itemWidth: cellSize,
                                      centerYOffset: iconOffset,
                                      velocity: _isDragging ? _velocity : 0,
                                      expansion: _expansionController.value,
                                      wobble: wobbleVal,
                                      dragWobble: _isDragging
                                          ? _dragWobbleController.value
                                          : 0,
                                      horizontalInset: itemInset + listViewPad,
                                      primaryColor: style.liquidColor!,
                                      surfaceColor: style.containerColor!,
                                      blobBaseWidthFactor:
                                          widget.blobBaseWidthFactor,
                                      blobExpandedWidthFactor:
                                          widget.blobExpandedWidthFactor,
                                      blobBaseHeight: widget.blobBaseHeight,
                                      blobExpandedHeight:
                                          widget.blobExpandedHeight,
                                      blobStretchMultiplier:
                                          widget.blobStretchMultiplier,
                                      blobMaxStretch: widget.blobMaxStretch,
                                      blobWobbleInfluenceOnWidth:
                                          _animatedBlobWobbleInfluenceOnWidth,
                                      blobWobbleInfluenceOnHeight:
                                          _animatedBlobWobbleInfluenceOnHeight,
                                      shadowOffset: _animatedShadowOffset,
                                      shadowAlpha: _animatedShadowAlpha,
                                      shadowBlurSigma: _animatedShadowBlurSigma,
                                      borderAlpha: _animatedBorderAlpha,
                                      borderWidth: _animatedBorderWidth,
                                      gradientSurfaceAlpha:
                                          _animatedGradientSurfaceAlpha,
                                      gradientPrimaryAlpha1:
                                          _animatedGradientPrimaryAlpha1,
                                      gradientPrimaryAlpha2:
                                          _animatedGradientPrimaryAlpha2,
                                      dragWaveHeightMultiplier:
                                          _animatedDragWaveHeightMultiplier,
                                      dragWavePositionMultiplier:
                                          _animatedDragWavePositionMultiplier,
                                      showBorder: widget.showBorder,
                                      isVertical: isVertical,
                                      textDirection: Directionality.of(context),
                                      colorMode: widget.colorMode,
                                      customGradientColors:
                                          widget.customGradientColors,
                                      borderColor: widget.borderColor,
                                      borderGradientColors:
                                          widget.borderGradientColors,
                                      buildDefaultDragHandles:
                                          widget.buildDefaultDragHandles,
                                      iconSize: widget.iconSize,
                                      iconBackgroundWidth:
                                          widget.iconBackgroundWidth,
                                      iconBackgroundHeight:
                                          widget.iconBackgroundHeight,
                                      iconBackgroundIsCircular:
                                          widget.iconBackgroundIsCircular,
                                      showMainBlob: widget.showMainBlob,
                                      isShow990: widget.isShow990,
                                      iconBackgroundAnimated:
                                          widget.iconBackgroundAnimated,
                                      iconBackgroundWobble:
                                          widget.iconBackgroundAnimated
                                              ? wobbleVal
                                              : widget.iconBackgroundWobble,
                                      iconBackgroundExpansion:
                                          widget.iconBackgroundAnimated
                                              ? _expansionController.value
                                              : widget.iconBackgroundExpansion,
                                      iconBackgroundVelocity:
                                          widget.iconBackgroundAnimated
                                              ? (_isDragging ? _velocity : 0)
                                              : widget.iconBackgroundVelocity),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: widget.padding,
                            child: _buildScrollableList(
                              isVertical: isVertical,
                              safeIndex: safeIndex,
                              style: style,
                              cellSize: cellSize,
                              gapBetweenIconAndLabel:
                                  widget.gapBetweenIconAndLabel,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );

          return navBar;
        },
      ),
    );
  }

  @override
  void didUpdateWidget(covariant LiquidBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.animationDuration != widget.animationDuration) {
      _snapController.duration = widget.animationDuration;
    }

    if (oldWidget.currentIndex != widget.currentIndex && !_isDragging) {
      if (_snapTarget == widget.currentIndex.toDouble()) {
        return;
      }
      _animateTo(widget.currentIndex);
    }

    // Handle controller changes
    if (oldWidget.controller != widget.controller) {
      // No manual listener needed - controller is used in AnimatedBuilder
    }
  }

  @override
  void dispose() {
    _removeSnapListener();
    _expansionController.dispose();
    _snapController.dispose();
    _wobbleController.dispose();
    _dragWobbleController.dispose();
    _visualController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _dragPosition = widget.currentIndex.toDouble();

    _expansionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _snapController =
        AnimationController(vsync: this, duration: widget.animationDuration);
    _wobbleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _dragWobbleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _visualController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _visualController.addListener(_updateVisualValues);
  }

  void _animateTo(int index) {
    final clampedIndex = index.clamp(0, widget.items.length - 1);
    final target = clampedIndex.toDouble();
    _removeSnapListener();

    if (_dragPosition == target) {
      _wobbleController.forward(from: 0);
      return;
    }

    _snapController.stop();
    _wobbleController.stop();
    _snapTarget = target;

    final beginPosition = _dragPosition;
    final beginScroll =
        _scrollController.hasClients ? _scrollController.offset : 0.0;
    final targetScroll = _getScrollTarget(clampedIndex);

    final animation = Tween<double>(begin: beginPosition, end: target).animate(
      CurvedAnimation(parent: _snapController, curve: widget.curve),
    );

    _currentAnimation = animation;

    void listener() {
      if (_currentAnimation == animation && mounted) {
        final progress = _snapController.value;
        setState(() {
          _dragPosition = animation.value;
          if (_scrollController.hasClients &&
              widget.items.length > _maxItemDisplayed) {
            final currentScroll =
                lerpDouble(beginScroll, targetScroll, progress) ?? beginScroll;
            _scrollController.jumpTo(currentScroll.clamp(
              0.0,
              _scrollController.position.maxScrollExtent,
            ));
          }
        });
      }
    }

    _snapListener = listener;
    animation.addListener(listener);
    _snapController.addStatusListener(_snapStatusListener);
    _snapController.forward(from: 0);
  }

  Widget _buildBadge(int index) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: widget.badgeColor,
        shape: BoxShape.circle,
      ),
      constraints: const BoxConstraints(
        minWidth: 16,
        minHeight: 16,
      ),
      child: Center(
        child: Text(
          '${widget.badges![index]}',
          style: widget.badgeTextStyle ??
              TextStyle(
                color: widget.badgeTextColor,
                fontSize: 8,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
        ),
      ),
    );
  }

  Widget _buildItemContent({
    required bool isVertical,
    required bool isSelected,
    required Widget iconWidget,
    required int index,
    required LiquidNavStyle style,
    required LiquidNavItem item,
    final double? gapBetweenIconAndLabel = 2,
  }) {
    if (isVertical) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              iconWidget,
              if (_showBadge(index))
                Positioned(
                  right: -6,
                  top: -6,
                  child: _buildBadge(index),
                ),
            ],
          ),
          if (gapBetweenIconAndLabel != null)
            SizedBox(width: gapBetweenIconAndLabel),
          if (style.showLabel && (item.label?.isNotEmpty ?? false))
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                item.label!,
                style: TextStyle(
                  fontSize: 9,
                  color: isSelected ? item.colorSelected : item.colorUnselected,
                ),
              ),
            ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Center(child: iconWidget),
            if (_showBadge(index))
              Positioned(
                right: -6,
                top: -6,
                child: _buildBadge(index),
              ),
          ],
        ),
        if (gapBetweenIconAndLabel != null)
          SizedBox(height: gapBetweenIconAndLabel),
        if (style.showLabel && (item.label?.isNotEmpty ?? false))
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              item.label!,
              style: TextStyle(
                fontSize: 9,
                color: isSelected ? item.colorSelected : item.colorUnselected,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildScrollableList({
    required bool isVertical,
    required int safeIndex,
    required LiquidNavStyle style,
    required double cellSize,
    required double? gapBetweenIconAndLabel,
  }) {
    final overflow = widget.items.length > _maxItemDisplayed;
    final pad = overflow ? cellSize / 2 : 0.0;
    final padding = isVertical
        ? EdgeInsets.symmetric(vertical: pad)
        : EdgeInsets.symmetric(horizontal: pad);

    Widget Function(BuildContext, int) itemBuilder = (context, index) {
      final item = widget.items[index];
      final distance = (index - _dragPosition).abs();
      final isSelected = index == safeIndex;

      final iconColor = widget.items[index].colorIconNavBar ??
          Color.lerp(
            style.inactiveIconColor,
            style.activeIconColor,
            (1.0 - distance).clamp(0.0, 1.0),
          );

      Widget iconWidget;
      switch (item.iconType) {
        case LiquidIconType.image:
          final imagePath = isSelected
              ? (item.activeImagePath ?? item.imagePath)
              : (item.inactiveImagePath ?? item.imagePath);
          iconWidget = imagePath != null
              ? Image.asset(
                  imagePath,
                  width: widget.iconSize,
                  height: widget.iconSize,
                  color: iconColor,
                )
              : const SizedBox.shrink();
          break;
        case LiquidIconType.iconData:
          final iconData = isSelected
              ? (widget.activeIcon?.call(item) ?? item.activeIcon ?? item.icon)
              : (widget.inactiveIcon?.call(item) ??
                  item.inactiveIcon ??
                  item.icon);
          iconWidget = Icon(
            iconData,
            size: widget.iconSize,
            color: iconColor,
          );
          break;
        case LiquidIconType.widget:
          iconWidget = item.customWidget ?? const SizedBox.shrink();
          break;
      }

      final itemConstraints = isVertical
          ? BoxConstraints.tightFor(height: cellSize)
          : BoxConstraints.tightFor(width: cellSize);

      return ConstrainedBox(
        key: ValueKey('nav_item_$index'),
        constraints: itemConstraints,
        child: GestureDetector(
          onTap: _isTapEnabled ? () => _onTapItem(index) : null,
          behavior: HitTestBehavior.opaque,
          child: _buildItemContent(
            isVertical: isVertical,
            isSelected: isSelected,
            iconWidget: iconWidget,
            index: index,
            style: style,
            item: item,
            gapBetweenIconAndLabel: widget.gapBetweenIconAndLabel,
          ),
        ),
      );
    };

    final onReorder = widget.onReorder;
    final physics = _isDragEnabled
        ? const NeverScrollableScrollPhysics()
        : const ClampingScrollPhysics();

    // Only use ReorderableListView if reorder is enabled AND onReorder is provided
    if (onReorder != null && _isReorderEnabled) {
      return ReorderableListView.builder(
        buildDefaultDragHandles: widget.buildDefaultDragHandles,
        scrollController: _scrollController,
        padding: padding,
        scrollDirection: widget.scrollDirection,
        physics: physics,
        proxyDecorator: widget.proxyDecorator ??
            (child, index, animation) => ScaleTransition(
                  scale: animation.drive(Tween(begin: 1.0, end: 1.5)),
                  child: child,
                ),
        itemCount: widget.items.length,
        onReorder: onReorder,
        onReorderStart: (_) => setState(() => _isReordering = true),
        onReorderEnd: (_) => setState(() => _isReordering = false),
        itemBuilder: itemBuilder,
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: padding,
      itemCount: widget.items.length,
      scrollDirection: widget.scrollDirection,
      physics: physics,
      itemBuilder: itemBuilder,
    );
  }

  double _getScrollTarget(int index) {
    if (!_scrollController.hasClients) return 0;
    if (widget.items.length <= _maxItemDisplayed) return 0;
    final viewport = _scrollController.position.viewportDimension;
    final cellSize = viewport / _maxItemDisplayed;
    final maxScroll = _scrollController.position.maxScrollExtent;
    return (cellSize * index - (viewport - cellSize) / 2).clamp(0.0, maxScroll);
  }

  double _horizontalPadding(EdgeInsetsGeometry geometry) {
    final resolved = geometry.resolve(Directionality.of(context));
    return resolved.left + resolved.right;
  }

  void _onTapItem(int index) {
    _selectIndex(index);
    _animateTo(index);
  }

  void _removeSnapListener() {
    final listener = _snapListener;
    final animation = _currentAnimation;
    if (listener != null && animation != null) {
      animation.removeListener(listener);
    }
    _snapListener = null;
    _snapController.removeStatusListener(_snapStatusListener);
  }

  void _selectIndex(int index) {
    widget.onTap?.call(index);
    widget.onChanged?.call(index);
  }

  bool _showBadge(int index) {
    final badges = widget.badges;
    if (badges == null || !badges.containsKey(index)) return false;
    return (badges[index] ?? 0) > 0;
  }

  void _snapStatusListener(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _removeSnapListener();
    _snapTarget = null;
    if (mounted) {
      _wobbleController.forward(from: 0);
    }
  }

  void _updateVisualValues() {
    if (!mounted) return;
    setState(() {
      _animatedShadowOffset = lerpDouble(
            _animatedShadowOffset,
            _targetShadowOffset ?? widget.shadowOffset,
            _visualController.value,
          ) ??
          (_targetShadowOffset ?? widget.shadowOffset);
      _animatedShadowAlpha = lerpDouble(
            _animatedShadowAlpha,
            _targetShadowAlpha ?? widget.shadowAlpha,
            _visualController.value,
          ) ??
          (_targetShadowAlpha ?? widget.shadowAlpha);
      _animatedShadowBlurSigma = lerpDouble(
            _animatedShadowBlurSigma,
            _targetShadowBlurSigma ?? widget.shadowBlurSigma,
            _visualController.value,
          ) ??
          (_targetShadowBlurSigma ?? widget.shadowBlurSigma);
      _animatedBorderAlpha = lerpDouble(
            _animatedBorderAlpha,
            _targetBorderAlpha ?? widget.borderAlpha,
            _visualController.value,
          ) ??
          (_targetBorderAlpha ?? widget.borderAlpha);
      _animatedBorderWidth = lerpDouble(
            _animatedBorderWidth,
            _targetBorderWidth ?? widget.borderWidth,
            _visualController.value,
          ) ??
          (_targetBorderWidth ?? widget.borderWidth);
      _animatedGradientSurfaceAlpha = lerpDouble(
            _animatedGradientSurfaceAlpha,
            _targetGradientSurfaceAlpha ?? widget.gradientSurfaceAlpha,
            _visualController.value,
          ) ??
          (_targetGradientSurfaceAlpha ?? widget.gradientSurfaceAlpha);
      _animatedGradientPrimaryAlpha1 = lerpDouble(
            _animatedGradientPrimaryAlpha1,
            _targetGradientPrimaryAlpha1 ?? widget.gradientPrimaryAlpha1,
            _visualController.value,
          ) ??
          (_targetGradientPrimaryAlpha1 ?? widget.gradientPrimaryAlpha1);
      _animatedGradientPrimaryAlpha2 = lerpDouble(
            _animatedGradientPrimaryAlpha2,
            _targetGradientPrimaryAlpha2 ?? widget.gradientPrimaryAlpha2,
            _visualController.value,
          ) ??
          (_targetGradientPrimaryAlpha2 ?? widget.gradientPrimaryAlpha2);
      _animatedDragWaveHeightMultiplier = lerpDouble(
            _animatedDragWaveHeightMultiplier,
            _targetDragWaveHeightMultiplier ?? widget.dragWaveHeightMultiplier,
            _visualController.value,
          ) ??
          (_targetDragWaveHeightMultiplier ?? widget.dragWaveHeightMultiplier);
      _animatedDragWavePositionMultiplier = lerpDouble(
            _animatedDragWavePositionMultiplier,
            _targetDragWavePositionMultiplier ??
                widget.dragWavePositionMultiplier,
            _visualController.value,
          ) ??
          (_targetDragWavePositionMultiplier ??
              widget.dragWavePositionMultiplier);
      _animatedBlobWobbleInfluenceOnWidth = lerpDouble(
            _animatedBlobWobbleInfluenceOnWidth,
            _targetBlobWobbleInfluenceOnWidth ??
                widget.blobWobbleInfluenceOnWidth,
            _visualController.value,
          ) ??
          (_targetBlobWobbleInfluenceOnWidth ??
              widget.blobWobbleInfluenceOnWidth);
      _animatedBlobWobbleInfluenceOnHeight = lerpDouble(
            _animatedBlobWobbleInfluenceOnHeight,
            _targetBlobWobbleInfluenceOnHeight ??
                widget.blobWobbleInfluenceOnHeight,
            _visualController.value,
          ) ??
          (_targetBlobWobbleInfluenceOnHeight ??
              widget.blobWobbleInfluenceOnHeight);
    });
  }
}
