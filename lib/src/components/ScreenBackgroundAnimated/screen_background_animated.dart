import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

/// A full-screen animated background that renders a sonar/pulse ring effect
/// using pure Flutter animation APIs ([CustomPainter] + [AnimationController]).
/// No external assets or GIFs required.
///
/// The animation consists of concentric circles expanding outward while fading,
/// with a glowing core dot at the center. Child content can be overlaid on top.
///
/// Set [gradientColors] to enable animated gradient mode — colors shift smoothly
/// across the background and rings for a fluid, iridescent effect.
class AppScreenAnimated extends StatefulWidget {
  final Widget? child;
  final Color color;
  final Color secondaryColor;
  final double pulseSpeed;
  final int ringCount;
  final double ringStrokeWidth;
  final double coreDotRatio;
  final double maxRingOpacity;
  final List<Color>? gradientColors;
  final GradientStyle gradientStyle;

  const AppScreenAnimated({
    super.key,
    this.child,
    this.color = Colors.blueAccent,
    this.secondaryColor = Colors.transparent,
    this.pulseSpeed = 1.0,
    this.ringCount = 3,
    this.ringStrokeWidth = 2.5,
    this.coreDotRatio = 0.25,
    this.maxRingOpacity = 0.6,
    this.gradientColors,
    this.gradientStyle = GradientStyle.sweep,
  });

  @override
  State<AppScreenAnimated> createState() => _AppScreenAnimatedState();
}

class _AppScreenAnimatedState extends State<AppScreenAnimated>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _gradientController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (1400 / widget.pulseSpeed).round()),
    )..repeat();
    _gradientController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (6000 / widget.pulseSpeed).round()),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        final gradients = widget.gradientColors;
        return Stack(
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                animation: Listenable.merge([_controller, _gradientController]),
                builder: (context, _) {
                  return CustomPaint(
                    size: size,
                    painter: _PulsePainter(
                      progress: _controller.value,
                      gradientProgress: gradients != null ? _gradientController.value : null,
                      color: widget.color,
                      secondaryColor: widget.secondaryColor,
                      ringCount: widget.ringCount,
                      ringStrokeWidth: widget.ringStrokeWidth,
                      coreDotRatio: widget.coreDotRatio,
                      maxRingOpacity: widget.maxRingOpacity,
                      gradientColors: gradients,
                      gradientStyle: widget.gradientStyle,
                    ),
                  );
                },
              ),
            ),
            if (widget.child != null) Positioned.fill(child: widget.child!),
          ],
        );
      },
    );
  }
}

/// A compact inline version of the animated background for use inside
/// smaller containers (e.g., cards, loading states).
class AppScreenAnimatedDot extends StatefulWidget {
  final double size;
  final Color color;
  final int ringCount;
  final double ringStrokeWidth;
  final List<Color>? gradientColors;
  final GradientStyle gradientStyle;

  const AppScreenAnimatedDot({
    super.key,
    this.size = 100,
    this.color = Colors.blueAccent,
    this.ringCount = 3,
    this.ringStrokeWidth = 2.5,
    this.gradientColors,
    this.gradientStyle = GradientStyle.sweep,
  });

  @override
  State<AppScreenAnimatedDot> createState() => _AppScreenAnimatedDotState();
}

class _AppScreenAnimatedDotState extends State<AppScreenAnimatedDot>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _gradientController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradients = widget.gradientColors;
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: Listenable.merge([_controller, _gradientController]),
        builder: (context, _) {
          return CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _PulsePainter(
              progress: _controller.value,
              gradientProgress: gradients != null ? _gradientController.value : null,
              color: widget.color,
              ringCount: widget.ringCount,
              ringStrokeWidth: widget.ringStrokeWidth,
              gradientColors: gradients,
              gradientStyle: widget.gradientStyle,
            ),
          );
        },
      ),
    );
  }
}

