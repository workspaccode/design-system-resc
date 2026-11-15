import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../theme/theme_extensions.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppScaffold
// ─────────────────────────────────────────────────────────────────────────────

/// Opinionated app-wide scaffold with:
/// - SafeArea applied
/// - Themed AppBar (title, optional back button, optional actions)
/// - `scaffoldBg` background color from theme extension
/// - Optional floating action button slot
/// - Optional bottom navigation bar slot
class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool showBackButton;
  final VoidCallback? onBack;
  final PreferredSizeWidget? customAppBar;
  final bool resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final Widget? leading;

  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.showBackButton = true,
    this.onBack,
    this.customAppBar,
    this.resizeToAvoidBottomInset = true,
    this.backgroundColor,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final canPop = Navigator.of(context).canPop();

    return Scaffold(
      backgroundColor: backgroundColor ?? context.AppscaffoldBg,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: customAppBar ??
          (title != null
              ? AppBar(
                  backgroundColor: context.AppscaffoldBg,
                  surfaceTintColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    title!,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  leading: leading ??
                      (showBackButton && canPop
                          ? IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: colors.textPrimary,
                                size: 20,
                              ),
                              onPressed: onBack ?? () => Navigator.of(context).pop(),
                            )
                          : null),
                  actions: actions,
                )
              : null),
      body: SafeArea(child: body),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppBottomSheetHelper
// ─────────────────────────────────────────────────────────────────────────────

/// Static helper to show a consistently themed modal bottom sheet.
///
/// ```dart
/// AppBottomSheetHelper.show(
///   context,
///   title: 'Select Protocol',
///   child: ProtocolPicker(),
/// );
/// ```
class AppBottomSheetHelper {
  const AppBottomSheetHelper._();

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool isScrollControlled = true,
    double? maxHeightFraction,
  }) {
    final colors = context.colors;
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (ctx) {
        final Widget sheet = Container(
          constraints: maxHeightFraction != null
              ? BoxConstraints(
                  maxHeight:
                      MediaQuery.of(ctx).size.height * maxHeightFraction,
                )
              : const BoxConstraints(),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            border: Border(
              top: BorderSide(color: colors.border, width: 0.8),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 4),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              if (title != null) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              Flexible(child: child),
              SizedBox(
                height: MediaQuery.of(ctx).viewInsets.bottom,
              ),
            ],
          ),
        );

        return sheet
            .animate()
            .slideY(
              begin: 0.15,
              end: 0,
              duration: 280.ms,
              curve: Curves.easeOut,
            )
            .fadeIn(duration: 200.ms);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppDialogHelper
// ─────────────────────────────────────────────────────────────────────────────

/// Static helper to show a themed AlertDialog with typed action buttons.
///
/// ```dart
/// final confirmed = await AppDialogHelper.confirm(
///   context,
///   title: 'Disconnect Device?',
///   message: 'All live data will stop.',
/// );
/// ```
class AppDialogHelper {
  const AppDialogHelper._();

  static Future<bool?> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDanger = false,
  }) {
    final colors = context.colors;
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: colors.border, width: 0.8),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(color: colors.textSecondary, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              cancelLabel,
              style: TextStyle(color: colors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isDanger ? colors.neonRed : colors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              confirmLabel,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> info(
    BuildContext context, {
    required String title,
    required String message,
    String closeLabel = 'OK',
  }) {
    final colors = context.colors;
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: colors.border, width: 0.8),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(color: colors.textSecondary, fontSize: 14),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              closeLabel,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AppSnackBarHelper
// ─────────────────────────────────────────────────────────────────────────────

/// Static helpers for consistently themed SnackBars.
/// Variants: success, error, info, warning.
///
/// ```dart
/// AppSnackBarHelper.success(context, 'Register updated successfully');
/// AppSnackBarHelper.error(context, 'Connection lost');
/// ```
class AppSnackBarHelper {
  const AppSnackBarHelper._();

  static void success(BuildContext context, String message) =>
      _show(context, message, _SnackType.success);

  static void error(BuildContext context, String message) =>
      _show(context, message, _SnackType.error);

  static void info(BuildContext context, String message) =>
      _show(context, message, _SnackType.info);

  static void warning(BuildContext context, String message) =>
      _show(context, message, _SnackType.warning);

  static void _show(BuildContext context, String message, _SnackType type) {
    final colors = context.colors;
    Color barColor;
    IconData icon;

    switch (type) {
      case _SnackType.success:
        barColor = colors.neonGreen;
        icon = Icons.check_circle_outline;
        break;
      case _SnackType.error:
        barColor = colors.neonRed;
        icon = Icons.error_outline;
        break;
      case _SnackType.warning:
        barColor = colors.neonOrange;
        icon = Icons.warning_amber_rounded;
        break;
      case _SnackType.info:
        barColor = colors.neonBlue;
        icon = Icons.info_outline;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: colors.surface2,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: barColor.withValues(alpha: 0.5)),
          ),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          content: Row(
            children: [
              Icon(icon, color: barColor, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 3),
        ),
      );
  }
}

enum _SnackType { success, error, info, warning }
