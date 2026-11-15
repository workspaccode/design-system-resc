import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;
import 'package:amicons/amicons.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ds.AppScaffold(
      title: 'Cards',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(theme, 'AppCard', children: [
            ds.AppCard(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(Amicons.lucide_image, color: context.colors.neonCyan),
                    const SizedBox(width: 12),
                    Text('Tappable Card', style: theme.textTheme.titleMedium),
                  ]),
                  const SizedBox(height: 8),
                  Text('Standard AppCard with onTap. It has elevation and padding by default.',
                    style: TextStyle(color: context.colors.textSecondary)),
                ],
              ),
            ),
          ]),
          _section(theme, 'AppCard (custom elevation)', children: [
            ds.AppCard(
              elevation: 8,
              padding: const EdgeInsets.all(24),
              child: Row(children: [
                Icon(Amicons.lucide_star, size: 32, color: context.colors.neonOrange),
                const SizedBox(width: 16),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Higher Elevation', style: theme.textTheme.titleMedium),
                    Text('With custom elevation and padding', style: TextStyle(color: context.colors.textSecondary)),
                  ],
                )),
              ]),
            ),
          ]),
          _section(theme, 'AppLiquidGlassCard', children: [
            Wrap(spacing: 12, runSpacing: 12, children: [
              SizedBox(
                width: 170,
                child: ds.AppLiquidGlassCard(
                  onTap: () {},
                  child: Column(children: [
                    Icon(Amicons.lucide_droplets, size: 32, color: context.colors.neonCyan),
                    const SizedBox(height: 8),
                    const Text('Pure Glass', style: TextStyle(fontWeight: FontWeight.w600)),
                    const Text('No packages', style: TextStyle(fontSize: 12)),
                  ]),
                ),
              ),
              SizedBox(
                width: 170,
                child: ds.AppLiquidGlassCard(
                  onTap: () {},
                  gradientColors: [Colors.blue.withValues(alpha: 0.3), Colors.purple.withValues(alpha: 0.1)],
                  child: Column(children: [
                    Icon(Amicons.lucide_star, size: 32, color: context.colors.neonPurple),
                    const SizedBox(height: 8),
                    const Text('Custom Tint', style: TextStyle(fontWeight: FontWeight.w600)),
                    const Text('Any gradient', style: TextStyle(fontSize: 12)),
                  ]),
                ),
              ),
            ]),
          ]),
          _section(theme, 'GlassContainer', children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [context.colors.neonBlue.withValues(alpha: 0.2), context.colors.neonPurple.withValues(alpha: 0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Stack(
                children: [
                  Positioned(
                    top: 8,
                    left: 8,
                    right: 8,
                    bottom: 8,
                    child: ds.GlassContainer(
                      sigma: 6,
                      child: Center(child: Text('GlassContainer with backdrop blur', textAlign: TextAlign.center)),
                    ),
                  ),
                ],
              ),
            ),
          ]),
          _section(theme, 'AppStatusBadge (inline)', children: [
            const Wrap(spacing: 8, runSpacing: 8, children: [
              ds.AppStatusBadge(label: 'Active'),
              ds.AppStatusBadge(label: 'Away'),
              ds.AppStatusBadge(label: 'Busy'),
              ds.AppStatusBadge(label: 'Maintenance'),
            ]),
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
