import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;
import 'package:amicons/amicons.dart';

class ScaffoldsPage extends StatefulWidget {
  const ScaffoldsPage({super.key});

  @override
  State<ScaffoldsPage> createState() => _ScaffoldsPageState();
}

class _ScaffoldsPageState extends State<ScaffoldsPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ds.AppScaffold(
      title: 'Scaffolds',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(theme, 'AppScaffold (current page)', children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colors.surface2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('You\'re looking at it!', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text('This page uses AppScaffold with title, actions, and body.',
                    style: TextStyle(color: context.colors.textSecondary, fontSize: 13)),
                ],
              ),
            ),
          ]),
          _section(theme, 'AppSliverScaffold', children: [
            ds.AppCard(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const _SliverDemo())),
              child: Row(children: [
                Icon(Amicons.lucide_layout_dashboard, color: context.colors.neonGreen),
                const SizedBox(width: 12),
                Expanded(child: Text('Open Sliver Scaffold Demo', style: theme.textTheme.titleMedium)),
                Icon(Amicons.lucide_chevron_right, color: context.colors.textDim, size: 20),
              ]),
            ),
          ]),
          _section(theme, 'AppTabScaffold', children: [
            ds.AppCard(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const _TabDemo())),
              child: Row(children: [
                Icon(Amicons.lucide_notebook_tabs, color: context.colors.neonBlue),
                const SizedBox(width: 12),
                Expanded(child: Text('Open Tab Scaffold Demo', style: theme.textTheme.titleMedium)),
                Icon(Amicons.lucide_chevron_right, color: context.colors.textDim, size: 20),
              ]),
            ),
          ]),
          _section(theme, 'AppNestedScrollScaffold', children: [
            ds.AppCard(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const _NestedScrollDemo())),
              child: Row(children: [
                Icon(Amicons.lucide_layout_panel_top, color: context.colors.neonPurple),
                const SizedBox(width: 12),
                Expanded(child: Text('Open Nested Scroll Demo', style: theme.textTheme.titleMedium)),
                Icon(Amicons.lucide_chevron_right, color: context.colors.textDim, size: 20),
              ]),
            ),
          ]),
          _section(theme, 'AppScaffold with BottomNav', children: [
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: context.colors.surface2,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _navItem(0, Amicons.lucide_layout_dashboard, 'Home'),
                  _navItem(1, Amicons.lucide_search, 'Search'),
                  _navItem(2, Amicons.lucide_bell, 'Alerts'),
                  _navItem(3, Amicons.lucide_user, 'Profile'),
                ],
              ),
            ),
          ]),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final selected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: selected ? context.colors.primary : context.colors.textDim, size: 22),
          Text(label, style: TextStyle(
            fontSize: 10,
            color: selected ? context.colors.primary : context.colors.textDim,
          )),
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

class _SliverDemo extends StatelessWidget {
  const _SliverDemo();

  @override
  Widget build(BuildContext context) {
    return ds.AppSliverScaffold(
      title: const Text('Sliver Scaffold'),
      expandedHeight: 200,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.colors.primary, context.colors.neonGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      pinned: true,
      actions: [
        IconButton(icon: const Icon(Amicons.lucide_search), onPressed: () {}),
        IconButton(icon: const Icon(Amicons.lucide_menu), onPressed: () {}),
      ],
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Flexible Space', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                const Text('The app bar collapses as you scroll. This uses CustomScrollView + SliverAppBar.'),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          delegate: SliverChildListDelegate(
            List.generate(9, (i) => Container(
              decoration: BoxDecoration(
                color: context.colors.surface2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Text('${i + 1}')),
            )),
          ),
        ),
      ],
    );
  }
}

class _TabDemo extends StatelessWidget {
  const _TabDemo();

  @override
  Widget build(BuildContext context) {
    return ds.AppTabScaffold(
      title: const Text('Tab Scaffold'),
      tabs: const [
        Tab(icon: Icon(Amicons.iconly_home), text: 'Home'),
        Tab(icon: Icon(Amicons.lucide_search), text: 'Search'),
        Tab(icon: Icon(Amicons.iconly_user_2), text: 'Profile'),
      ],
      tabViews: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: List.generate(6, (i) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ds.AppCard(
              child: ListTile(
                leading: CircleAvatar(child: Text('${i + 1}')),
                title: Text('Home Item ${i + 1}'),
                subtitle: const Text('Tap to explore'),
              ),
            ),
          )),
        ),
        const Center(child: Text('Search Tab', style: TextStyle(fontSize: 24))),
        const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://i.pravatar.cc/80')),
              SizedBox(height: 16),
              Text('Profile Tab', style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ],
    );
  }
}

class _NestedScrollDemo extends StatelessWidget {
  const _NestedScrollDemo();

  @override
  Widget build(BuildContext context) {
    return ds.AppNestedScrollScaffold(
      title: const Text('Nested Scroll'),
      expandedHeight: 180,
      flexibleBackground: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.colors.neonPurple, context.colors.neonBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Text('Profile', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
        ),
      ),
      tabs: const [
        Tab(text: 'Posts'),
        Tab(text: 'Media'),
        Tab(text: 'Settings'),
      ],
      tabViews: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: List.generate(8, (i) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ds.AppCard(child: ListTile(
              leading: CircleAvatar(child: Text('${i + 1}')),
              title: Text('Post ${i + 1}'),
              subtitle: const Text('Scrollable content'),
            )),
          )),
        ),
        GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          padding: const EdgeInsets.all(8),
          children: List.generate(12, (i) => Container(
            decoration: BoxDecoration(
              color: context.colors.surface2,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text('${i + 1}')),
          )),
        ),
        ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            ListTile(leading: Icon(Amicons.lucide_bell), title: Text('Notifications')),
            Divider(),
            ListTile(leading: Icon(Amicons.lucide_shield_alert), title: Text('Privacy')),
            Divider(),
            ListTile(leading: Icon(Amicons.lucide_circle_help), title: Text('Help')),
          ],
        ),
      ],
    );
  }
}