/// How animated gradient color stops are arranged.
enum GradientStyle {
  /// Radial gradient radiating from center outward.
  radial,

  /// Sweep (conical) gradient rotating around center.
  sweep,
}

/// A multi-point variant that scatters several pulsing dots across the
/// background for a more dynamic particle/nebula-like feel.
class AppScreenAnimatedField extends StatefulWidget {
  final int dotCount;
  final Color color;
  final double pulseSpeed;
  final double dotSize;
  final List<Color>? gradientColors;
  final GradientStyle gradientStyle;

  const AppScreenAnimatedField({
    super.key,
    this.dotCount = 5,
    this.color = Colors.blueAccent,
    this.pulseSpeed = 1.0,
    this.dotSize = 60,
    this.gradientColors,
    this.gradientStyle = GradientStyle.sweep,
  });

  @override
  State<AppScreenAnimatedField> createState() => _AppScreenAnimatedFieldState();
}

class _AppScreenAnimatedFieldState extends State<AppScreenAnimatedField>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _gradientController;
  late List<_DotConfig> _dots;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (1400 / widget.pulseSpeed).round()),
    )..repeat();
    _gradientController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (6000 / widget.pulseSpeed).round()),
    )..repeat();
    _generateDots();
  }

  void _generateDots() {
    final rng = math.Random(42);
    _dots = List.generate(widget.dotCount, (i) {
      return _DotConfig(
        dx: rng.nextDouble(),
        dy: rng.nextDouble(),
        phase: rng.nextDouble(),
        color: widget.color.withValues(alpha: 0.15 + rng.nextDouble() * 0.25),
        size: widget.dotSize * (0.6 + rng.nextDouble() * 0.8),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradients = widget.gradientColors;
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        return AnimatedBuilder(
          animation: Listenable.merge([_controller, _gradientController]),
          builder: (context, _) {
            return CustomPaint(
              size: size,
              painter: _FieldPainter(
                progress: _controller.value,
                gradientProgress: gradients != null ? _gradientController.value : null,
                dots: _dots,
                color: widget.color,
                gradientColors: gradients,
                gradientStyle: widget.gradientStyle,
              ),
            );
          },
        );
      },
    );
  }
}

class _DotConfig {
  final double dx;
  final double dy;
  final double phase;
  final Color color;
  final double size;
  const _DotConfig({
    required this.dx,
    required this.dy,
    required this.phase,
    required this.color,
    required this.size,
  });
}

class _PulsePainter extends CustomPainter {
  final double progress;
  final double? gradientProgress;
  final Color color;
  final Color secondaryColor;
  final int ringCount;
  final double ringStrokeWidth;
  final double coreDotRatio;
  final double maxRingOpacity;
  final List<Color>? gradientColors;
  final GradientStyle gradientStyle;

