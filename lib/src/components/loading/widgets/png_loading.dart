import 'package:material_ui/material_ui.dart';

import '../../../../generated/assets.dart';
import '../../../theme/theme_extensions.dart';
import '../../animate/animate_types.dart';
import '../../animate/app_animate.dart';

/// A loading widget that animates between PNG frames using flutter_animate.
/// Supports frame-based animation by alternating between multiple PNG images.
class PngLoading extends StatefulWidget {
  /// List of PNG asset paths to animate between
  final List<String> imagePaths;

  /// Duration for each frame transition
  final Duration frameDuration;

  /// Size of the loading widget
  final double size;

  /// Optional custom decoration for the container
  final BoxDecoration? decoration;

  /// Whether to loop the animation continuously
  final bool loop;

  /// Custom animation curve
  final Curve curve;

  const PngLoading({
    super.key,
    required this.imagePaths,
    this.frameDuration = const Duration(milliseconds: 600),
    this.size = 200,
    this.decoration,
    this.loop = true,
    this.curve = Curves.easeInOut,
  });

  @override
  State<PngLoading> createState() => _PngLoadingState();
}

/// Controller for [PngLoadingV2] — manages animation config and playback state.
class PngLoadingController extends ChangeNotifier {
  bool autoplay;
  int loopCount;
  AppAnimateType animationType;
  String? imagePath;
  double size;
  BoxDecoration? decoration;

  int _resetKey = 0;
  PngLoadingController({
    this.autoplay = true,
    this.loopCount = 0,
    this.animationType = AppAnimateType.pulse,
    this.imagePath,
    this.size = 200,
    this.decoration,
  });

  int get resetKey => _resetKey;

  void play() {
    autoplay = true;
    _resetKey++;
    notifyListeners();
  }

  void restart() {
    _resetKey++;
    notifyListeners();
  }

  void stop() {
    autoplay = false;
    _resetKey++;
    notifyListeners();
  }
}

/// A simplified two-frame loading widget that alternates between dark and light images.
class PngLoadingDual extends StatelessWidget {
  /// Path to the dark/first image
  final String darkImagePath;

  /// Path to the light/second image
  final String lightImagePath;

  /// Duration for each frame transition
  final Duration frameDuration;

  /// Size of the loading widget
  final double size;

  /// Optional custom decoration for the container
  final BoxDecoration? decoration;

  /// Custom animation curve
  final Curve curve;

  const PngLoadingDual({
    super.key,
    required this.darkImagePath,
    required this.lightImagePath,
    this.frameDuration = const Duration(milliseconds: 600),
    this.size = 200,
    this.decoration,
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return PngLoading(
      imagePaths: [darkImagePath, lightImagePath],
      frameDuration: frameDuration,
      size: size,
      decoration: decoration,
      curve: curve,
    );
  }
}

/// A fade-in/out loading widget for single image pulsing effect.
class PngLoadingFade extends StatefulWidget {
  /// Path to the image to animate
  final String imagePath;

  /// Size of the loading widget
  final double size;

  /// Optional custom decoration for the container
  final BoxDecoration? decoration;

  /// Duration for fade in/out cycle
  final Duration fadeDuration;

  const PngLoadingFade({
    super.key,
    required this.imagePath,
    this.size = 80,
    this.decoration,
    this.fadeDuration = const Duration(milliseconds: 500),
  });

  @override
  State<PngLoadingFade> createState() => _PngLoadingFadeState();
}

/// A pulsing loading widget that scales the image up and down continuously.
class PngLoadingPulse extends StatefulWidget {
  /// Path to the image to animate
  final String imagePath;

  /// Size of the loading widget
  final double size;

  /// Optional custom decoration for the container
  final BoxDecoration? decoration;

  /// Duration for one complete pulse cycle
  final Duration pulseDuration;

  /// Scale animation range
  final double minScale;
  final double maxScale;

  const PngLoadingPulse({
    super.key,
    required this.imagePath,
    this.size = 150,
    this.decoration,
    this.pulseDuration = const Duration(milliseconds: 1000),
    this.minScale = 0.8,
    this.maxScale = 1.2,
  });

  @override
  State<PngLoadingPulse> createState() => _PngLoadingPulseState();
}

/// Enhanced loading widget that uses the 200+ animation system via [AppAnimate].
/// Driven by a [PngLoadingController] for configurable playback.
class PngLoadingV2 extends StatelessWidget {
  final PngLoadingController controller;

  const PngLoadingV2({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final defaultDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: colors.surface,
        );

        return SizedBox(
          width: controller.size,
          height: controller.size,
          child: Container(
            decoration: controller.decoration ?? defaultDecoration,
            child: KeyedSubtree(
              key: ValueKey(controller.resetKey),
              child: AppAnimate(
                type: controller.animationType,
                autoplay: controller.autoplay,
                loopCount: controller.loopCount,
                child: Image.asset(
                  controller.imagePath ?? Assets.imageRescLigh,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PngLoadingFadeState extends State<PngLoadingFade>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      //color: context.colors.surface,
    );

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Container(
        decoration: widget.decoration ?? defaultDecoration,
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            widget.imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.fadeDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }
}

class _PngLoadingPulseState extends State<PngLoadingPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final defaultDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: colors.surface,
    );

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Container(
        decoration: widget.decoration ?? defaultDecoration,
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(
            widget.imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.pulseDuration,
      vsync: this,
    );
    _animation =
        Tween<double>(begin: widget.minScale, end: widget.maxScale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }
}

class _PngLoadingState extends State<PngLoading>
    with SingleTickerProviderStateMixin {
  int _currentFrame = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final defaultDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: colors.surface,
    );

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Container(
        decoration: widget.decoration ?? defaultDecoration,
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            widget.imagePaths[_currentFrame],
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.frameDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    if (widget.loop) {
      _controller.repeat();
    } else {
      _controller.forward();
    }

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        if (mounted) {
          setState(() {
            _currentFrame = (_currentFrame + 1) % widget.imagePaths.length;
          });
          if (widget.loop) {
            _controller.reset();
            _controller.forward();
          }
        }
      }
    });
  }
}
