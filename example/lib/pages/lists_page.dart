import 'package:amicons/amicons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  final List<String> _items = List.generate(8, (i) => 'Item ${i + 1}');
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ds.AppScaffold(
      title: 'Lists',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(theme, 'AppSectionHeader', children: [
            ds.AppSectionHeader(
              title: 'Recent Items',
              actionLabel: 'View All',
              onAction: () {},
            ),
            ds.AppSectionHeader(
              title: 'Favorites',
              actionLabel: 'Edit',
              onAction: () {},
            ),
          ]),
          _section(theme, 'AppListItem', children: [
            ds.AppListItem(
              title: 'John Doe',
              subtitle: 'Online',
              leading: const CircleAvatar(child: Icon(Amicons.lucide_user)),
              trailing: Icon(Amicons.lucide_chevron_right,
                  size: 18, color: context.colors.textDim),
              onTap: () {},
            ),
            ds.AppListItem(
              title: 'Settings',
              leading: Icon(Amicons.lucide_settings2,
                  color: context.colors.neonBlue),
              trailing:
                  ds.AppSwitchField(label: '', value: true, onChanged: (_) {}),
              showDivider: true,
            ),
            ds.AppListItem(
              title: 'Notifications',
              leading:
                  Icon(Amicons.lucide_bell, color: context.colors.neonOrange),
              subtitle: '3 new notifications',
              trailing: const ds.AppBadge(count: 3, child: SizedBox()),
              onTap: () {},
              showDivider: true,
            ),
            ds.AppListItem(
              title: 'Long press me',
              subtitle: 'Try long pressing this item',
              leading: Icon(Amicons.lucide_pointer,
                  color: context.colors.neonPurple),
              onLongPress: () {},
            ),
          ]),
          _section(theme, 'AppListView (pull-to-refresh)', children: [
            SizedBox(
              height: 320,
              child: ds.AppListView<String>(
                items: _items,
                isLoading: _isLoading,
                onRefresh: _refresh,
                padding: EdgeInsets.zero,
                itemBuilder: (context, item, index) {
                  return ds.AppListItem(
                    title: item,
                    subtitle: 'Subtitle for $item',
                    leading: CircleAvatar(
                      backgroundColor:
                          context.colors.primary.withValues(alpha: 0.2),
                      child: Text('${index + 1}',
                          style: TextStyle(color: context.colors.primary)),
                    ),
                    trailing: Icon(Amicons.lucide_chevron_right,
                        size: 18, color: context.colors.textDim),
                    onTap: () {},
                  );
                },
              ),
            ),
          ]),
          _section(theme, 'AppEmptyState', children: [
            ds.AppEmptyState(
              icon: Amicons.lucide_inbox,
              title: 'No messages yet',
              subtitle: 'Your inbox is empty. Start a conversation.',
              actionLabel: 'New Message',
              onAction: () {},
            ),
          ]),
          _section(theme, 'AppDismissibleItem', children: [
            ds.AppDismissibleItem(
              dismissKey: const ValueKey('dismiss_demo'),
              child: ds.AppListItem(
                title: 'Swipe to delete',
                subtitle: 'Swipe left on this item',
                leading: Icon(Amicons.remix_drag_move2,
                    color: context.colors.neonRed),
              ),
            ),
          ]),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<void> _refresh() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  Widget _section(ThemeData theme, String title,
      {required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
