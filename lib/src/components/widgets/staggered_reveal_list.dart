import 'package:material_ui/material_ui.dart';

/// A list whose children reveal one after another with a staggered
/// animation. Each child slides in with a fade + vertical offset.
class AppStaggeredList extends StatefulWidget {
  final List<Widget> children;
  final Duration itemDuration;
  final Duration interval;
  final double slideOffset;
  final bool autoStart;
  final EdgeInsetsGeometry? padding;

  const AppStaggeredList({
    super.key,
    required this.children,
    this.itemDuration = const Duration(milliseconds: 400),
    this.interval = const Duration(milliseconds: 100),
    this.slideOffset = 24,
    this.autoStart = true,
    this.padding,
  });

  @override
  State<AppStaggeredList> createState() => _AppStaggeredListState();
}

class _AppStaggeredListState extends State<AppStaggeredList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    final total =
        widget.itemDuration + widget.interval * (widget.children.length - 1);
    _controller = AnimationController(vsync: this, duration: total);

    for (int i = 0; i < widget.children.length; i++) {
      _animations.add(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            (widget.interval * i).inMilliseconds / total.inMilliseconds,
            (widget.itemDuration + widget.interval * i).inMilliseconds /
                total.inMilliseconds,
            curve: Curves.easeOutCubic,
          ),
        ),
      );
    }

    if (widget.autoStart) _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void play() => _controller.forward(from: 0);
  void reset() => _controller.reset();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: widget.padding,
      children: List.generate(widget.children.length, (i) {
        return AnimatedBuilder(
          animation: _animations[i],
          builder: (context, _) {
            return Opacity(
              opacity: _animations[i].value,
              child: Transform.translate(
                offset: Offset(0, widget.slideOffset * (1.0 - _animations[i].value)),
                child: widget.children[i],
              ),
            );
          },
        );
      }),
    );
  }
}

/// A single widget that animates in when [visible] becomes true.
class AppRevealWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double slideOffset;
  final bool visible;

  const AppRevealWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOutCubic,
    this.slideOffset = 24,
    this.visible = true,
  });

  @override
  State<AppRevealWidget> createState() => _AppRevealWidgetState();
}

class _AppRevealWidgetState extends State<AppRevealWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    if (widget.visible) _controller.forward();
  }

  @override
  void didUpdateWidget(AppRevealWidget old) {
    super.didUpdateWidget(old);
    if (widget.visible && !old.visible) {
      _controller.forward();
    } else if (!widget.visible && old.visible) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: Offset(0, widget.slideOffset * (1.0 - _animation.value)),
            child: widget.child,
          ),
        );
      },
    );
  }
}
