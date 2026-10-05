import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;
import 'package:amicons/amicons.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;
  bool _showLabels = false;
  bool _showBadges = false;
  bool _glassEffect = true;
  bool _isRtl = false;

  late List<ds.LiquidNavItem> _items;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _items = [
    const ds.LiquidNavItem(
      icon: Amicons.iconly_home,
      activeIcon: Amicons.iconly_home,
      label: 'Home',
    ),
    const ds.LiquidNavItem(
      icon: Amicons.lucide_search,
      activeIcon: Amicons.lucide_search,
      label: 'Search',
    ),
    const ds.LiquidNavItem(
      icon: Amicons.lucide_heart,
      activeIcon: Amicons.lucide_heart,
      label: 'Favorites',
    ),
    const ds.LiquidNavItem(
      icon: Amicons.lucide_bell,
      activeIcon: Amicons.lucide_bell,
      label: 'Alerts',
    ),
    const ds.LiquidNavItem(
      icon: Amicons.lucide_user,
      activeIcon: Amicons.lucide_user,
      label: 'Profile',
    ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;

    if (_pages.isEmpty) {
      _pages = [
        _tabPage('Home', Amicons.iconly_home, colors.neonGreen),
        _tabPage('Search', Amicons.lucide_search, colors.neonBlue),
        _tabPage('Favorites', Amicons.lucide_heart, colors.neonRed),
        _tabPage('Alerts', Amicons.lucide_bell, colors.neonOrange),
        _tabPage('Profile', Amicons.lucide_user, colors.neonPurple),
      ];
    }

    final badges = _showBadges ? <int, int>{2: 3, 3: 12, 4: 1} : null;

    return Directionality(
      textDirection: _isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: ds.AppScaffold(
        title: 'Liquid Navigation',
        body: Column(
          children: [
            Expanded(child: _pages[_currentIndex]),
          Container(
            color: colors.surface,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Options', style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _toggleChip('Labels', _showLabels, (v) => setState(() => _showLabels = v)),
                    const SizedBox(width: 8),
                    _toggleChip('Badges', _showBadges, (v) => setState(() => _showBadges = v)),
                    const SizedBox(width: 8),
                    _toggleChip('Glass', _glassEffect, (v) => setState(() => _glassEffect = v)),
                    const SizedBox(width: 8),
                    _toggleChip('RTL', _isRtl, (v) => setState(() => _isRtl = v)),
                  ],
                ),
              ],
            ),
          ),
            ds.LiquidBottomNavBar(
              currentIndex: _currentIndex,
              items: _items,
              onTap: (i) => setState(() => _currentIndex = i),
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final item = _items.removeAt(oldIndex);
                  _items.insert(newIndex, item);

                  final page = _pages.removeAt(oldIndex);
                  _pages.insert(newIndex, page);

                  if (_currentIndex == oldIndex) {
                    _currentIndex = newIndex;
                  } else if (_currentIndex > oldIndex && _currentIndex <= newIndex) {
                    _currentIndex--;
                  } else if (_currentIndex < oldIndex && _currentIndex >= newIndex) {
                    _currentIndex++;
                  }
                });
              },
              badges: badges,
              showLabel: _showLabels,
              blurSigma: _glassEffect ? 16 : 0,
              height: 76,
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabPage(String label, IconData icon, Color color) {
    final theme = Theme.of(context);
    final colors = context.colors;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 36),
          ),
          const SizedBox(height: 16),
          Text(label, style: theme.textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(
            'Tab $_currentIndex selected',
            style: TextStyle(color: colors.textSecondary, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _toggleChip(String label, bool active, ValueChanged<bool> onChanged) {
    final colors = context.colors;
    return GestureDetector(
      onTap: () => onChanged(!active),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? colors.primary.withValues(alpha: 0.15) : colors.surface2,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: active ? colors.primary : colors.border,
            width: 0.8,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: active ? colors.primary : colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
