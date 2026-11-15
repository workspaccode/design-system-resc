import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'animate_types.dart';

class AppAnimateConfig {
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final bool loop;
  final bool reverse;
  final double begin;
  final double end;
  final double beginX;
  final double beginY;
  final double endX;
  final double endY;

  const AppAnimateConfig({
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.loop = false,
    this.reverse = false,
    this.begin = 0.0,
    this.end = 1.0,
    this.beginX = -30,
    this.beginY = -30,
    this.endX = 0,
    this.endY = 0,
  });

  const AppAnimateConfig.stagger({
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.loop = false,
    this.reverse = false,
    this.begin = 0.0,
    this.end = 1.0,
    this.beginX = 0,
    this.beginY = 20,
    this.endX = 0,
    this.endY = 0,
  });

  const AppAnimateConfig.shimmer({
    this.duration = const Duration(milliseconds: 1200),
    this.delay = Duration.zero,
    this.curve = Curves.easeInOut,
    this.loop = true,
    this.reverse = true,
    this.begin = -1.0,
    this.end = 2.0,
    this.beginX = -200,
    this.beginY = 0,
    this.endX = 200,
    this.endY = 0,
  });

  const AppAnimateConfig.blur({
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.loop = false,
    this.reverse = false,
    this.begin = 10.0,
    this.end = 0.0,
    this.beginX = 0,
    this.beginY = 0,
    this.endX = 0,
    this.endY = 0,
  });
}

class AppAnimate extends StatefulWidget {
  final AppAnimateType type;
  final AppAnimateConfig? config;
  final Widget child;
  final VoidCallback? onPlay;
  final VoidCallback? onComplete;
  final bool autoplay;
  final int loopCount;

  const AppAnimate({
    super.key,
    required this.type,
    this.config,
    required this.child,
    this.onPlay,
    this.onComplete,
    this.autoplay = true,
    this.loopCount = 0,
  });

  @override
  State<AppAnimate> createState() => _AppAnimateState();
}

class _AppAnimateState extends State<AppAnimate> {
  @override
  Widget build(BuildContext context) {
    final c = widget.config ?? const AppAnimateConfig();
    final anim = widget.child.animate(
      onPlay: (controller) {
        if (widget.loopCount > 0) {
          _playWithCount(controller, widget.loopCount, c);
        } else if (c.loop) {
          controller.repeat(reverse: c.reverse);
        }
        widget.onPlay?.call();
      },
      onComplete: (_) => widget.onComplete?.call(),
    );

    return _buildEffects(anim, c);
  }

  void _playWithCount(AnimationController controller, int count, AppAnimateConfig c) {
    var played = 0;
    void listenerx(AnimationStatus status) {
      if (controller.status == AnimationStatus.completed) {
        played++;
        if (played >= count) {
          controller.removeStatusListener(listenerx);
        } else {
          controller.reset();
          controller.forward();
        }
      }
    }
    controller.addStatusListener(listenerx);
    controller.forward();
  }

