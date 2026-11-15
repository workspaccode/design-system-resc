import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;
import 'package:amicons/amicons.dart';

class ContainersPage extends StatelessWidget {
  const ContainersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ds.AppScaffold(
      title: 'Containers',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ShowcaseSection(
            title: 'AppContainer',
            subtitle: 'Themed container with optional tap',
            child: ds.AppContainer(
              child: Text('Basic container with default padding and surface2 color'),
            ),
          ),
          ds.AppSpacer.md(),
          ShowcaseSection(
            title: 'AppContainer (neon)',
            subtitle: 'Glowing neon container',
            child: ds.AppContainer.neon(
              neonColor: context.colors.neonGreen,
              child: const Text('Neon glow container with green shadow'),
            ),
          ),
          ds.AppSpacer.md(),
          ShowcaseSection(
            title: 'AppContainer (surface)',
            subtitle: 'Surface container with border',
            child: ds.AppContainer.surface(
              child: const Text('Surface variation with border enabled'),
            ),
          ),
          ds.AppSpacer.md(),
          ShowcaseSection(
            title: 'AppSection',
            subtitle: 'Section with title and content',
            child: ds.AppSection(
              title: 'Section Title',
              trailing: TextButton(onPressed: () {}, child: const Text('View All')),
              child: const Text('Section body content goes here with proper padding.'),
            ),
          ),
          ds.AppSpacer.md(),
          const ShowcaseSection(
            title: 'AppDivider',
            subtitle: 'Themed horizontal divider',
            child: Column(
              children: [
                Text('Above divider'),
                ds.AppDivider(),
                Text('Below divider'),
              ],
            ),
          ),
          ds.AppSpacer.md(),
          ShowcaseSection(
            title: 'AppSpacer',
            subtitle: 'Named spacing widgets',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(spacing: 4, runSpacing: 4, children: [
                  _SpacerDemo(label: 'xs', spacer: ds.AppSpacer.xs()),
                  _SpacerDemo(label: 'sm', spacer: ds.AppSpacer.sm()),
                  _SpacerDemo(label: 'md', spacer: ds.AppSpacer.md()),
                  _SpacerDemo(label: 'lg', spacer: ds.AppSpacer.lg()),
                  _SpacerDemo(label: 'xl', spacer: ds.AppSpacer.xl()),
                  _SpacerDemo(label: 'xxl', spacer: ds.AppSpacer.xxl()),
                ]),
                ds.AppSpacer.sm(),
                Row(children: [
                  Container(width: 40, height: 4, color: context.colors.neonCyan),
                  ds.AppSpacer.md(horizontal: true),
                  Container(width: 40, height: 4, color: context.colors.neonGreen),
                  ds.AppSpacer.md(horizontal: true),
                  Container(width: 40, height: 4, color: context.colors.neonPurple),
                ]),
              ],
            ),
          ),
          ds.AppSpacer.md(),
          ShowcaseSection(
            title: 'AppStatusBadge',
            subtitle: 'Colored pill badges for status',
            child: Wrap(spacing: 8, runSpacing: 8, children: [
              const ds.AppStatusBadge(label: 'Online'),
              const ds.AppStatusBadge(label: 'Offline'),
              const ds.AppStatusBadge(label: 'Warning'),
              const ds.AppStatusBadge(label: 'Error'),
              const ds.AppStatusBadge(label: 'Info'),
              ds.AppStatusBadge(label: 'Custom', customColor: context.colors.neonPurple),
              const ds.AppStatusBadge(label: 'With Icon', icon: Amicons.lucide_star),
              ds.AppStatusBadge.online('Active'),
              ds.AppStatusBadge.offline('Away'),
              ds.AppStatusBadge.warning('Pending'),
              ds.AppStatusBadge.error('Failed'),
            ]),
          ),
          ds.AppSpacer.md(),
          const ShowcaseSection(
            title: 'AppGlassPanel',
            subtitle: 'Glassmorphism panel with blur',
            child: ds.AppGlassPanel(
              height: 120,
              child: Center(child: Text('Frosted glass panel with backdrop blur')),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpacerDemo extends StatelessWidget {
  final String label;
  final Widget spacer;
  const _SpacerDemo({required this.label, required this.spacer});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 20,
          decoration: BoxDecoration(
            color: context.colors.neonBlue.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(child: Text(label, style: const TextStyle(fontSize: 9))),
        ),
        spacer,
        Text(label, style: const TextStyle(fontSize: 9)),
      ],
    );
  }
}

class ShowcaseSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const ShowcaseSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        )),
        const SizedBox(height: 2),
        Text(subtitle, style: TextStyle(
          fontSize: 12,
          color: context.colors.textDim,
        )),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
