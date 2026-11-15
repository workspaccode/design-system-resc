import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;
import 'package:amicons/amicons.dart';

class IndicatorsPage extends StatelessWidget {
  const IndicatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ds.AppScaffold(
      title: 'Indicators',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(theme, 'AppBadge', children: [
            Wrap(spacing: 24, runSpacing: 24, children: [
              const ds.AppBadge(count: 3, child: Icon(Amicons.lucide_bell, size: 28)),
              const ds.AppBadge(count: 99, child: Icon(Amicons.lucide_message_square, size: 28)),
              const ds.AppBadge(count: 150, child: Icon(Amicons.lucide_shopping_cart, size: 28)),
              const ds.AppBadge(visible: true, child: Icon(Amicons.lucide_mail, size: 28)),
              ds.AppBadge(count: 7, color: context.colors.neonBlue, child: const Icon(Amicons.lucide_bell, size: 28)),
            ]),
          ]),
          _section(theme, 'AppCircularProgress', children: [
            Wrap(spacing: 24, runSpacing: 24, crossAxisAlignment: WrapCrossAlignment.center, children: [
              ds.AppCircularProgress.indeterminate(size: 32),
              const ds.AppCircularProgress(value: 0.25, label: '25%', size: 48),
              const ds.AppCircularProgress(value: 0.5, label: '50%', size: 48),
              const ds.AppCircularProgress(value: 0.75, label: '75%', size: 48),
              ds.AppCircularProgress(value: 1.0, label: 'Done', size: 48, color: context.colors.neonGreen),
            ]),
          ]),
          _section(theme, 'AppLinearProgress', children: [
            const ds.AppLinearProgress(value: 0.3, label: 'Storage', trailingLabel: '30%'),
            const SizedBox(height: 12),
            const ds.AppLinearProgress(value: 0.65, label: 'Memory', trailingLabel: '65%'),
            const SizedBox(height: 12),
            const ds.AppLinearProgress(value: 0.9, label: 'CPU', trailingLabel: '90%'),
            const SizedBox(height: 12),
            ds.AppLinearProgress.battery(value: 0.72, label: 'Battery'),
            const SizedBox(height: 12),
            ds.AppLinearProgress.solar(value: 0.45, label: 'Solar'),
          ]),
          _section(theme, 'AppPulseDot', children: [
            Wrap(spacing: 24, runSpacing: 16, crossAxisAlignment: WrapCrossAlignment.center, children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                ds.AppPulseDot.live(size: 12),
                const SizedBox(width: 8),
                const Text('Live'),
              ]),
              Row(mainAxisSize: MainAxisSize.min, children: [
                ds.AppPulseDot.warning(size: 12),
                const SizedBox(width: 8),
                const Text('Warning'),
              ]),
              Row(mainAxisSize: MainAxisSize.min, children: [
                ds.AppPulseDot.fault(size: 12),
                const SizedBox(width: 8),
                const Text('Fault'),
              ]),
              Row(mainAxisSize: MainAxisSize.min, children: [
                ds.AppPulseDot(color: context.colors.neonBlue, size: 12),
                const SizedBox(width: 8),
                const Text('Custom'),
              ]),
            ]),
          ]),
          _section(theme, 'AppStatusChip', children: [
            Wrap(spacing: 8, runSpacing: 8, children: [
              ds.AppStatusChip.connected('Connected'),
              ds.AppStatusChip.disconnected('Disconnected'),
              ds.AppStatusChip.fault('Fault'),
              const ds.AppStatusChip(label: 'Processing', chipColor: ds.AppStatusChipColor.orange),
              const ds.AppStatusChip(label: 'Active', chipColor: ds.AppStatusChipColor.blue),
              const ds.AppStatusChip(label: 'Idle', chipColor: ds.AppStatusChipColor.purple),
              const ds.AppStatusChip(label: 'Offline', chipColor: ds.AppStatusChipColor.dim),
            ]),
          ]),
          _section(theme, 'AppValueIndicator', children: [
            const ds.AppValueIndicator(
              label: 'Temperature',
              value: '23.5',
              unit: '°C',
              icon: Amicons.lucide_thermometer,
            ),
            const ds.AppDivider(),
            ds.AppValueIndicator(
              label: 'Humidity',
              value: '68',
              unit: '%',
              icon: Amicons.lucide_droplets,
              valueColor: context.colors.neonBlue,
            ),
            const ds.AppDivider(),
            ds.AppValueIndicator(
              label: 'Wind Speed',
              value: '12',
              unit: 'km/h',
              icon: Amicons.lucide_wind,
              valueColor: context.colors.neonGreen,
              highlight: true,
            ),
            const ds.AppDivider(),
            ds.AppValueIndicator(
              label: 'CPU Load',
              value: '45',
              unit: '%',
              icon: Amicons.lucide_cpu,
              valueColor: context.colors.neonOrange,
              trailing: const ds.AppLinearProgress(value: 0.45, height: 6),
            ),
          ]),
          const SizedBox(height: 32),
        ],
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
