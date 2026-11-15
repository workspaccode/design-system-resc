import 'package:material_ui/material_ui.dart';

/// A button that requires the user to swipe a thumb slider to
/// confirm a destructive or important action.
class AppSwipeToConfirm extends StatefulWidget {
  final VoidCallback onConfirmed;
  final String label;
  final String confirmingLabel;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? thumbColor;
  final Color? progressColor;
  final Color? textColor;

  const AppSwipeToConfirm({
    super.key,
    required this.onConfirmed,
    this.label = 'Swipe to confirm',
    this.confirmingLabel = 'Confirming\u2026',
    this.height = 56,
    this.borderRadius = 28,
    this.backgroundColor,
    this.thumbColor,
    this.progressColor,
    this.textColor,
  });

  @override
  State<AppSwipeToConfirm> createState() => _AppSwipeToConfirmState();
}

class _AppSwipeToConfirmState extends State<AppSwipeToConfirm> {
  double _dragX = 0;
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
      final thumbSize = widget.height - 8;
      final maxDrag = maxWidth - thumbSize - 8.0;
      final progress = maxDrag > 0 ? (_dragX / maxDrag).clamp(0.0, 1.0) : 0.0;

      return Container(
        width: maxWidth,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? colors.errorContainer,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.progressColor ?? colors.error,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
              ),
            ),
            Center(
              child: Text(
                _confirmed ? 'Confirmed!' : widget.label,
                style: TextStyle(
                  color: widget.textColor ?? colors.onError,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 4,
              top: 4,
              bottom: 4,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (_confirmed) return;
                  setState(() {
                    _dragX = (_dragX + details.delta.dx).clamp(0.0, maxDrag);
                  });
                },
                onHorizontalDragEnd: (_) {
                  if (_confirmed) return;
                  if (progress >= 0.95) {
                    setState(() {
                      _confirmed = true;
                      _dragX = maxDrag;
                    });
                    widget.onConfirmed();
                  } else {
                    setState(() => _dragX = 0);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: thumbSize,
                  height: thumbSize,
                  decoration: BoxDecoration(
                    color: widget.thumbColor ?? colors.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    _confirmed
                        ? Icons.check_rounded
                        : Icons.chevron_right_rounded,
                    color: _confirmed ? Colors.green : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
