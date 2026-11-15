import 'dart:math' as math;
import 'package:material_ui/material_ui.dart';

class AnimatedLiquidBorder extends StatefulWidget {
  const AnimatedLiquidBorder({
    super.key,
    required this.child,
    this.borderWidth = 2.2,
    this.radius = 28,
    this.duration = const Duration(seconds: 7),
    this.padding = const EdgeInsets.all(1.8),
    this.backgroundColor = const Color(0xFF737172),
  });

  final Widget child;
  final double borderWidth;
  final double radius;
  final Duration duration;
  final EdgeInsets padding;
  final Color backgroundColor;

  @override
  State<AnimatedLiquidBorder> createState() => _AnimatedLiquidBorderState();
}

class _AnimatedLiquidBorderState extends State<AnimatedLiquidBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final angle = _controller.value * math.pi * 2;

          return Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.10),
                  blurRadius: 18,
                  spreadRadius: 0.5,
                ),
              ],
              gradient: SweepGradient(
                transform: GradientRotation(angle),
                colors: const [
                  Color(0xFF6E6B6C), // Dark metal
                  Color(0xFF949192), // Gray
                  Color(0xFFF8F7F7), // White liquid reflection
                  Color(0xFFFFFFFF), // Bright highlight
                  Color(0xFFD5D2D3), // Soft silver
                  Color(0xFF777475), // Gray
                  Color(0xFF5F5D5E), // Dark section
                  Color(0xFF6E6B6C), // Loop color
                ],
                stops: const [
                  0.00,
                  0.15,
                  0.30,
                  0.39,
                  0.49,
                  0.65,
                  0.82,
                  1.00,
                ],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(
                  widget.radius - widget.borderWidth,
                ),
              ),
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
