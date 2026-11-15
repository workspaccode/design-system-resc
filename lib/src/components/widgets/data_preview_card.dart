import 'package:material_ui/material_ui.dart';

///
/// Example usage:
/// DataPreviewCard(
///   title: 'Server Status',
///   value: 'Operational',
///   valueLabel: 'Status',
///   status: 'Online',
///   statusColor: Colors.green,
///   description: 'All systems are running normally',
///   lottieTitle: 'Health',
///   lottieWidget: Lottie.asset('assets/health.json'),
///   leadingWidget: Icon(Icons.server, color: Colors.blue),
/// );
///

class DataPreviewCard extends StatelessWidget {
  final Widget? title;
  final String? titleText;
  final String? value;
  final Widget? lottieTitle;
  final String? lottieTitleText;
  final Widget? lottieWidget;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final TextStyle? lottieTitleStyle;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? elevation;
  final String? valueLabel;
  final String? status;
  final Color? statusColor;
  final String? description;
  final TextStyle? descriptionStyle;
  final Widget? leadingWidget;
  final bool showTitle;
  final Widget? titleWidget;
  final bool showValue;
  final Widget? valueWidget;
  final bool showDescription;
  final Widget? descriptionWidget;
  final Widget? leftWidget;
  final double? height;
  final double? width;
  final bool? isShowWidgetTitle;
  final bool? isShowWidgetLottieTitle;
  const DataPreviewCard({
    super.key,
    this.title,
    this.value,
    this.lottieTitle,
    this.lottieWidget,
    this.backgroundColor,
    this.titleStyle,
    this.valueStyle,
    this.lottieTitleStyle,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.valueLabel,
    this.status,
    this.statusColor,
    this.description,
    this.descriptionStyle,
    this.leadingWidget,
    this.showTitle = true,
    this.titleWidget,
    this.showValue = true,
    this.valueWidget,
    this.showDescription = true,
    this.descriptionWidget,
    this.leftWidget,
    this.height,
    this.width,
    this.titleText,
    this.isShowWidgetTitle,
    this.lottieTitleText,
    this.isShowWidgetLottieTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBackgroundColor = backgroundColor ?? theme.cardColor;

    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: defaultBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Leading widget
          if (leadingWidget != null) ...[
            leadingWidget!,
            const SizedBox(width: 12),
          ],
          // Left side: Title, Value, Description

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title (custom widget or default title row + status chip)
                if (titleWidget != null)
                  titleWidget!
                else if (showTitle) ...[
                  Row(
                    children: [
                      if (isShowWidgetTitle != null &&
                          isShowWidgetTitle == true)
                        title ??
                            Text(
                              titleText ?? "",
                              style: titleStyle ??
                                  theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: theme.colorScheme.onSurface,
                                  ),
                            ),
                      if (status != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor ??
                                theme.colorScheme.primary
                                    .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            status!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: statusColor ?? theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                // Value label and value (or a custom value widget)
                if (leftWidget != null)
                  leftWidget!
                else
                  Column(
                    children: [
                      if (valueWidget != null)
                        valueWidget!
                      else if (showValue) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '$valueLabel: ',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.6),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                value ?? '',
                                style: valueStyle ??
                                    theme.textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                      // Description (custom widget or default text)
                      if (descriptionWidget != null) ...[
                        const SizedBox(height: 4),
                        descriptionWidget!,
                      ] else if (showDescription && description != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          description!,
                          style: descriptionStyle ??
                              theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.6),
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
              ],
            ),
          ),
          // Right side: Lottie animation with title
          if (lottieWidget != null) ...[
            const SizedBox(width: 16),
            SizedBox(
              width: 80,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isShowWidgetLottieTitle == true
                      ? Text(
                          lottieTitleText!,
                          style: lottieTitleStyle ??
                              theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.7),
                              ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      : lottieTitle ?? const SizedBox.shrink(),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: lottieWidget,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class DataPreviewCardCompact extends StatelessWidget {
  final String title;

  final String value;
  final Widget? lottieWidget;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final EdgeInsets padding;
  final double borderRadius;
  final Widget? icon;
  final Widget? leadingWidget;
  final String? status;
  final Color? statusColor;
  final bool showTitle;
  final Widget? valueWidget;
  const DataPreviewCardCompact({
    super.key,
    required this.title,
    required this.value,
    this.lottieWidget,
    this.backgroundColor,
    this.titleStyle,
    this.valueStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.borderRadius = 12,
    this.icon,
    this.leadingWidget,
    this.status,
    this.statusColor,
    this.showTitle = true,
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBackgroundColor = backgroundColor ?? theme.cardColor;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: defaultBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          // Leading widget, Icon or Lottie
          if (leadingWidget != null) ...[
            leadingWidget!,
            const SizedBox(width: 12),
          ] else if (icon != null || lottieWidget != null) ...[
            SizedBox(
              height: 40,
              width: 40,
              child: icon ?? lottieWidget,
            ),
            const SizedBox(width: 12),
          ],
          // Title and Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showTitle) ...[
                  Row(
                    children: [
                      Text(
                        title,
                        style: titleStyle ??
                            theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.7),
                            ),
                      ),
                      if (status != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor ??
                                Colors.grey.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            status!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: statusColor ??
                                  theme.colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
                if (valueWidget != null)
                  valueWidget!
                else
                  Text(
                    value,
                    style: valueStyle ??
                        theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
