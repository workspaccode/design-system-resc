import 'package:material_ui/material_ui.dart';

/// A pulsing glow ring that wraps any child widget.
/// The ring scales and fades in/out continuously.
class AppGlowRing extends StatefulWidget {
  final Widget child;
  final double ringWidth;
  final double ringDistance;
  final Color? color;
  final Duration duration;

  const AppGlowRing({
    super.key,
    required this.child,
    this.ringWidth = 2.5,
    this.ringDistance = 6,
    this.color,
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  State<AppGlowRing> createState() => _AppGlowRingState();
}

class _AppGlowRingState extends State<AppGlowRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
    _pulse = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final glowColor = widget.color ?? colors.primary;

    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
      final scale = 1.0 + (_pulse.value * widget.ringDistance / 50);
      final opacity = 1.0 - _pulse.value * 0.6;

        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: scale,
              child: Opacity(
                opacity: opacity,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: glowColor.withValues(alpha: opacity),
                      width: widget.ringWidth,
                    ),
                  ),
                ),
              ),
            ),
            child!,
          ],
        );
      },
      child: widget.child,
    );
  }
}

/// A focused variant that shows a static glow ring (doesn't pulse).
/// Useful for active states like selected items.
class AppFocusGlow extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double padding;

  const AppFocusGlow({
    super.key,
    required this.child,
    this.color,
    this.padding = 4,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final glowColor = color ?? colors.primary;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: glowColor.withValues(alpha: 0.4),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: child,
    );
  }
}
