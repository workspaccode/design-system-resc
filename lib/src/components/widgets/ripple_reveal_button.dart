import 'dart:math';

import 'package:material_ui/material_ui.dart';

/// A button that reveals new content via a circular ripple expanding
/// from the tap position.
class AppRippleRevealButton extends StatefulWidget {
  final Widget front;
  final Widget back;
  final double width;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;
  final Duration animationDuration;

  const AppRippleRevealButton({
    super.key,
    required this.front,
    required this.back,
    this.width = 160,
    this.height = 48,
    this.borderRadius = 12,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 600),
  });

  @override
  State<AppRippleRevealButton> createState() => _AppRippleRevealButtonState();
}

class _AppRippleRevealButtonState extends State<AppRippleRevealButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _reveal;
  late final Animation<double> _frontOpacity;

  Offset _tapPosition = Offset.zero;
  bool _expanded = false;
  double _maxRadius = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _reveal = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _frontOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.3, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails d) {
    final box = context.findRenderObject() as RenderBox;
    _tapPosition = box.globalToLocal(d.globalPosition);
  }

  void _toggle() {
    if (_expanded) {
      _controller.reverse();
    } else {
      final size = Size(widget.width, widget.height);
      _maxRadius = sqrt(size.width * size.width + size.height * size.height);
      _controller.forward(from: 0);
    }
    _expanded = !_expanded;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTap: _toggle,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? colors.surfaceContainer,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                if (!_expanded || _reveal.value < 0.5)
                  Positioned.fill(
                    child: Opacity(
                      opacity: _frontOpacity.value,
                      child: Center(child: widget.front),
                    ),
                  ),
                if (_expanded || _reveal.value > 0)
                  ClipPath(
                    clipper: _RipplePathClipper(
                      origin: _tapPosition,
                      progress: _reveal.value,
                      maxRadius: _maxRadius,
                    ),
                    child: Container(
                      width: widget.width,
                      height: widget.height,
                      color: widget.backgroundColor ?? colors.surfaceContainer,
                      child: Center(child: widget.back),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _RipplePathClipper extends CustomClipper<Path> {
  final Offset origin;
  final double progress;
  final double maxRadius;

  const _RipplePathClipper({
    required this.origin,
    required this.progress,
    required this.maxRadius,
  });

  @override
  Path getClip(Size size) {
    return Path()..addOval(
      Rect.fromCircle(center: origin, radius: progress * maxRadius),
    );
  }

  @override
  bool shouldReclip(_RipplePathClipper old) =>
      old.progress != progress || old.origin != origin;
}
