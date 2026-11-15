import 'package:material_ui/material_ui.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;

  final double? size;
  final double? width;
  final double? height;
  final Color? color;
  final double? weight;
  final double? grade;
  final double? opticalSize;
  final String? semanticLabel;
  final List<Shadow>? shadows;
  final bool? applyTextScaling;
  final double? fill;
  final FontWeight? fontWeight;
  final TextDirection? textDirection;
  final bool? isShowContainerBackground;
  final Color? containerBackgroundColor;
  final BorderRadius? containerBorderRadius;
  final List<BoxShadow>? containerBoxShadow;
  //final bool? matchTextDirection;
    
  const IconWidget(
      {super.key,
      required this.icon,
      this.size,
      this.width,
      this.height,
      this.color,
      this.weight,
      this.grade,
      this.opticalSize,
      this.semanticLabel,
      this.shadows,
      this.applyTextScaling,
      this.fill,
      this.fontWeight,
      this.textDirection,
      this.isShowContainerBackground = false,
      this.containerBackgroundColor,
      this.containerBorderRadius,
      this.containerBoxShadow,
      // this.matchTextDirection
      });

  @override
  Widget build(BuildContext context) {
    return  isShowContainerBackground! ? Container(
      width: width ?? 24,
      height: height ?? 24,
      decoration: BoxDecoration(
        color: containerBackgroundColor ?? Colors.grey[200],
        borderRadius: containerBorderRadius ?? BorderRadius.circular(8),
        boxShadow: containerBoxShadow ?? [],
      ),
      child: Icon(
        icon,
        size: size ?? 24,
        color: color ?? Colors.black,
        weight: weight ?? 400,
        fill: fill ?? 3,
        textDirection: textDirection ?? TextDirection.ltr,
        fontWeight: fontWeight ?? FontWeight.w400,
        grade: grade ?? 0,
        opticalSize: opticalSize ?? 24,
        semanticLabel: semanticLabel ?? icon.toString(),
        shadows: shadows ?? [],
        applyTextScaling: applyTextScaling ?? false,
        // matchTextDirection: matchTextDirection ?? false,
      ),
    ) : Icon(
      icon,
      size: size ?? 24,
      color: color ?? Colors.black,
      weight: weight ?? 400,
      fill: fill ?? 3,
      textDirection: textDirection ?? TextDirection.ltr,
      fontWeight: fontWeight ?? FontWeight.w400,
      grade: grade ?? 0,
      opticalSize: opticalSize ?? 24,
      semanticLabel: semanticLabel ?? icon.toString(),
      shadows: shadows ?? [],
      applyTextScaling: applyTextScaling ?? false,
      // matchTextDirection: matchTextDirection ?? false,
    );
  }
}
