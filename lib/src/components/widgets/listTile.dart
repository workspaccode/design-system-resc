import 'package:material_ui/material_ui.dart';

class AppListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool? enabled;
  final Color? backgroundColorContainer;
  final double? borderRadiusNum;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final Offset? shadowOffset;
  final Color? tileColor;
  final double? height;
  final double? width;
  const AppListTile(
      {super.key,
      this.leading,
      this.title,
      this.subtitle,
      this.trailing,
      this.onTap,
      this.enabled,
      this.backgroundColorContainer,
      this.borderRadiusNum,
      this.borderRadius,
      this.border,
      this.boxShadow,
      this.shadowOffset,
      this.tileColor,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColorContainer,
        borderRadius:
            borderRadius ?? BorderRadius.circular(borderRadiusNum ?? 8),
        border: border,
        boxShadow: boxShadow ?? null,
      ),
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
        enabled: enabled ?? true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        style: ListTileStyle.list,
        shape: RoundedRectangleBorder(
          borderRadius:
              borderRadius ?? BorderRadius.circular(borderRadiusNum ?? 8),
        ),
        tileColor: tileColor,
      ),
    );
  }
}

class AppListTileV2 extends StatelessWidget {
  final Widget? leading;

  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool? enabled;
  final Color? backgroundColorContainer;
  final double? borderRadiusNum;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final Offset? shadowOffset;
  final Color? tileColor;
  final EdgeInsetsGeometry? contentPadding;
  final double? height, width;
  const AppListTileV2({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.enabled,
    this.backgroundColorContainer,
    this.borderRadiusNum,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.shadowOffset,
    this.tileColor,
    this.contentPadding,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 64,
      decoration: BoxDecoration(
        color: backgroundColorContainer ?? Colors.white,
        borderRadius:
            borderRadius ?? BorderRadius.circular(borderRadiusNum ?? 8),
        border: border,
        boxShadow: boxShadow ?? null,
      ),
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
        enabled: enabled ?? true,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        style: ListTileStyle.list,
        shape: RoundedRectangleBorder(
          borderRadius:
              borderRadius ?? BorderRadius.circular(borderRadiusNum ?? 8),
        ),
        tileColor: tileColor ?? Colors.white,
      ),
    );
  }
}

class AppListTileV3 extends StatelessWidget {
  final String? subtitle;
  final double width, height;
  final Color backgroundColorContainer;
  final List<BoxShadow> boxShadow;
  final BorderRadius borderRadius;
  final Widget title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? tileColor;
  final TextStyle? subtitleStyle;
  final Widget? switchWidget;
  const AppListTileV3(
      {super.key,
       this.subtitle,
      this.width = 100,
      required this.height,
      required this.backgroundColorContainer,
      required this.boxShadow,
      required this.borderRadius,
      required this.title,
      this.trailing,
      this.onTap,
      this.tileColor,
      this.subtitleStyle, this.switchWidget
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        borderRadius: borderRadius,
        color: backgroundColorContainer,
      ),
      child: ListTile(
        //splashColor: context.themex.primary,
        minTileHeight: 5,
        //tileColor: context.liquidGlassTile.withValues(alpha: 0.5),
        title: title,
        subtitle: subtitle == null
            ? SizedBox.shrink()
            : Text(
                subtitle!,  
                style: subtitleStyle,
              ),
        trailing: switchWidget,
        // subtitle: Text(
        //   subtitle,
        //   style: TextStyle(
        //     fontSize: 12,
        //     fontWeight: FontWeight.bold,
        //     color: colors.textPrimary,
        //   ),
        //),
      ),
    );
  }
}
