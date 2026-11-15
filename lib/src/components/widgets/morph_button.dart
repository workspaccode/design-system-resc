import 'package:material_ui/material_ui.dart';

/// A button that morphs between two icon states (e.g. Play / Pause)
/// with a smooth rotation and scale animation.
class AppMorphButton extends StatefulWidget {
  final IconData iconA;
  final IconData iconB;
  final double size;
  final double iconSize;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onToggle;
  final bool initialIsB;

  const AppMorphButton({
    super.key,
    required this.iconA,
    required this.iconB,
    this.size = 56,
    this.iconSize = 24,
    this.color,
    this.backgroundColor,
    this.onToggle,
    this.initialIsB = false,
  });

  @override
  State<AppMorphButton> createState() => _AppMorphButtonState();
}

class _AppMorphButtonState extends State<AppMorphButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;
  late final Animation<double> _scale;

  bool _isB = false;

  @override
  void initState() {
    super.initState();
    _isB = widget.initialIsB;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _rotation = Tween<double>(begin: 0.0, end: 180.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeIn),
      ),
    );
    if (_isB) _controller.value = 1;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_isB) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    _isB = !_isB;
    widget.onToggle?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final bg = widget.backgroundColor ?? colors.primaryContainer;
    final fg = widget.color ?? colors.onPrimaryContainer;

    return GestureDetector(
      onTap: _toggle,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final rotateAngle = _rotation.value * 3.14159 / 180;
          final showIconB = _isB && _scale.value == 0;
          final currentIcon = showIconB ? widget.iconB : widget.iconA;
          final scaleValue = _isB ? 1.0 - _scale.value : _scale.value;

          return Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: bg,
              shape: BoxShape.circle,
            ),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateZ(rotateAngle),
              child: Transform.scale(
                scale: scaleValue == 0 ? 0.01 : scaleValue,
                child: Icon(currentIcon, size: widget.iconSize, color: fg),
              ),
            ),
          );
        },
      ),
    );
  }
}
