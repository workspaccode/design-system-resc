import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;
import 'package:amicons/amicons.dart';

class ButtonsPage extends StatefulWidget {
  const ButtonsPage({super.key});

  @override
  State<ButtonsPage> createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> {
  bool _toggleValue = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ds.AppScaffold(
      title: 'Buttons',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(theme, 'AppButton Variants', children: [
            Wrap(spacing: 8, runSpacing: 8, children: [
              _appBtn(onPressed: () {}, variant: ds.AppButtonVariant.primary, label: 'Primary'),
              _appBtn(onPressed: () {}, variant: ds.AppButtonVariant.secondary, label: 'Secondary'),
              _appBtn(onPressed: () {}, variant: ds.AppButtonVariant.outlined, label: 'Outlined'),
              _appBtn(onPressed: () {}, variant: ds.AppButtonVariant.text, label: 'Text'),
              _appBtn(onPressed: () {}, variant: ds.AppButtonVariant.tonal, label: 'Tonal'),
            ]),
          ]),
          _section(theme, 'AppButton Sizes', children: [
            Wrap(spacing: 8, runSpacing: 8, children: [
              _appBtn(onPressed: () {}, size: ds.AppButtonSize.sm, label: 'Small'),
              _appBtn(onPressed: () {}, size: ds.AppButtonSize.md, label: 'Medium'),
              _appBtn(onPressed: () {}, size: ds.AppButtonSize.lg, label: 'Large'),
            ]),
          ]),
          _section(theme, 'AppButton with Icons', children: [
            _appBtn(onPressed: () {}, icon: Amicons.lucide_arrow_right, label: 'Next'),
            const SizedBox(height: 8),
            _appBtn(onPressed: () {}, variant: ds.AppButtonVariant.outlined, icon: Amicons.iconly_download_broken, label: 'Download'),
            const SizedBox(height: 8),
            _appBtn(onPressed: () {}, expanded: true, icon: Amicons.iconly_send_fill, label: 'Full Width'),
          ]),
          _section(theme, 'AppIconButton', children: [
            Wrap(spacing: 8, runSpacing: 8, children: [
              ds.AppIconButton(icon: Amicons.lucide_pen, onPressed: () {}),
              ds.AppIconButton(icon: Amicons.lucide_trash2, variant: ds.AppIconButtonVariant.danger, onPressed: () {}),
              ds.AppIconButton(icon: Amicons.lucide_star, variant: ds.AppIconButtonVariant.neon, onPressed: () {}),
              ds.AppIconButton(icon: Amicons.lucide_settings2, variant: ds.AppIconButtonVariant.glass, onPressed: () {}),
              ds.AppIconButton.neon(icon: Amicons.lucide_pen_tool, onPressed: () {}),
              ds.AppIconButton.danger(icon: Amicons.lucide_x, onPressed: () {}),
              ds.AppIconButton.glass(icon: Amicons.lucide_eye, onPressed: () {}),
            ]),
          ]),
          _section(theme, 'AppTextButton', children: [
            Wrap(spacing: 8, runSpacing: 8, children: [
              ds.AppTextButton(text: 'Normal', onPressed: () {}),
              ds.AppTextButton(text: 'With Icon', leadingIcon: Amicons.lucide_arrow_right, onPressed: () {}),
              ds.AppTextButton.danger(text: 'Danger', onPressed: () {}),
            ]),
          ]),
          _section(theme, 'AppOutlineButton', children: [
            ds.AppOutlineButton(text: 'Default', onPressed: () {}),
            const SizedBox(height: 8),
            ds.AppOutlineButton(text: 'With Icon', icon: Amicons.lucide_download, onPressed: () {}),
            const SizedBox(height: 8),
            ds.AppOutlineButton.danger(text: 'Danger Outline', onPressed: () {}),
          ]),
          _section(theme, 'AppFAB', children: [
            Wrap(spacing: 16, runSpacing: 16, children: [
              ds.AppFAB(icon: Amicons.lucide_plus, onPressed: () {}),
              ds.AppFAB(icon: Amicons.lucide_plus, label: 'Create', isExtended: true, onPressed: () {}),
              ds.AppFAB(icon: Amicons.lucide_heart, isPulseEnabled: true, onPressed: () {}),
            ]),
          ]),
          _section(theme, 'AppToggleButton', children: [
            ds.AppToggleButton(
              label: 'Notifications',
              subtitle: 'Receive push notifications',
              value: _toggleValue,
              onChanged: (v) => setState(() => _toggleValue = v),
              icon: Amicons.lucide_bell,
            ),
            const SizedBox(height: 8),
            ds.AppToggleButton(
              label: 'Dark Mode',
              subtitle: 'Toggle dark theme',
              value: true,
              onChanged: (_) {},
              icon: Amicons.lucide_moon,
            ),
          ]),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _appBtn({
    required VoidCallback onPressed,
    ds.AppButtonVariant variant = ds.AppButtonVariant.primary,
    ds.AppButtonSize size = ds.AppButtonSize.md,
    IconData? icon,
    String label = '',
    bool expanded = false,
  }) {
    return ds.AppButton(
      onPressed: onPressed,
      variant: variant,
      size: size,
      icon: icon,
      expanded: expanded,
      child: Text(label),
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
