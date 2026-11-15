import 'package:amicons/amicons.dart';
import 'package:design_system_example/pages/animated_liquid_border_page.dart';
import 'package:design_system_example/pages/data_preview_card_page.dart';
import 'package:design_system_example/pages/liquid_mono_background_page.dart';
import 'package:design_system_example/pages/loading_animation_page.dart';
import 'package:design_system_example/pages/screen_background_animated_page.dart';
import 'package:design_system_example/pages/thermometer_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;

import 'buttons_page.dart';
import 'cards_page.dart';
import 'containers_page.dart';
import 'feedback_page.dart';
import 'fields_page.dart';
import 'indicators_page.dart';
import 'lists_page.dart';
import 'navigation_page.dart';
import 'scaffolds_page.dart';

class AppHeader extends StatelessWidget {
  final BuildContext context;
  const AppHeader({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ds.AppContainer(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: context.colors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(Amicons.lucide_blocks,
                        color: context.colors.primary, size: 28),
                  ),
                  ds.AppSpacer.md(horizontal: true),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Design System',
                            style: theme.textTheme.headlineLarge),
                        Text('Widget Showcase',
                            style: TextStyle(
                              color: context.colors.textSecondary,
                              fontSize: 14,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              ds.AppSpacer.md(),
              Text(
                'Complete demonstration of all components from the Flutter Design System package.',
                style: TextStyle(
                    color: context.colors.textSecondary, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const HomePage(
      {super.key, required this.onToggleTheme, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final sections = <_Section>[
      _Section(
        icon: Amicons.lucide_box,
        label: 'Containers',
        desc: 'AppContainer, GlassPanel, StatusBadge, Spacer, Section, Divider',
        color: context.colors.neonCyan,
        page: const ContainersPage(),
      ),
      _Section(
        icon: Amicons.lucide_rectangle_vertical,
        label: 'Buttons',
        desc: 'AppButton, IconButton, TextButton, OutlineButton, FAB, Toggle',
        color: context.colors.neonGreen,
        page: const ButtonsPage(),
      ),
      _Section(
        icon: Amicons.lucide_text_cursor_input,
        label: 'Form Fields',
        desc:
            'TextField, Search, Dropdown, Switch, Slider, Checkbox, Segmented',
        color: context.colors.neonBlue,
        page: const FieldsPage(),
      ),
      _Section(
        icon: Amicons.lucide_circle_gauge,
        label: 'Indicators',
        desc: 'Progress, Badge, PulseDot, StatusChip, ValueIndicator',
        color: context.colors.neonOrange,
        page: const IndicatorsPage(),
      ),
      _Section(
        icon: Amicons.lucide_menu,
        label: 'Lists',
        desc:
            'AppListView, AppListItem, SectionHeader, EmptyState, Dismissible',
        color: context.colors.neonPurple,
        page: const ListsPage(),
      ),
      _Section(
        icon: Amicons.lucide_layout_dashboard,
        label: 'Scaffolds',
        desc: 'AppScaffold, Sliver, Tab, NestedScroll scaffolds',
        color: context.colors.neonGreen,
        page: const ScaffoldsPage(),
      ),
      _Section(
        icon: Amicons.lucide_credit_card,
        label: 'Cards',
        desc: 'AppCard, LiquidGlassCard, GlassContainer',
        color: context.colors.neonCyan,
        page: const CardsPage(),
      ),
      _Section(
        icon: Amicons.lucide_message_square,
        label: 'Feedback',
        desc: 'Dialogs, BottomSheets, SnackBars, AppText',
        color: context.colors.neonOrange,
        page: const FeedbackPage(),
      ),
      _Section(
        icon: Amicons.lucide_waves,
        label: 'Navigation',
        desc: 'LiquidBottomNavBar with physics-based blob animation',
        color: context.colors.neonCyan,
        page: const NavigationPage(),
      ),
      _Section(
        icon: Amicons.lucide_zap,
        label: 'Loading Animation',
        desc: 'PNG frame animations using flutter_animate',
        color: context.colors.neonPurple,
        page: const LoadingAnimationPage(),
      ),
      _Section(
        icon: Amicons.lucide_waves,
        label: 'Animated Background',
        desc: 'Sonar pulse rings, dot variants, and scattered field effects',
        color: context.colors.neonCyan,
        page: const ScreenBackgroundAnimatedPage(),
      ),
      _Section(
        icon: Amicons.lucide_droplets,
        label: 'Liquid Mono Background',
        desc: 'Monochromatic liquid animation with soft blending',
        color: context.colors.neonPurple,
        page: const LiquidMonoBackgroundPage(),
      ),
      _Section(
        icon: Amicons.lucide_hexagon,
        label: 'Animated Liquid Border',
        desc: 'Metallic gradient border with liquid animation',
        color: context.colors.neonCyan,
        page: const AnimatedLiquidBorderPage(),
      ),
      _Section(
        icon: Amicons.lucide_layout_template,
        label: 'Data Preview Card',
        desc: 'Data display cards with value, title, and Lottie animation',
        color: context.colors.neonGreen,
        page: const DataPreviewCardPage(),
      ),
      _Section(
        icon: Amicons.lucide_thermometer,
        label: 'Thermometer Widget',
        desc: 'Interactive temperature display with F and C scales',
        color: context.colors.neonOrange,
        page: const ThermometerPage(),
      ),
      _Section(
        icon: Amicons.lucide_sparkles,
        label: '60 Animations',
        desc: '60 categories — fade, slide, bounce, elastic, text, and more',
        color: context.colors.neonBlue,
        page: const ds.AnimatePage(),
      ),
    ];

    return ds.AppScaffold(
      title: 'Design System',
      backgroundColor: context.AppscaffoldBg,
      showBackButton: false,
      actions: [
        IconButton(
          icon: Icon(isDark ? Amicons.lucide_sun : Amicons.lucide_moon),
          onPressed: onToggleTheme,
          tooltip: 'Toggle theme',
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          AppHeader(context: context),
          ds.AppSpacer.lg(),
          ...sections.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _SectionCard(section: s),
              )),
        ],
      ),
    );
  }
}

class _Section {
  final IconData icon;
  final String label;
  final String desc;
  final Color color;
  final Widget page;
  const _Section({
    required this.icon,
    required this.label,
    required this.desc,
    required this.color,
    required this.page,
  });
}

class _SectionCard extends StatelessWidget {
  final _Section section;
  const _SectionCard({required this.section});

  @override
  Widget build(BuildContext context) {
    return ds.AppCard(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => section.page)),
      elevation: 0,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: section.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(section.icon, color: section.color, size: 24),
          ),
          ds.AppSpacer.md(horizontal: true),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(section.label,
                    style: Theme.of(context).textTheme.titleLarge),
                ds.AppSpacer.xxl(),
                Text(section.desc,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: context.colors.textSecondary,
                        )),
              ],
            ),
          ),
          Icon(Amicons.lucide_chevron_right,
              color: context.colors.textDim, size: 20),
        ],
      ),
    );
  }
}