  Widget _buildEffects(Animate anim, AppAnimateConfig c) {
    final d = c.duration;
    final del = c.delay;
    final fastD = Duration(milliseconds: d.inMilliseconds ~/ 2);
    final slowD = Duration(milliseconds: d.inMilliseconds * 2);

    switch (widget.type) {
      // ── Fade ──
      case AppAnimateType.fadeIn:
        return anim.fadeIn(duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeOut:
        return anim.fadeOut(duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeInDown:
        return anim.fadeIn(duration: d, delay: del).slideY(begin: -0.08, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeInUp:
        return anim.fadeIn(duration: d, delay: del).slideY(begin: 0.08, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeInLeft:
        return anim.fadeIn(duration: d, delay: del).slideX(begin: -0.08, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeInRight:
        return anim.fadeIn(duration: d, delay: del).slideX(begin: 0.08, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeInDownLeft:
        return anim.fadeIn(duration: d, delay: del).slideX(begin: -0.08, end: 0, duration: d, delay: del).slideY(begin: -0.08, end: 0, duration: d, delay: del);
      case AppAnimateType.fadeInDownRight:
        return anim.fadeIn(duration: d, delay: del).slideX(begin: 0.08, end: 0, duration: d, delay: del).slideY(begin: -0.08, end: 0, duration: d, delay: del);
      case AppAnimateType.fadeInUpLeft:
        return anim.fadeIn(duration: d, delay: del).slideX(begin: -0.08, end: 0, duration: d, delay: del).slideY(begin: 0.08, end: 0, duration: d, delay: del);
      case AppAnimateType.fadeInUpRight:
        return anim.fadeIn(duration: d, delay: del).slideX(begin: 0.08, end: 0, duration: d, delay: del).slideY(begin: 0.08, end: 0, duration: d, delay: del);
      case AppAnimateType.fadeOutDownLeft:
        return anim.fadeOut(duration: d, delay: del).slideX(begin: 0, end: -0.08, duration: d, delay: del).slideY(begin: 0, end: 0.08, duration: d, delay: del);
      case AppAnimateType.fadeOutDownRight:
        return anim.fadeOut(duration: d, delay: del).slideX(begin: 0, end: 0.08, duration: d, delay: del).slideY(begin: 0, end: 0.08, duration: d, delay: del);
      case AppAnimateType.fadeOutUpLeft:
        return anim.fadeOut(duration: d, delay: del).slideX(begin: 0, end: -0.08, duration: d, delay: del).slideY(begin: 0, end: -0.08, duration: d, delay: del);
      case AppAnimateType.fadeOutUpRight:
        return anim.fadeOut(duration: d, delay: del).slideX(begin: 0, end: 0.08, duration: d, delay: del).slideY(begin: 0, end: -0.08, duration: d, delay: del);
      case AppAnimateType.fadeInFast:
        return anim.fadeIn(duration: fastD, delay: del, curve: c.curve);
      case AppAnimateType.fadeInSlow:
        return anim.fadeIn(duration: slowD, delay: del, curve: c.curve);
      case AppAnimateType.fadeOutFast:
        return anim.fadeOut(duration: fastD, delay: del, curve: c.curve);
      case AppAnimateType.fadeOutSlow:
        return anim.fadeOut(duration: slowD, delay: del, curve: c.curve);
      case AppAnimateType.fadeInSoft:
        return anim.fadeIn(begin: 0.3, duration: d, delay: del, curve: Curves.easeOut);
      case AppAnimateType.fadeInStrong:
        return anim.fadeIn(begin: 0, duration: d, delay: del, curve: Curves.easeIn);
      case AppAnimateType.fadeInBounce:
        return anim.fadeIn(duration: d, delay: del, curve: Curves.elasticOut);

      // ── Slide ──
      case AppAnimateType.slideInUp:
        return anim.slideY(begin: 0.3, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideInDown:
        return anim.slideY(begin: -0.3, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideInLeft:
        return anim.slideX(begin: -0.3, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideInRight:
        return anim.slideX(begin: 0.3, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideOutUp:
        return anim.slideY(begin: 0, end: -0.3, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideOutDown:
        return anim.slideY(begin: 0, end: 0.3, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideOutLeft:
        return anim.slideX(begin: 0, end: -0.3, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideOutRight:
        return anim.slideX(begin: 0, end: 0.3, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideInUpLeft:
        return anim.slideX(begin: -0.3, end: 0, duration: d, delay: del).slideY(begin: 0.3, end: 0, duration: d, delay: del);
      case AppAnimateType.slideInUpRight:
        return anim.slideX(begin: 0.3, end: 0, duration: d, delay: del).slideY(begin: 0.3, end: 0, duration: d, delay: del);
      case AppAnimateType.slideInDownLeft:
        return anim.slideX(begin: -0.3, end: 0, duration: d, delay: del).slideY(begin: -0.3, end: 0, duration: d, delay: del);
      case AppAnimateType.slideInDownRight:
        return anim.slideX(begin: 0.3, end: 0, duration: d, delay: del).slideY(begin: -0.3, end: 0, duration: d, delay: del);
      case AppAnimateType.slideOutUpLeft:
        return anim.slideX(begin: 0, end: -0.3, duration: d, delay: del).slideY(begin: 0, end: -0.3, duration: d, delay: del);
      case AppAnimateType.slideOutUpRight:
        return anim.slideX(begin: 0, end: 0.3, duration: d, delay: del).slideY(begin: 0, end: -0.3, duration: d, delay: del);
      case AppAnimateType.slideOutDownLeft:
        return anim.slideX(begin: 0, end: -0.3, duration: d, delay: del).slideY(begin: 0, end: 0.3, duration: d, delay: del);
      case AppAnimateType.slideOutDownRight:
        return anim.slideX(begin: 0, end: 0.3, duration: d, delay: del).slideY(begin: 0, end: 0.3, duration: d, delay: del);
      case AppAnimateType.slideInUpFast:
        return anim.slideY(begin: 0.3, end: 0, duration: fastD, delay: del, curve: c.curve);
      case AppAnimateType.slideInUpSlow:
        return anim.slideY(begin: 0.3, end: 0, duration: slowD, delay: del, curve: c.curve);
      case AppAnimateType.slideInUpStrong:
        return anim.slideY(begin: 0.6, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideInUpSoft:
        return anim.slideY(begin: 0.1, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideInBounce:
        return anim.slideY(begin: 0.3, end: 0, duration: d, delay: del, curve: Curves.elasticOut);

      // ── Zoom / Scale ──
      case AppAnimateType.zoomIn:
        return anim.scaleXY(begin: 0.3, end: 1, duration: d, delay: del, curve: c.curve).fadeIn(duration: d, delay: del, curve: c.curve);
      case AppAnimateType.zoomOut:
        return anim.scaleXY(begin: 1.3, end: 0, duration: d, delay: del, curve: c.curve).fadeOut(duration: d, delay: del, curve: c.curve);
      case AppAnimateType.zoomInDown:
        return anim.scaleXY(begin: 0.3, end: 1, duration: d, delay: del).slideY(begin: -0.2, end: 0, duration: d, delay: del).fadeIn(duration: d, delay: del);
      case AppAnimateType.zoomInUp:
        return anim.scaleXY(begin: 0.3, end: 1, duration: d, delay: del).slideY(begin: 0.2, end: 0, duration: d, delay: del).fadeIn(duration: d, delay: del);
      case AppAnimateType.zoomInLeft:
        return anim.scaleXY(begin: 0.3, end: 1, duration: d, delay: del).slideX(begin: -0.2, end: 0, duration: d, delay: del).fadeIn(duration: d, delay: del);
      case AppAnimateType.zoomInRight:
        return anim.scaleXY(begin: 0.3, end: 1, duration: d, delay: del).slideX(begin: 0.2, end: 0, duration: d, delay: del).fadeIn(duration: d, delay: del);
      case AppAnimateType.zoomOutDown:
        return anim.scaleXY(begin: 1, end: 0, duration: d, delay: del).slideY(begin: 0, end: 0.2, duration: d, delay: del).fadeOut(duration: d, delay: del);
      case AppAnimateType.zoomOutUp:
        return anim.scaleXY(begin: 1, end: 0, duration: d, delay: del).slideY(begin: 0, end: -0.2, duration: d, delay: del).fadeOut(duration: d, delay: del);
      case AppAnimateType.zoomOutLeft:
        return anim.scaleXY(begin: 1, end: 0, duration: d, delay: del).slideX(begin: 0, end: -0.2, duration: d, delay: del).fadeOut(duration: d, delay: del);
      case AppAnimateType.zoomOutRight:
        return anim.scaleXY(begin: 1, end: 0, duration: d, delay: del).slideX(begin: 0, end: 0.2, duration: d, delay: del).fadeOut(duration: d, delay: del);
      case AppAnimateType.zoomInFast:
        return anim.scaleXY(begin: 0.3, end: 1, duration: fastD, delay: del).fadeIn(duration: fastD, delay: del);
      case AppAnimateType.zoomInSlow:
        return anim.scaleXY(begin: 0.3, end: 1, duration: slowD, delay: del).fadeIn(duration: slowD, delay: del);
      case AppAnimateType.zoomInBounce:
        return anim.scaleXY(begin: 0.3, end: 1, duration: d, delay: del, curve: Curves.elasticOut).fadeIn(duration: d, curve: Curves.easeOut);

      case AppAnimateType.scaleIn:
        return anim.scaleXY(begin: 0, end: 1, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.scaleOut:
        return anim.scaleXY(begin: 1, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.scaleXIn:
        return anim.scaleX(begin: 0, end: 1, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.scaleXOut:
        return anim.scaleX(begin: 1, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.scaleYIn:
        return anim.scaleY(begin: 0, end: 1, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.scaleYOut:
        return anim.scaleY(begin: 1, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.scaleInFast:
        return anim.scaleXY(begin: 0, end: 1, duration: fastD, delay: del, curve: c.curve);
      case AppAnimateType.scaleInSlow:
        return anim.scaleXY(begin: 0, end: 1, duration: slowD, delay: del, curve: c.curve);
      case AppAnimateType.scaleInBounce:
        return anim.scaleXY(begin: 0, end: 1, duration: d, delay: del, curve: Curves.elasticOut);
      case AppAnimateType.scaleInRotate:
        return anim.scaleXY(begin: 0, end: 1, duration: d, delay: del).rotate(begin: -0.2, end: 0, duration: d, delay: del);

      case AppAnimateType.pulse:
        return anim.scaleXY(begin: 1, end: 1.08, duration: d, delay: del, curve: Curves.easeInOut);
      case AppAnimateType.bounce:
        return anim.scaleXY(begin: 0, end: 1.15, duration: d, delay: del, curve: Curves.elasticOut);
      case AppAnimateType.pulseSoft:
        return anim.scaleXY(begin: 1, end: 1.04, duration: slowD, delay: del, curve: Curves.easeInOut);
      case AppAnimateType.pulseHard:
        return anim.scaleXY(begin: 1, end: 1.2, duration: d, delay: del, curve: Curves.easeInOut);
      case AppAnimateType.pulseFast:
        return anim.scaleXY(begin: 1, end: 1.08, duration: Duration(milliseconds: 300), delay: del, curve: Curves.easeInOut);
      case AppAnimateType.pulseSlow:
        return anim.scaleXY(begin: 1, end: 1.08, duration: slowD, delay: del, curve: Curves.easeInOut);
      case AppAnimateType.pulseRotate:
        return anim.scaleXY(begin: 1, end: 1.08, duration: d, delay: del).rotate(begin: 0, end: 0.03, duration: d, delay: del);
      case AppAnimateType.pulseX:
        return anim.scaleX(begin: 1, end: 1.08, duration: d, delay: del, curve: Curves.easeInOut);
      case AppAnimateType.pulseY:
        return anim.scaleY(begin: 1, end: 1.08, duration: d, delay: del, curve: Curves.easeInOut);
      case AppAnimateType.pulseBorder:
        return anim.custom(
          duration: d, delay: del, curve: Curves.easeInOut,
          builder: (context, value, child) => Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.white.withValues(alpha: 0.3 * value))),
            child: child,
          ),
        );
      case AppAnimateType.pulseGlow:
        return anim.boxShadow(
          duration: d, delay: del, curve: Curves.easeInOut,
          begin: BoxShadow(color: Colors.transparent, blurRadius: 0),
          end: BoxShadow(color: Colors.white.withValues(alpha: 0.4), blurRadius: 15, spreadRadius: 1),
        );

      // ── Rotate / Flip ──
      case AppAnimateType.rotateIn:
        return anim.rotate(begin: -0.25, end: 0, duration: d, delay: del, curve: c.curve).fadeIn(duration: d, delay: del, curve: c.curve);
      case AppAnimateType.rotateOut:
        return anim.rotate(begin: 0, end: 0.25, duration: d, delay: del, curve: c.curve).fadeOut(duration: d, delay: del, curve: c.curve);
      case AppAnimateType.rotateInFast:
        return anim.rotate(begin: -0.25, end: 0, duration: fastD, delay: del).fadeIn(duration: fastD, delay: del);
      case AppAnimateType.rotateInSlow:
        return anim.rotate(begin: -0.25, end: 0, duration: slowD, delay: del).fadeIn(duration: slowD, delay: del);
      case AppAnimateType.rotateInBounce:
        return anim.rotate(begin: -0.25, end: 0, duration: d, delay: del, curve: Curves.elasticOut).fadeIn(duration: d, delay: del);
      case AppAnimateType.rotateInDownLeft:
        return anim.rotate(begin: -0.25, end: 0, duration: d, delay: del).scaleXY(begin: 0.8, end: 1, duration: d, delay: del).fadeIn(duration: d, delay: del);
      case AppAnimateType.rotateInDownRight:
        return anim.rotate(begin: 0.25, end: 0, duration: d, delay: del).scaleXY(begin: 0.8, end: 1, duration: d, delay: del).fadeIn(duration: d, delay: del);
      case AppAnimateType.rotateInUpLeft:
        return anim.rotate(begin: -0.25, end: 0, duration: d, delay: del).scaleXY(begin: 0.8, end: 1, duration: d, delay: del).fadeIn(duration: d, delay: del);
      case AppAnimateType.rotateInUpRight:
        return anim.rotate(begin: 0.25, end: 0, duration: d, delay: del).scaleXY(begin: 0.8, end: 1, duration: d, delay: del).fadeIn(duration: d, delay: del);
      case AppAnimateType.rotateOutDownLeft:
        return anim.rotate(begin: 0, end: -0.25, duration: d, delay: del).scaleXY(begin: 1, end: 0.8, duration: d, delay: del).fadeOut(duration: d, delay: del);
      case AppAnimateType.rotateOutDownRight:
        return anim.rotate(begin: 0, end: 0.25, duration: d, delay: del).scaleXY(begin: 1, end: 0.8, duration: d, delay: del).fadeOut(duration: d, delay: del);
      case AppAnimateType.rotateOutUpLeft:
        return anim.rotate(begin: 0, end: -0.25, duration: d, delay: del).scaleXY(begin: 1, end: 0.8, duration: d, delay: del).fadeOut(duration: d, delay: del);
      case AppAnimateType.rotateOutUpRight:
        return anim.rotate(begin: 0, end: 0.25, duration: d, delay: del).scaleXY(begin: 1, end: 0.8, duration: d, delay: del).fadeOut(duration: d, delay: del);
      case AppAnimateType.flipInX:
        return anim.scaleX(begin: 0, end: 1, duration: d, delay: del, curve: c.curve).fadeIn(duration: d ~/ 2, curve: c.curve);
      case AppAnimateType.flipInY:
        return anim.scaleY(begin: 0, end: 1, duration: d, delay: del, curve: c.curve).fadeIn(duration: d ~/ 2, curve: c.curve);
      case AppAnimateType.flipOutX:
        return anim.scaleX(begin: 1, end: 0, duration: d, delay: del, curve: c.curve).fadeOut(duration: d ~/ 2, curve: c.curve);
      case AppAnimateType.flipOutY:
        return anim.scaleY(begin: 1, end: 0, duration: d, delay: del, curve: c.curve).fadeOut(duration: d ~/ 2, curve: c.curve);

      // ── Special ──
      case AppAnimateType.shimmer:
        return anim.shimmer(duration: d, delay: del);
      case AppAnimateType.blur:
        return anim.blurXY(begin: c.begin, end: c.end, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.glow:
        return anim.boxShadow(
          duration: d, delay: del, curve: c.curve,
          begin: BoxShadow(color: Colors.transparent, blurRadius: 0),
          end: BoxShadow(color: Colors.white.withValues(alpha: 0.5), blurRadius: 20, spreadRadius: 2),
        );
      case AppAnimateType.shake:
        return anim.shake(duration: d, delay: del);
      case AppAnimateType.jello:
        return anim.scaleX(begin: 1, end: 1.15, duration: d * 0.25, curve: Curves.easeOut)
            .then().scaleX(begin: 1.15, end: 0.9, duration: d * 0.25, curve: Curves.easeInOut)
            .then().scaleX(begin: 0.9, end: 1.05, duration: d * 0.25, curve: Curves.easeInOut)
            .then().scaleX(begin: 1.05, end: 1, duration: d * 0.25, curve: Curves.easeIn);
      case AppAnimateType.swing:
        return anim.rotate(begin: 0, end: 0.15, duration: d * 0.3, curve: Curves.easeOut)
            .then().rotate(begin: 0.15, end: -0.1, duration: d * 0.3, curve: Curves.easeInOut)
            .then().rotate(begin: -0.1, end: 0.05, duration: d * 0.2, curve: Curves.easeInOut)
            .then().rotate(begin: 0.05, end: 0, duration: d * 0.2, curve: Curves.easeIn);
      case AppAnimateType.wobble:
        return anim.slideX(begin: 0, end: 0.06, duration: d * 0.2).rotate(begin: 0, end: -0.03, duration: d * 0.2)
            .then().slideX(begin: 0.06, end: -0.04, duration: d * 0.2).rotate(begin: -0.03, end: 0.02, duration: d * 0.2)
            .then().slideX(begin: -0.04, end: 0.02, duration: d * 0.2).rotate(begin: 0.02, end: -0.01, duration: d * 0.2)
            .then().slideX(begin: 0.02, end: 0, duration: d * 0.2).rotate(begin: -0.01, end: 0, duration: d * 0.2);
      case AppAnimateType.flash:
        return anim.fadeIn(duration: d * 0.25, curve: Curves.easeOut)
            .then().fadeOut(duration: d * 0.25, curve: Curves.easeIn)
            .then().fadeIn(duration: d * 0.25, curve: Curves.easeOut)
            .then().fadeOut(duration: d * 0.25, curve: Curves.easeIn);
      case AppAnimateType.rubberBand:
        return anim.scaleX(begin: 1, end: 1.25, duration: d * 0.3, curve: Curves.easeOut).scaleY(begin: 1, end: 0.75, duration: d * 0.3, curve: Curves.easeOut)
            .then().scaleX(begin: 1.25, end: 0.9, duration: d * 0.3, curve: Curves.easeInOut).scaleY(begin: 0.75, end: 1.1, duration: d * 0.3, curve: Curves.easeInOut)
            .then().scaleX(begin: 0.9, end: 1, duration: d * 0.2, curve: Curves.easeInOut).scaleY(begin: 1.1, end: 1, duration: d * 0.2, curve: Curves.easeInOut);
      case AppAnimateType.heartbeat:
        return anim.scaleXY(begin: 1, end: 1.15, duration: d * 0.3, curve: Curves.easeOut)
            .then().scaleXY(begin: 1.15, end: 1, duration: d * 0.3, curve: Curves.easeIn)
            .then().scaleXY(begin: 1, end: 1.08, duration: d * 0.2, curve: Curves.easeOut)
            .then().scaleXY(begin: 1.08, end: 1, duration: d * 0.2, curve: Curves.easeIn);
      case AppAnimateType.glowPulse:
        return anim.boxShadow(
          duration: d, delay: del, curve: Curves.easeInOut,
          begin: BoxShadow(color: Colors.transparent, blurRadius: 0),
          end: BoxShadow(color: Colors.white.withValues(alpha: 0.6), blurRadius: 25, spreadRadius: 3),
        );
      case AppAnimateType.neonPulse:
        return anim.boxShadow(
          duration: d, delay: del, curve: Curves.easeInOut,
          begin: BoxShadow(color: Colors.cyan.withValues(alpha: 0), blurRadius: 0),
          end: BoxShadow(color: Colors.cyan.withValues(alpha: 0.6), blurRadius: 30, spreadRadius: 5),
        );
      case AppAnimateType.gradientShift:
        return anim.custom(
          duration: d, delay: del,
          builder: (ctx, value, child) => ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Colors.blue, Colors.purple, Colors.pink],
              stops: [value * 0.5, value * 0.7, value],
            ).createShader(bounds),
            child: child,
          ),
        );
      case AppAnimateType.scanLine:
        return anim.custom(
          duration: d, delay: del,
          builder: (ctx, value, child) => ClipRect(
            child: Stack(children: [
              child,
              Positioned(top: value * 200 - 2, left: 0, right: 0, child: Container(height: 4, color: Colors.cyan.withValues(alpha: 0.6))),
            ]),
          ),
        );
      case AppAnimateType.morph:
        return anim.scaleXY(begin: 1, end: 0.85, duration: d * 0.3, curve: Curves.easeOut)
            .then().scaleXY(begin: 0.85, end: 1.1, duration: d * 0.4, curve: Curves.elasticOut)
            .then().scaleXY(begin: 1.1, end: 1, duration: d * 0.3, curve: Curves.easeInOut);
      case AppAnimateType.distort:
        return anim.scaleX(begin: 1, end: 1.2, duration: d * 0.2, curve: Curves.easeOut)
            .scaleY(begin: 1, end: 0.8, duration: d * 0.2, curve: Curves.easeOut)
            .then().scaleX(begin: 1.2, end: 0.9, duration: d * 0.3, curve: Curves.easeInOut)
            .scaleY(begin: 0.8, end: 1.1, duration: d * 0.3, curve: Curves.easeInOut)
            .then().scaleXY(begin: 0.9, end: 1, duration: d * 0.3, curve: Curves.easeOut)
            .scaleY(begin: 1.1, end: 1, duration: d * 0.3, curve: Curves.easeOut);
      case AppAnimateType.wave:
        return anim.slideY(begin: 0, end: -0.05, duration: d * 0.25, curve: Curves.easeOut)
            .then().slideY(begin: -0.05, end: 0.05, duration: d * 0.5, curve: Curves.easeInOut)
            .then().slideY(begin: 0.05, end: 0, duration: d * 0.25, curve: Curves.easeIn);
      case AppAnimateType.rippleExpand:
        return anim.scaleXY(begin: 0.6, end: 1, duration: d, curve: Curves.easeOut).fadeIn(duration: d * 0.6, curve: Curves.easeOut);
      case AppAnimateType.rippleContract:
        return anim.scaleXY(begin: 1, end: 0.6, duration: d, curve: Curves.easeIn).fadeOut(duration: d * 0.6, curve: Curves.easeIn);
      case AppAnimateType.vortex:
        return anim.rotate(begin: -0.5, end: 0, duration: d, curve: Curves.easeOut).scaleXY(begin: 0.3, end: 1, duration: d, curve: Curves.easeOut).fadeIn(duration: d, curve: Curves.easeOut);
      case AppAnimateType.spiral:
        return anim.rotate(begin: -0.3, end: 0, duration: d, curve: Curves.easeOut).scaleXY(begin: 0.5, end: 1, duration: d, curve: Curves.easeOut).fadeIn(duration: d, curve: Curves.easeOut);
      case AppAnimateType.orbit:
        return anim.rotate(begin: 0, end: 1, duration: const Duration(seconds: 3), curve: Curves.linear);
      case AppAnimateType.pendulum:
        return anim.rotate(begin: -0.15, end: 0.15, duration: d, curve: Curves.easeInOut);
      case AppAnimateType.blink:
        return anim.fadeOut(duration: 50.ms, curve: Curves.easeIn)
            .then(delay: 100.ms).fadeIn(duration: 50.ms, curve: Curves.easeOut);
      case AppAnimateType.flicker:
        return anim.fadeOut(duration: 30.ms, curve: Curves.easeIn)
            .then(delay: 200.ms).fadeIn(duration: 30.ms, curve: Curves.easeOut)
            .then(delay: 50.ms).fadeOut(duration: 30.ms, curve: Curves.easeIn)
            .then(delay: 150.ms).fadeIn(duration: 30.ms, curve: Curves.easeOut)
            .then(delay: 100.ms).fadeOut(duration: 30.ms, curve: Curves.easeIn)
            .then(delay: 100.ms).fadeIn(duration: 30.ms, curve: Curves.easeOut);
      case AppAnimateType.confetti:
        return anim.scaleXY(begin: 0.3, end: 1.2, duration: d * 0.4, curve: Curves.elasticOut)
            .then().scaleXY(begin: 1.2, end: 1, duration: d * 0.3, curve: Curves.easeInOut)
            .rotate(begin: 0, end: 0.2, duration: d, curve: Curves.easeOut)
            .fadeIn(duration: d * 0.3, curve: Curves.easeOut);

      // ── Bounce ──
      case AppAnimateType.bounceIn:
        return anim.scaleXY(begin: 0, end: 1.2, duration: d * 0.4, curve: Curves.easeOut)
            .then().scaleXY(begin: 1.2, end: 0.9, duration: d * 0.2, curve: Curves.easeInOut)
            .then().scaleXY(begin: 0.9, end: 1.05, duration: d * 0.2, curve: Curves.easeOut)
            .then().scaleXY(begin: 1.05, end: 1, duration: d * 0.2, curve: Curves.easeInOut).fadeIn(duration: d * 0.5, curve: Curves.easeOut);
      case AppAnimateType.bounceInDown:
        return anim.slideY(begin: -0.5, end: 0, duration: d, curve: Curves.elasticOut).fadeIn(duration: d * 0.4, curve: Curves.easeOut);
      case AppAnimateType.bounceInUp:
        return anim.slideY(begin: 0.5, end: 0, duration: d, curve: Curves.elasticOut).fadeIn(duration: d * 0.4, curve: Curves.easeOut);
      case AppAnimateType.bounceInLeft:
        return anim.slideX(begin: -0.5, end: 0, duration: d, curve: Curves.elasticOut).fadeIn(duration: d * 0.4, curve: Curves.easeOut);
      case AppAnimateType.bounceInRight:
        return anim.slideX(begin: 0.5, end: 0, duration: d, curve: Curves.elasticOut).fadeIn(duration: d * 0.4, curve: Curves.easeOut);
      case AppAnimateType.bounceOut:
        return anim.scaleXY(begin: 1, end: 1.2, duration: d * 0.3, curve: Curves.easeOut)
            .then().scaleXY(begin: 1.2, end: 0, duration: d * 0.5, curve: Curves.easeIn).fadeOut(duration: d * 0.6, curve: Curves.easeIn);
      case AppAnimateType.bounceOutDown:
        return anim.slideY(begin: 0, end: 0.3, duration: d * 0.4, curve: Curves.easeOut)
            .then().slideY(begin: 0.3, end: -0.2, duration: d * 0.2, curve: Curves.easeIn)
            .then().slideY(begin: -0.2, end: 0.5, duration: d * 0.4, curve: Curves.easeIn);
      case AppAnimateType.bounceOutUp:
        return anim.slideY(begin: 0, end: -0.3, duration: d * 0.4, curve: Curves.easeOut)
            .then().slideY(begin: -0.3, end: 0.2, duration: d * 0.2, curve: Curves.easeIn)
            .then().slideY(begin: 0.2, end: -0.5, duration: d * 0.4, curve: Curves.easeIn);
      case AppAnimateType.bounceInDownLeft:
        return anim.slideX(begin: -0.5, end: 0, duration: d, curve: Curves.elasticOut).slideY(begin: -0.5, end: 0, duration: d, curve: Curves.elasticOut).fadeIn(duration: d * 0.4);
      case AppAnimateType.bounceInDownRight:
        return anim.slideX(begin: 0.5, end: 0, duration: d, curve: Curves.elasticOut).slideY(begin: -0.5, end: 0, duration: d, curve: Curves.elasticOut).fadeIn(duration: d * 0.4);
      case AppAnimateType.bounceInUpLeft:
        return anim.slideX(begin: -0.5, end: 0, duration: d, curve: Curves.elasticOut).slideY(begin: 0.5, end: 0, duration: d, curve: Curves.elasticOut).fadeIn(duration: d * 0.4);
      case AppAnimateType.bounceInUpRight:
        return anim.slideX(begin: 0.5, end: 0, duration: d, curve: Curves.elasticOut).slideY(begin: 0.5, end: 0, duration: d, curve: Curves.elasticOut).fadeIn(duration: d * 0.4);
      case AppAnimateType.bounceOutDownLeft:
        return anim.slideX(begin: 0, end: -0.5, duration: d, curve: Curves.easeIn).slideY(begin: 0, end: 0.5, duration: d, curve: Curves.easeIn).fadeOut(duration: d * 0.4);
      case AppAnimateType.bounceOutDownRight:
        return anim.slideX(begin: 0, end: 0.5, duration: d, curve: Curves.easeIn).slideY(begin: 0, end: 0.5, duration: d, curve: Curves.easeIn).fadeOut(duration: d * 0.4);
      case AppAnimateType.bounceOutUpLeft:
        return anim.slideX(begin: 0, end: -0.5, duration: d, curve: Curves.easeIn).slideY(begin: 0, end: -0.5, duration: d, curve: Curves.easeIn).fadeOut(duration: d * 0.4);
      case AppAnimateType.bounceOutUpRight:
        return anim.slideX(begin: 0, end: 0.5, duration: d, curve: Curves.easeIn).slideY(begin: 0, end: -0.5, duration: d, curve: Curves.easeIn).fadeOut(duration: d * 0.4);
      case AppAnimateType.bounceInFade:
        return anim.scaleXY(begin: 0.5, end: 1, duration: d, curve: Curves.elasticOut).fadeIn(duration: d, curve: Curves.easeOut);
      case AppAnimateType.bounceOutFade:
        return anim.scaleXY(begin: 1, end: 0.5, duration: d, curve: Curves.elasticIn).fadeOut(duration: d, curve: Curves.easeIn);

      // ── Elastic ──
      case AppAnimateType.elasticIn:
        return anim.scaleXY(begin: 0, end: 1, duration: d, curve: Curves.elasticOut).fadeIn(duration: d, curve: Curves.easeOut);
      case AppAnimateType.elasticOut:
        return anim.scaleXY(begin: 1, end: 0, duration: d, curve: Curves.elasticIn).fadeOut(duration: d, curve: Curves.easeIn);
      case AppAnimateType.elasticInOut:
        return anim.scaleXY(begin: 0, end: 1.1, duration: d * 0.3, curve: Curves.easeOut)
            .then().scaleXY(begin: 1.1, end: 0.9, duration: d * 0.2, curve: Curves.elasticIn)
            .then().scaleXY(begin: 0.9, end: 1, duration: d * 0.5, curve: Curves.elasticOut);
      case AppAnimateType.elasticInDown:
        return anim.slideY(begin: -0.4, end: 0, duration: d, curve: Curves.elasticOut).fadeIn(duration: d * 0.5, curve: Curves.easeOut);
      case AppAnimateType.elasticInUp:
        return anim.slideY(begin: 0.4, end: 0, duration: d, curve: Curves.elasticOut).fadeIn(duration: d * 0.5, curve: Curves.easeOut);
      case AppAnimateType.elasticInLeft:
        return anim.slideX(begin: -0.4, end: 0, duration: d, curve: Curves.elasticOut).fadeIn(duration: d * 0.5, curve: Curves.easeOut);
      case AppAnimateType.elasticInRight:
        return anim.slideX(begin: 0.4, end: 0, duration: d, curve: Curves.elasticOut).fadeIn(duration: d * 0.5, curve: Curves.easeOut);
      case AppAnimateType.elasticOutDown:
        return anim.slideY(begin: 0, end: 0.4, duration: d, curve: Curves.elasticIn).fadeOut(duration: d * 0.5, curve: Curves.easeIn);
      case AppAnimateType.elasticOutUp:
        return anim.slideY(begin: 0, end: -0.4, duration: d, curve: Curves.elasticIn).fadeOut(duration: d * 0.5, curve: Curves.easeIn);
      case AppAnimateType.elasticOutRight:
        return anim.slideX(begin: 0, end: 0.4, duration: d, curve: Curves.elasticIn).fadeOut(duration: d * 0.5, curve: Curves.easeIn);
      case AppAnimateType.elasticOutLeft:
        return anim.slideX(begin: 0, end: -0.4, duration: d, curve: Curves.elasticIn).fadeOut(duration: d * 0.5, curve: Curves.easeIn);
      case AppAnimateType.elasticInFade:
        return anim.scaleXY(begin: 0, end: 1, duration: d, curve: Curves.elasticOut).fadeIn(duration: d * 0.5, curve: Curves.easeOut);
      case AppAnimateType.elasticOutFade:
        return anim.scaleXY(begin: 1, end: 0, duration: d, curve: Curves.elasticIn).fadeOut(duration: d * 0.5, curve: Curves.easeIn);
      case AppAnimateType.elasticBounce:
        return anim.scaleXY(begin: 0, end: 1.15, duration: d * 0.4, curve: Curves.elasticOut)
            .then().scaleXY(begin: 1.15, end: 0.9, duration: d * 0.2, curve: Curves.easeInOut)
            .then().scaleXY(begin: 0.9, end: 1, duration: d * 0.4, curve: Curves.elasticOut);

      // ── Combo ──
      case AppAnimateType.fadeInScale:
        return anim.fadeIn(duration: d, delay: del, curve: c.curve).scaleXY(begin: 0.8, end: 1, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeInSlide:
        return anim.fadeIn(duration: d, delay: del, curve: c.curve).slideY(begin: 0.06, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeInRotate:
        return anim.fadeIn(duration: d, delay: del, curve: c.curve).rotate(begin: -0.1, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeOutScale:
        return anim.fadeOut(duration: d, delay: del, curve: c.curve).scaleXY(begin: 1, end: 0.8, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeOutSlide:
        return anim.fadeOut(duration: d, delay: del, curve: c.curve).slideY(begin: 0, end: -0.06, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeOutRotate:
        return anim.fadeOut(duration: d, delay: del, curve: c.curve).rotate(begin: 0, end: 0.1, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeInScaleRotate:
        return anim.fadeIn(duration: d, delay: del).scaleXY(begin: 0.8, end: 1, duration: d, delay: del).rotate(begin: -0.1, end: 0, duration: d, delay: del);
      case AppAnimateType.fadeInSlideScale:
        return anim.fadeIn(duration: d, delay: del).slideY(begin: 0.06, end: 0, duration: d, delay: del).scaleXY(begin: 0.9, end: 1, duration: d, delay: del);
      case AppAnimateType.fadeInSlideRotate:
        return anim.fadeIn(duration: d, delay: del).slideY(begin: 0.06, end: 0, duration: d, delay: del).rotate(begin: -0.08, end: 0, duration: d, delay: del);
      case AppAnimateType.fadeOutScaleRotate:
        return anim.fadeOut(duration: d, delay: del).scaleXY(begin: 1, end: 0.8, duration: d, delay: del).rotate(begin: 0, end: 0.1, duration: d, delay: del);
      case AppAnimateType.fadeOutSlideScale:
        return anim.fadeOut(duration: d, delay: del).slideY(begin: 0, end: -0.06, duration: d, delay: del).scaleXY(begin: 1, end: 0.9, duration: d, delay: del);
      case AppAnimateType.fadeOutSlideRotate:
        return anim.fadeOut(duration: d, delay: del).slideY(begin: 0, end: -0.06, duration: d, delay: del).rotate(begin: 0, end: 0.08, duration: d, delay: del);
      case AppAnimateType.zoomInRotate:
        return anim.scaleXY(begin: 0.5, end: 1, duration: d, delay: del).rotate(begin: -0.2, end: 0, duration: d, delay: del).fadeIn(duration: d, delay: del);
      case AppAnimateType.zoomOutRotate:
        return anim.scaleXY(begin: 1, end: 0.5, duration: d, delay: del).rotate(begin: 0, end: 0.2, duration: d, delay: del).fadeOut(duration: d, delay: del);

      // ── Text ──
      case AppAnimateType.typewriter:
        return anim.fadeIn(duration: 100.ms, delay: del);
      case AppAnimateType.textReveal:
        return anim.slideX(begin: -0.1, end: 0, duration: d, delay: del, curve: Curves.easeOut).fadeIn(duration: d, delay: del, curve: Curves.easeOut);
      case AppAnimateType.marquee:
        return anim.slideX(begin: 0.5, end: -0.5, duration: const Duration(seconds: 4), curve: Curves.linear)
            .then().slideX(begin: -0.5, end: 0.5, duration: const Duration(seconds: 4), curve: Curves.linear);
      case AppAnimateType.ripple:
        return anim.scaleXY(begin: 0.85, end: 1, duration: d, curve: Curves.elasticOut).fadeIn(duration: d * 0.5, curve: Curves.easeOut);
      case AppAnimateType.textWave:
        return anim.slideY(begin: 0, end: -0.1, duration: d * 0.5, curve: Curves.easeOut).then().slideY(begin: -0.1, end: 0, duration: d * 0.5, curve: Curves.easeIn);
      case AppAnimateType.textBounce:
        return anim.scaleXY(begin: 1, end: 1.08, duration: d * 0.4, curve: Curves.easeOut).then().scaleXY(begin: 1.08, end: 1, duration: d * 0.4, curve: Curves.easeIn);
      case AppAnimateType.textFlip:
        return anim.scaleY(begin: 1, end: -1, duration: d * 0.5, curve: Curves.easeOut).then().scaleY(begin: -1, end: 1, duration: d * 0.5, curve: Curves.easeIn);
      case AppAnimateType.textSpin:
        return anim.rotate(begin: 0, end: 1, duration: const Duration(seconds: 2), curve: Curves.linear);
      case AppAnimateType.letterFade:
        return anim.fadeIn(duration: d, delay: del, curve: c.curve);
      case AppAnimateType.letterSlide:
        return anim.slideY(begin: 0.1, end: 0, duration: d, delay: del, curve: c.curve).fadeIn(duration: d, delay: del);
      case AppAnimateType.letterScale:
        return anim.scaleXY(begin: 0, end: 1, duration: d, delay: del, curve: Curves.elasticOut).fadeIn(duration: d, delay: del);
      case AppAnimateType.letterRotate:
        return anim.rotate(begin: -0.3, end: 0, duration: d, delay: del).fadeIn(duration: d, delay: del);
      case AppAnimateType.wordFade:
        return anim.fadeIn(duration: slowD, delay: del, curve: c.curve);
      case AppAnimateType.wordSlide:
        return anim.slideY(begin: 0.08, end: 0, duration: d, delay: del).fadeIn(duration: d, delay: del);
      case AppAnimateType.wordScale:
        return anim.scaleXY(begin: 0.7, end: 1, duration: d, delay: del).fadeIn(duration: d, delay: del);
      case AppAnimateType.wordRotate:
        return anim.rotate(begin: -0.15, end: 0, duration: d, delay: del).fadeIn(duration: d, delay: del);
      case AppAnimateType.scramble:
        return anim.fadeIn(duration: 50.ms, delay: del);
      case AppAnimateType.glitch:
        return anim.slideX(begin: 0, end: 0.02, duration: 30.ms, curve: Curves.easeIn)
            .then().slideX(begin: 0.02, end: -0.02, duration: 30.ms, curve: Curves.easeOut)
            .then().slideX(begin: -0.02, end: 0.01, duration: 30.ms, curve: Curves.easeIn)
            .then().slideX(begin: 0.01, end: 0, duration: 30.ms, curve: Curves.easeOut);

      // ── Utility ──
      case AppAnimateType.revealLeft:
        return anim.slideX(begin: -0.3, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.revealRight:
        return anim.slideX(begin: 0.3, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.revealUp:
        return anim.slideY(begin: -0.3, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.revealDown:
        return anim.slideY(begin: 0.3, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.shimmerSlide:
        return anim.shimmer(duration: d, delay: del);
      case AppAnimateType.shimmerWave:
        return anim.shimmer(duration: d, delay: del, color: Colors.white.withValues(alpha: 0.2));
      case AppAnimateType.shakeX:
        return anim.shake(duration: d, delay: del);
      case AppAnimateType.shakeY:
        return anim.slideY(begin: 0, end: 0.04, duration: 50.ms, curve: Curves.easeIn)
            .then().slideY(begin: 0.04, end: -0.04, duration: 50.ms, curve: Curves.easeOut)
            .then().slideY(begin: -0.04, end: 0.02, duration: 50.ms, curve: Curves.easeIn)
            .then().slideY(begin: 0.02, end: 0, duration: 50.ms, curve: Curves.easeOut);
      case AppAnimateType.shakeDiagonal:
        return anim.slideY(begin: 0, end: 0.03, duration: 50.ms).slideX(begin: 0, end: 0.03, duration: 50.ms)
            .then().slideY(begin: 0.03, end: -0.03, duration: 50.ms).slideX(begin: 0.03, end: -0.03, duration: 50.ms)
            .then().slideY(begin: -0.03, end: 0.01, duration: 50.ms).slideX(begin: -0.03, end: 0.01, duration: 50.ms)
            .then().slideX(begin: 0.01, end: 0, duration: 50.ms).slideY(begin: 0.01, end: 0, duration: 50.ms);
      case AppAnimateType.swingX:
        return anim.rotate(begin: 0, end: 0.15, duration: d * 0.3, curve: Curves.easeOut)
            .then().rotate(begin: 0.15, end: -0.1, duration: d * 0.3, curve: Curves.easeInOut)
            .then().rotate(begin: -0.1, end: 0.05, duration: d * 0.2, curve: Curves.easeInOut)
            .then().rotate(begin: 0.05, end: 0, duration: d * 0.2, curve: Curves.easeIn);
      case AppAnimateType.swingY:
        return anim.slideY(begin: 0, end: 0.08, duration: d * 0.3, curve: Curves.easeOut)
            .then().slideY(begin: 0.08, end: -0.05, duration: d * 0.3, curve: Curves.easeInOut)
            .then().slideY(begin: -0.05, end: 0.03, duration: d * 0.2, curve: Curves.easeInOut)
            .then().slideY(begin: 0.03, end: 0, duration: d * 0.2, curve: Curves.easeIn);
      case AppAnimateType.swingDiagonal:
        return anim.slideX(begin: 0, end: 0.06, duration: d * 0.3, curve: Curves.easeOut).slideY(begin: 0, end: 0.06, duration: d * 0.3, curve: Curves.easeOut)
            .then().slideX(begin: 0.06, end: -0.04, duration: d * 0.3, curve: Curves.easeInOut).slideY(begin: 0.06, end: -0.04, duration: d * 0.3, curve: Curves.easeInOut)
            .then().slideX(begin: -0.04, end: 0, duration: d * 0.4, curve: Curves.easeInOut).slideY(begin: -0.04, end: 0, duration: d * 0.4, curve: Curves.easeInOut);
      case AppAnimateType.breathe:
        return anim.scaleXY(begin: 1, end: 1.06, duration: d, curve: Curves.easeInOut);
      case AppAnimateType.float:
        return anim.slideY(begin: 0, end: -0.06, duration: d, curve: Curves.easeInOut);
      case AppAnimateType.drift:
        return anim.slideY(begin: 0, end: -0.03, duration: slowD, curve: Curves.easeInOut).slideX(begin: 0, end: 0.03, duration: slowD, curve: Curves.easeInOut);
      case AppAnimateType.wobbleFast:
        return anim.slideX(begin: 0, end: 0.04, duration: 40.ms).rotate(begin: 0, end: -0.02, duration: 40.ms)
            .then().slideX(begin: 0.04, end: -0.03, duration: 40.ms).rotate(begin: -0.02, end: 0.01, duration: 40.ms)
            .then().slideX(begin: -0.03, end: 0.02, duration: 40.ms).rotate(begin: 0.01, end: -0.01, duration: 40.ms)
            .then().slideX(begin: 0.02, end: 0, duration: 40.ms).rotate(begin: -0.01, end: 0, duration: 40.ms);
      case AppAnimateType.wobbleSlow:
        return anim.slideX(begin: 0, end: 0.08, duration: d * 0.25).rotate(begin: 0, end: -0.04, duration: d * 0.25)
            .then().slideX(begin: 0.08, end: -0.05, duration: d * 0.25).rotate(begin: -0.04, end: 0.03, duration: d * 0.25)
            .then().slideX(begin: -0.05, end: 0.03, duration: d * 0.25).rotate(begin: 0.03, end: -0.02, duration: d * 0.25)
            .then().slideX(begin: 0.03, end: 0, duration: d * 0.25).rotate(begin: -0.02, end: 0, duration: d * 0.25);
      case AppAnimateType.blinkFast:
        return anim.fadeOut(duration: 30.ms, curve: Curves.easeIn).then(delay: 60.ms).fadeIn(duration: 30.ms, curve: Curves.easeOut);
      case AppAnimateType.blinkSlow:
        return anim.fadeOut(duration: 100.ms, curve: Curves.easeIn).then(delay: 500.ms).fadeIn(duration: 100.ms, curve: Curves.easeOut);

      // ── Loader ──
      case AppAnimateType.loadingDots:
        return anim.fadeIn(duration: d, delay: del, curve: c.curve);
      case AppAnimateType.skeletonWave:
        return anim.shimmer(duration: d, delay: del);
    }
  }
}

