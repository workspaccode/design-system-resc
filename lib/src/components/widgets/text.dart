import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../theme/theme_extensions.dart';

enum AnimationType {
  none,
  fadeIn,
  slideIn,
  scaleIn,
}

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.value,
    this.align,
    this.animationType = AnimationType.none,
    this.animationDuration = 300,
    this.showAnimation,
  });
  final String text;
  final double? value;
  final AlignmentGeometry? align;
  final AnimationType animationType;
  final int animationDuration;
  final bool? showAnimation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.all(value ?? 0),
      child: Text(
        text,
        style: TextStyle(
          color: context.colors.textPrimary,
        ),
      ).animate(
        effects: [
          if (animationType == AnimationType.fadeIn) const FadeEffect(),
          if (animationType == AnimationType.slideIn) const SlideEffect(),
          if (animationType == AnimationType.scaleIn) const ScaleEffect(),
        ],
        onPlay: (controller) {
          if (showAnimation == false) {
            controller.reverse(from: 1);
          } else {
            controller.forward(from: 0);
          }
        },
      ),
    );
  }
}