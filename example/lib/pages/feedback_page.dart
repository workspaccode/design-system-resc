import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;
import 'package:amicons/amicons.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ds.AppScaffold(
      title: 'Feedback',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(theme, 'AppText', children: [
            ds.AppContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ds.AppText(text: 'Basic text with animation', value: 8),
                  ds.AppSpacer.sm(),
                  const ds.AppText(
                    text: 'Fade In Animation',
                    value: 8,
                    animationType: ds.AnimationType.fadeIn,
                    animationDuration: 600,
                  ),
                  ds.AppSpacer.sm(),
                  const ds.AppText(
                    text: 'Slide In Animation',
                    value: 8,
                    animationType: ds.AnimationType.slideIn,
                    animationDuration: 600,
                  ),
                  ds.AppSpacer.sm(),
                  const ds.AppText(
                    text: 'Scale In Animation',
                    value: 8,
                    animationType: ds.AnimationType.scaleIn,
                    animationDuration: 600,
                  ),
                ],
              ),
            ),
          ]),
          _section(theme, 'Dialogs', children: [
            ds.AppCard(
              onTap: () => _showConfirmDialog(context),
              child: ListTile(
                leading: Icon(Amicons.lucide_circle_check, color: context.colors.neonGreen),
                title: const Text('Confirm Dialog'),
                trailing: Icon(Amicons.lucide_chevron_right, color: context.colors.textDim, size: 20),
              ),
            ),
            const SizedBox(height: 8),
            ds.AppCard(
              onTap: () => _showInfoDialog(context),
              child: ListTile(
                leading: Icon(Amicons.lucide_info, color: context.colors.neonBlue),
                title: const Text('Info Dialog'),
                trailing: Icon(Amicons.lucide_chevron_right, color: context.colors.textDim, size: 20),
              ),
            ),
            const SizedBox(height: 8),
            ds.AppCard(
              onTap: () => _showDangerDialog(context),
              child: ListTile(
                leading: Icon(Amicons.lucide_circle_alert, color: context.colors.neonRed),
                title: const Text('Danger Confirm Dialog'),
                trailing: Icon(Amicons.lucide_chevron_right, color: context.colors.textDim, size: 20),
              ),
            ),
          ]),
          _section(theme, 'Bottom Sheets', children: [
            ds.AppCard(
              onTap: () => _showBottomSheet(context),
              child: ListTile(
                leading: Icon(Amicons.lucide_panel_bottom, color: context.colors.neonPurple),
                title: const Text('Show Bottom Sheet'),
                trailing: Icon(Amicons.lucide_chevron_right, color: context.colors.textDim, size: 20),
              ),
            ),
          ]),
          _section(theme, 'SnackBars', children: [
            ds.AppCard(
              onTap: () => ds.AppSnackBarHelper.success(context, 'Operation completed!'),
              child: ListTile(
                leading: Icon(Amicons.lucide_circle_check, color: context.colors.neonGreen),
                title: const Text('Success SnackBar'),
                trailing: Icon(Amicons.lucide_chevron_right, color: context.colors.textDim, size: 20),
              ),
            ),
            const SizedBox(height: 8),
            ds.AppCard(
              onTap: () => ds.AppSnackBarHelper.error(context, 'Something went wrong!'),
              child: ListTile(
                leading: Icon(Amicons.lucide_circle_x, color: context.colors.neonRed),
                title: const Text('Error SnackBar'),
                trailing: Icon(Amicons.lucide_chevron_right, color: context.colors.textDim, size: 20),
              ),
            ),
            const SizedBox(height: 8),
            ds.AppCard(
              onTap: () => ds.AppSnackBarHelper.info(context, 'Here is some information.'),
              child: ListTile(
                leading: Icon(Amicons.lucide_info, color: context.colors.neonBlue),
                title: const Text('Info SnackBar'),
                trailing: Icon(Amicons.lucide_chevron_right, color: context.colors.textDim, size: 20),
              ),
            ),
            const SizedBox(height: 8),
            ds.AppCard(
              onTap: () => ds.AppSnackBarHelper.warning(context, 'This is a warning message!'),
              child: ListTile(
                leading: Icon(Amicons.lucide_circle_alert, color: context.colors.neonOrange),
                title: const Text('Warning SnackBar'),
                trailing: Icon(Amicons.lucide_chevron_right, color: context.colors.textDim, size: 20),
              ),
            ),
          ]),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<void> _showConfirmDialog(BuildContext context) async {
    final confirmed = await ds.AppDialogHelper.confirm(
      context,
      title: 'Confirm Action',
      message: 'Are you sure you want to proceed with this action?',
      confirmLabel: 'Confirm',
      cancelLabel: 'Cancel',
    );
    if (confirmed == true && context.mounted) {
      ds.AppSnackBarHelper.success(context, 'Action confirmed!');
    }
  }

  Future<void> _showInfoDialog(BuildContext context) async {
    await ds.AppDialogHelper.info(
      context,
      title: 'Information',
      message: 'This is an informational dialog. It shows relevant details about the current state.',
      closeLabel: 'Got it',
    );
  }

  Future<void> _showDangerDialog(BuildContext context) async {
    final confirmed = await ds.AppDialogHelper.confirm(
      context,
      title: 'Delete Item',
      message: 'This action cannot be undone. The item will be permanently deleted.',
      confirmLabel: 'Delete',
      cancelLabel: 'Keep',
      isDanger: true,
    );
    if (confirmed == true && context.mounted) {
      ds.AppSnackBarHelper.error(context, 'Item deleted!');
    }
  }

  Future<void> _showBottomSheet(BuildContext context) async {
    await ds.AppBottomSheetHelper.show(
      context,
      title: 'Options',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (i) => ListTile(
          leading: Icon([Amicons.lucide_pen, Amicons.lucide_share, Amicons.lucide_download, Amicons.lucide_star, Amicons.lucide_trash2][i]),
          title: Text(['Edit', 'Share', 'Download', 'Favorite', 'Delete'][i]),
          onTap: () => Navigator.pop(context),
        )),
      ),
    );
  }

  Widget _section(ThemeData theme, String title, {required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