  _PulsePainter({
    required this.progress,
    this.gradientProgress,
    required this.color,
    this.secondaryColor = Colors.transparent,
    this.ringCount = 3,
    this.ringStrokeWidth = 2.5,
    this.coreDotRatio = 0.25,
    this.maxRingOpacity = 0.6,
    this.gradientColors,
    this.gradientStyle = GradientStyle.sweep,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.shortestSide / 2;

    final useGradient = gradientProgress != null && gradientColors != null && gradientColors!.length >= 2;

    for (int i = 0; i < ringCount; i++) {
      final delay = i / ringCount;
      final t = (progress + delay) % 1.0;
      final radius = maxRadius * t;
      final opacity = (1.0 - t).clamp(0.0, 1.0);

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = ringStrokeWidth;

      if (useGradient) {
        paint.shader = _gradientShader(
          center, maxRadius * 0.7, size,
          gradientProgress!, opacity,
        );
      } else {
        paint.color = color.withValues(alpha: opacity * maxRingOpacity);
      }

      canvas.drawCircle(center, radius, paint);

      if (secondaryColor != Colors.transparent) {
        final innerRadius = radius * 0.85;
        final innerPaint = Paint()
          ..color = secondaryColor.withValues(alpha: opacity * maxRingOpacity * 0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = ringStrokeWidth * 0.6;
        canvas.drawCircle(center, innerRadius, innerPaint);
      }
    }

    if (useGradient) {
      final corePaint = Paint()
        ..shader = _coreGradientShader(center, maxRadius * coreDotRatio, gradientProgress!);
      canvas.drawCircle(center, maxRadius * coreDotRatio, corePaint);

      final glowPaint = Paint()
        ..shader = _coreGradientShader(center, maxRadius * coreDotRatio * 1.8, gradientProgress!)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(center, maxRadius * coreDotRatio * 1.8, glowPaint);
    } else {
      final corePaint = Paint()..color = color;
      canvas.drawCircle(center, maxRadius * coreDotRatio, corePaint);

      final glowPaint = Paint()
        ..color = color.withValues(alpha: 0.2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(center, maxRadius * coreDotRatio * 1.8, glowPaint);
    }
  }

  Shader _gradientShader(Offset center, double radius, Size size, double gp, double opacity) {
    final colors = gradientColors!
        .map((c) => c.withValues(alpha: opacity * maxRingOpacity))
        .toList();
    final stops = _buildStops(gp, colors.length);
    switch (gradientStyle) {
      case GradientStyle.radial:
        return RadialGradient(
          colors: colors,
          stops: stops,
          center: FractionalOffset(0.5 + 0.2 * math.sin(gp * math.pi * 2), 0.5 + 0.2 * math.cos(gp * math.pi * 2)),
          radius: 0.8 + 0.2 * math.sin(gp * math.pi * 2 + 1),
        ).createShader(Offset.zero & size);
      case GradientStyle.sweep:
        return SweepGradient(
          colors: colors,
          stops: stops,
          center: FractionalOffset(0.5, 0.5),
          startAngle: gp * math.pi * 2,
          endAngle: gp * math.pi * 2 + math.pi * 2,
        ).createShader(Offset.zero & size);
    }
  }

  Shader _coreGradientShader(Offset center, double radius, double gp) {
    final colors = gradientColors!
        .map((c) => c.withValues(alpha: 0.9))
        .toList();
    final stops = _buildStops(gp, colors.length);
    switch (gradientStyle) {
      case GradientStyle.radial:
        return RadialGradient(
          colors: colors,
          stops: stops,
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      case GradientStyle.sweep:
        return SweepGradient(
          colors: colors,
          stops: stops,
          startAngle: gp * math.pi * 2,
          endAngle: gp * math.pi * 2 + math.pi * 2,
        ).createShader(Rect.fromCircle(center: center, radius: radius));
    }
  }

  List<double> _buildStops(double gp, int count) {
    final shift = gp % 1.0;
    return List.generate(count, (i) => ((i / (count - 1)) + shift) % 1.0);
  }

  @override
  bool shouldRepaint(covariant _PulsePainter oldDelegate) => true;
}

class _FieldPainter extends CustomPainter {
  final double progress;
  final double? gradientProgress;
  final List<_DotConfig> dots;
  final Color color;
  final List<Color>? gradientColors;
  final GradientStyle gradientStyle;

  _FieldPainter({
    required this.progress,
    this.gradientProgress,
    required this.dots,
    required this.color,
    this.gradientColors,
    this.gradientStyle = GradientStyle.sweep,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final useGradient = gradientProgress != null && gradientColors != null && gradientColors!.length >= 2;

    if (useGradient) {
      _drawGradientBg(canvas, size, center);
    }

    for (final dot in dots) {
      final dotCenter = Offset(dot.dx * size.width, dot.dy * size.height);
      final t = (progress + dot.phase) % 1.0;
      final radius = (dot.size / 2) * t;
      final opacity = (1.0 - t).clamp(0.0, 1.0);

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      if (useGradient) {
        paint.shader = _ringGradientShader(dotCenter, radius, size, gradientProgress!, opacity);
      } else {
        paint.color = color.withValues(alpha: opacity * 0.4);
      }

      canvas.drawCircle(dotCenter, radius, paint);

      if (t < 0.3) {
        if (useGradient) {
          final corePaint = Paint()
            ..shader = _coreGradientShader(dotCenter, dot.size * 0.15, gradientProgress!);
          canvas.drawCircle(dotCenter, dot.size * 0.15, corePaint);
        } else {
          final corePaint = Paint()..color = dot.color;
          canvas.drawCircle(dotCenter, dot.size * 0.15, corePaint);
        }
      }
    }
  }

  void _drawGradientBg(Canvas canvas, Size size, Offset center) {
    final bgPaint = Paint()
      ..shader = _bgGradientShader(size, center, gradientProgress!);
    canvas.drawRect(Offset.zero & size, bgPaint);
  }

  Shader _bgGradientShader(Size size, Offset center, double gp) {
    final colors = gradientColors!
        .map((c) => c.withValues(alpha: 0.15))
        .toList();
    final stops = _buildStops(gp, colors.length);
    switch (gradientStyle) {
      case GradientStyle.radial:
        return RadialGradient(
          colors: colors,
          stops: stops,
          center: FractionalOffset(0.5 + 0.15 * math.sin(gp * math.pi * 2), 0.5 + 0.15 * math.cos(gp * math.pi * 2)),
          radius: 0.9,
        ).createShader(Offset.zero & size);
      case GradientStyle.sweep:
        return SweepGradient(
          colors: colors,
          stops: stops,
          startAngle: gp * math.pi * 2,
          endAngle: gp * math.pi * 2 + math.pi * 2,
        ).createShader(Offset.zero & size);
    }
  }

  Shader _ringGradientShader(Offset center, double radius, Size size, double gp, double opacity) {
    final colors = gradientColors!
        .map((c) => c.withValues(alpha: opacity * 0.4))
        .toList();
    final stops = _buildStops(gp, colors.length);
    switch (gradientStyle) {
      case GradientStyle.sweep:
        return SweepGradient(
          colors: colors,
          stops: stops,
          startAngle: gp * math.pi * 2,
          endAngle: gp * math.pi * 2 + math.pi * 2,
        ).createShader(Rect.fromCircle(center: center, radius: radius * 1.5));
      case GradientStyle.radial:
        return RadialGradient(
          colors: colors,
          stops: stops,
        ).createShader(Rect.fromCircle(center: center, radius: radius * 1.5));
    }
  }

  Shader _coreGradientShader(Offset center, double radius, double gp) {
    final colors = gradientColors!
        .map((c) => c.withValues(alpha: 0.7))
        .toList();
    final stops = _buildStops(gp, colors.length);
    switch (gradientStyle) {
      case GradientStyle.sweep:
        return SweepGradient(
          colors: colors,
          stops: stops,
          startAngle: gp * math.pi * 2,
          endAngle: gp * math.pi * 2 + math.pi * 2,
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      case GradientStyle.radial:
        return RadialGradient(
          colors: colors,
          stops: stops,
        ).createShader(Rect.fromCircle(center: center, radius: radius));
    }
  }

  List<double> _buildStops(double gp, int count) {
    final shift = gp % 1.0;
    return List.generate(count, (i) => ((i / (count - 1)) + shift) % 1.0);
  }

  @override
  bool shouldRepaint(covariant _FieldPainter oldDelegate) => true;
}

/// A soft, organic animated gradient background that resembles flowing
/// aurora or mesh-gradient wallpapers. Several blurred color blobs drift,
/// expand, and fade continuously. No assets required.
class AppScreenAnimatedAurora extends StatefulWidget {
  final Widget? child;
  final List<Color>? colors;
  final Color backgroundColor;
  final int blobCount;
  final double baseSpeed;
  final double blurSigma;

  const AppScreenAnimatedAurora({
    super.key,
    this.child,
    this.colors,
    this.backgroundColor = Colors.black,
    this.blobCount = 4,
    this.baseSpeed = 1.0,
    this.blurSigma = 60,
  });

  @override
  State<AppScreenAnimatedAurora> createState() => _AppScreenAnimatedAuroraState();
}

class _AppScreenAnimatedAuroraState extends State<AppScreenAnimatedAurora>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<_AuroraBlob> _blobs;

  static const List<Color> _defaultColors = [
    Color(0xFFFF6B35),
    Color(0xFFFF4E8C),
    Color(0xFF9D4EDD),
    Color(0xFF3C096C),
    Color(0xFFFF8500),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (20000 / widget.baseSpeed).round()),
    )..repeat();
    _generateBlobs();
  }

  void _generateBlobs() {
    final rng = math.Random(42);
    final palette = widget.colors ?? _defaultColors;
    _blobs = List.generate(widget.blobCount, (i) {
      return _AuroraBlob(
        originX: 0.3 + rng.nextDouble() * 0.4,
        originY: 0.3 + rng.nextDouble() * 0.4,
        radius: 0.3 + rng.nextDouble() * 0.35,
        color: palette[i % palette.length],
        secondaryColor: palette[(i + 1) % palette.length],
        speed: 0.3 + rng.nextDouble() * 0.5,
        phase: rng.nextDouble() * math.pi * 2,
        orbitRadius: 0.15 + rng.nextDouble() * 0.2,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        return Stack(
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return CustomPaint(
                    size: size,
                    painter: _AuroraPainter(
                      progress: _controller.value,
                      blobs: _blobs,
                      backgroundColor: widget.backgroundColor,
                      blurSigma: widget.blurSigma,
                    ),
                  );
                },
              ),
            ),
            if (widget.child != null) Positioned.fill(child: widget.child!),
          ],
        );
      },
    );
  }
}

