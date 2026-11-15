import 'dart:math' as math;
import 'package:material_ui/material_ui.dart';

class LiquidMonoBackground extends StatefulWidget {
  const LiquidMonoBackground({
    super.key,
    this.child,
    this.duration = const Duration(seconds: 11),
  });

  final Widget? child;
  final Duration duration;

  @override
  State<LiquidMonoBackground> createState() => _LiquidMonoBackgroundState();
}

class _LiquidMonoBackgroundState extends State<LiquidMonoBackground>
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
      child: CustomPaint(
        painter: _LiquidMonoPainter(animation: _controller),
        child: SizedBox.expand(child: widget.child),
      ),
    );
  }
}

class _LiquidMonoPainter extends CustomPainter {
  _LiquidMonoPainter({required this.animation}) : super(repaint: animation);

  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value * math.pi * 2;

    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF757374),
    );

    // Bright flow entering from the upper-left edge.
    _softBlob(
      canvas,
      center: Offset(
        -size.width * 0.10 + math.sin(t) * 18,
        size.height * 0.16 + math.cos(t * 0.8) * 35,
      ),
      radius: size.width * 0.43,
      intensity: 0.95,
    );

    // Main diagonal white flow.
    _softBlob(
      canvas,
      center: Offset(
        size.width * 0.70 + math.cos(t * 0.75) * 28,
        size.height * 0.57 + math.sin(t * 0.9) * 45,
      ),
      radius: size.width * 0.74,
      intensity: 0.82,
    );

    // Narrow lower-center bright stream.
    _softBlob(
      canvas,
      center: Offset(
        size.width * 0.47 + math.sin(t * 1.1) * 22,
        size.height * 1.08 + math.cos(t * 0.7) * 30,
      ),
      radius: size.width * 0.60,
      intensity: 0.88,
    );

    // Lower-right gray metallic cavity.
    _darkBlob(
      canvas,
      center: Offset(
        size.width * 1.10 + math.cos(t * 0.8) * 22,
        size.height * 0.88 + math.sin(t * 1.2) * 30,
      ),
      radius: size.width * 0.54,
    );

    // Top-center subtle silver reflection.
    _softBlob(
      canvas,
      center: Offset(
        size.width * 0.45 + math.sin(t * 0.65) * 14,
        -size.height * 0.08 + math.cos(t) * 20,
      ),
      radius: size.width * 0.36,
      intensity: 0.38,
    );
  }

  void _softBlob(
    Canvas canvas, {
    required Offset center,
    required double radius,
    required double intensity,
  }) {
    final shader = RadialGradient(
      colors: [
        Color.lerp(Colors.white, const Color(0xFFE4E2E2), 1 - intensity)!,
        const Color(0xB8F5F4F4),
        const Color(0x48EFEDED),
        Colors.transparent,
      ],
      stops: const [0.0, 0.20, 0.52, 1.0],
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = shader
        ..blendMode = BlendMode.screen,
    );
  }

  void _darkBlob(
    Canvas canvas, {
    required Offset center,
    required double radius,
  }) {
    final shader = RadialGradient(
      colors: const [
        Color(0xFF6D6A6B),
        Color(0xFF737071),
        Color(0x26716E6F),
        Colors.transparent,
      ],
      stops: [0.0, 0.35, 0.67, 1.0],
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = shader
        ..blendMode = BlendMode.multiply,
    );
  }

  @override
  bool shouldRepaint(covariant _LiquidMonoPainter oldDelegate) => false;
}