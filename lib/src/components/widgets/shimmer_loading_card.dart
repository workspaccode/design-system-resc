import 'package:material_ui/material_ui.dart';

/// A skeleton loading card with a shimmering gradient animation.
/// Use while content is loading to indicate progress.
class AppShimmerCard extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color? baseColor;
  final Color? shimmerColor;

  const AppShimmerCard({
    super.key,
    this.width = double.infinity,
    this.height = 100,
    this.borderRadius = 12,
    this.baseColor,
    this.shimmerColor,
  });

  @override
  State<AppShimmerCard> createState() => _AppShimmerCardState();
}

class _AppShimmerCardState extends State<AppShimmerCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _shift;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _shift = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(_shift.value, 0),
              end: Alignment(_shift.value + 1.5, 0),
              colors: [
                widget.baseColor ?? colors.surfaceContainerHighest,
                widget.shimmerColor ??
                    colors.surfaceContainerHighest.withValues(alpha: 0.3),
                widget.baseColor ?? colors.surfaceContainerHighest,
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Pre-built shimmer layouts for common card shapes.
class AppShimmerLayouts extends StatelessWidget {
  final int itemCount;

  const AppShimmerLayouts({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (i) => Padding(
          padding: EdgeInsets.only(bottom: i < itemCount - 1 ? 12 : 0),
          child: Row(
            children: [
              const AppShimmerCard(width: 48, height: 48, borderRadius: 8),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerCard(height: 14, borderRadius: 4),
                    SizedBox(height: 8),
                    AppShimmerCard(height: 10, borderRadius: 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