class _AuroraBlob {
  final double originX;
  final double originY;
  final double radius;
  final Color color;
  final Color secondaryColor;
  final double speed;
  final double phase;
  final double orbitRadius;

  const _AuroraBlob({
    required this.originX,
    required this.originY,
    required this.radius,
    required this.color,
    required this.secondaryColor,
    required this.speed,
    required this.phase,
    required this.orbitRadius,
  });
}

class _AuroraPainter extends CustomPainter {
  final double progress;
  final List<_AuroraBlob> blobs;
  final Color backgroundColor;
  final double blurSigma;

  _AuroraPainter({
    required this.progress,
    required this.blobs,
    required this.backgroundColor,
    required this.blurSigma,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = backgroundColor,
    );

    for (int i = 0; i < blobs.length; i++) {
      final blob = blobs[i];
      final t = progress * blob.speed * math.pi * 2 + blob.phase;

      final x = blob.originX + math.cos(t) * blob.orbitRadius;
      final y = blob.originY + math.sin(t * 0.7 + 1) * blob.orbitRadius * 0.8;
      final center = Offset(x * size.width, y * size.height);
      final radius = math.max(size.width, size.height) * blob.radius;

      final breathe = 1.0 + 0.15 * math.sin(t * 1.5);
      final currentRadius = radius * breathe;

      final colorMix = (math.sin(t * 0.5) + 1) / 2;
      final currentColor = Color.lerp(blob.color, blob.secondaryColor, colorMix)!;

      final gradientPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            currentColor.withValues(alpha: 0.65),
            currentColor.withValues(alpha: 0.2),
            currentColor.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 0.45, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: currentRadius));

      canvas.drawCircle(center, currentRadius, gradientPaint);

      final blurPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            currentColor.withValues(alpha: 0.35),
            currentColor.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: currentRadius * 1.4))
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);

      canvas.drawCircle(center, currentRadius * 1.4, blurPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _AuroraPainter oldDelegate) => true;
}
