import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../theme/theme_extensions.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppListView
// ─────────────────────────────────────────────────────────────────────────────

/// Pull-to-refresh ListView with built-in:
/// - Empty state widget when list is empty
/// - Loading skeleton placeholder while data loads
/// - Staggered animation on items via flutter_animate
class AppListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final Widget? emptyState;
  final bool isLoading;
  final Future<void> Function()? onRefresh;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Widget? separator;
  final int skeletonCount;

  const AppListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.emptyState,
    this.isLoading = false,
    this.onRefresh,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.separator,
    this.skeletonCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _AppListSkeleton(
        count: skeletonCount,
        padding: padding,
      );
    }

    if (items.isEmpty) {
      return emptyState ?? const AppEmptyState();
    }

    final listView = separator != null
        ? ListView.separated(
            padding: padding ?? const EdgeInsets.all(0),
            shrinkWrap: shrinkWrap,
            physics: physics,
            itemCount: items.length,
            separatorBuilder: (_, __) => separator!,
            itemBuilder: (ctx, i) => itemBuilder(ctx, items[i], i)
                .animate()
                .fadeIn(delay: (i * 40).ms, duration: 250.ms)
                .slideY(
                  begin: 0.06,
                  end: 0,
                  delay: (i * 40).ms,
                  duration: 250.ms,
                ),
          )
        : ListView.builder(
            padding: padding ?? const EdgeInsets.all(0),
            shrinkWrap: shrinkWrap,
            physics: physics,
            itemCount: items.length,
            itemBuilder: (ctx, i) => itemBuilder(ctx, items[i], i)
                .animate()
                .fadeIn(delay: (i * 40).ms, duration: 250.ms)
                .slideY(
                  begin: 0.06,
                  end: 0,
                  delay: (i * 40).ms,
                  duration: 250.ms,
                ),
          );

    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: onRefresh!,
        color: context.colors.primary,
        backgroundColor: context.colors.surface2,
        child: listView,
      );
    }

    return listView;
  }
}

class _AppListSkeleton extends StatelessWidget {
  final int count;
  final EdgeInsetsGeometry? padding;

  const _AppListSkeleton({required this.count, this.padding});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ListView.builder(
      padding: padding ?? const EdgeInsets.all(0),
      itemCount: count,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: colors.surface2,
            borderRadius: BorderRadius.circular(12),
          ),
        )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .shimmer(
              duration: 1.2.seconds,
              delay: (i * 100).ms,
              color: colors.border.withValues(alpha: 0.6),
            ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppListItem
// ─────────────────────────────────────────────────────────────────────────────

/// Themed ListTile-style row with optional leading icon widget,
/// title, subtitle, and trailing widget. Supports tap and long-press.
class AppListItem extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final bool showDivider;
  final double borderRadius;

  const AppListItem({
    super.key,
    required this.title,
    this.leading,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.backgroundColor,
    this.showDivider = false,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    Widget tile = Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surface2,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: colors.border, width: 0.6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding ??
                const EdgeInsetsDirectional.symmetric(
                    horizontal: 16, vertical: 14),
            child: Row(
              children: [
                if (leading != null) ...[leading!, const SizedBox(width: 14)],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: 12),
                  trailing!,
                ],
              ],
            ),
          ),
        ),
      ),
    );

    if (showDivider) {
      tile = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          tile,
          Divider(height: 1, color: colors.border),
        ],
      );
    }

    return tile;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppSectionHeader
// ─────────────────────────────────────────────────────────────────────────────

/// Bold section heading row with optional "See all" link or custom action.
class AppSectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final EdgeInsetsGeometry? padding;

  const AppSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: padding ??
          const EdgeInsetsDirectional.symmetric(horizontal: 0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
          if (actionLabel != null && onAction != null)
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: colors.primary,
                minimumSize: Size.zero,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                actionLabel!,
                style: TextStyle(
                  color: colors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppEmptyState
// ─────────────────────────────────────────────────────────────────────────────

/// Centered empty state with icon, title, subtitle, and optional CTA button.
/// Use when a list has no data to display.
class AppEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const AppEmptyState({
    super.key,
    this.icon = Icons.inbox_outlined,
    this.title = 'No data found',
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: colors.textSecondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                ),
                child: Text(
                  actionLabel!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .scaleXY(begin: 0.92, end: 1, duration: 400.ms, curve: Curves.easeOut);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppDismissibleItem
// ─────────────────────────────────────────────────────────────────────────────

/// Swipe-to-delete list item wrapper with a themed red dismiss background.
/// Wrap any AppListItem for swipe-to-dismiss behavior.
class AppDismissibleItem extends StatelessWidget {
  final Key dismissKey;
  final Widget child;
  final Future<bool> Function(DismissDirection)? confirmDismiss;
  final void Function(DismissDirection)? onDismissed;
  final String? dismissLabel;

  const AppDismissibleItem({
    super.key,
    required this.dismissKey,
    required this.child,
    this.confirmDismiss,
    this.onDismissed,
    this.dismissLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Dismissible(
      key: dismissKey,
      direction: DismissDirection.endToStart,
      confirmDismiss: confirmDismiss,
      onDismissed: onDismissed,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsetsDirectional.only(end: 20),
        decoration: BoxDecoration(
          color: colors.neonRed.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (dismissLabel != null) ...[
              Text(
                dismissLabel!,
                style: TextStyle(
                  color: colors.neonRed,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Icon(Icons.delete_outline, color: colors.neonRed, size: 24),
          ],
        ),
      ),
      child: child,
    );
  }
}
