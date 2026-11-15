import 'package:material_ui/material_ui.dart';

/// A card that flips 180° on tap to reveal its back side.
/// Works with any front/back widget pair.
class AppFlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final double width;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;
  final Duration duration;

  const AppFlipCard({
    super.key,
    required this.front,
    required this.back,
    this.width = 200,
    this.height = 280,
    this.borderRadius = 16,
    this.backgroundColor,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<AppFlipCard> createState() => _AppFlipCardState();
}

class _AppFlipCardState extends State<AppFlipCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _showingFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flip() {
    if (_controller.isAnimating) return;
    if (_showingFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _showingFront = !_showingFront;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          final angle = _animation.value * 3.14159;
          final isBack = angle > 3.14159 / 2;

          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              child: isBack
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(3.14159),
                    child: _buildFace(widget.back, colors),
                  )
                : _buildFace(widget.front, colors),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFace(Widget child, ColorScheme colors) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: child,
    );
  }
}
