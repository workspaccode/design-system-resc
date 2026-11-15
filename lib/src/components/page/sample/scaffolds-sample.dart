import 'package:material_ui/material_ui.dart';

/// Page scaffold with a sliver app bar
class AppSliverScaffold extends StatelessWidget {
  const AppSliverScaffold({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.body,
    this.slivers,
    this.bottom,
    this. floating,
    this.pinned = true,
    this.snap = false,
    this. expandedHeight,
    this. flexibleSpace,
    this.backgroundColor,
    this. bottomNavigationBar,
    this. drawer,
    this. endDrawer,
    this. resizeToAvoidBottomInset = true,
  });

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? body;
  final List<Widget>? slivers;
  final PreferredSizeWidget? bottom;
  final bool? floating;
  final bool pinned;
  final bool snap;
  final double? expandedHeight;
  final Widget? flexibleSpace;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      endDrawer: endDrawer,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: title,
            actions: actions,
            leading: leading,
            bottom: bottom,
            floating: floating ?? false,
            pinned: pinned,
            snap: snap,
            expandedHeight: expandedHeight,
            flexibleSpace: flexibleSpace,
            backgroundColor: backgroundColor ?? colors.surface,
            foregroundColor: colors.onSurface,
          ),
          if (body != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: body!,
            ),
          if (slivers != null) ...slivers!,
        ],
      ),
    );
  }
}

/// Scaffold with bottom navigation tabs
class AppTabScaffold extends StatelessWidget {
  const AppTabScaffold({
    super.key,
    required this.tabs,
    required this. tabViews,
    this. initialIndex = 0,
    this. title,
    this. actions,
    this. appBarBottom,
    this. floatingActionButton,
    this. drawer,
    this. endDrawer,
    this. bottomBar,
    this. onTabChanged,
    this. backgroundColor,
  });

  final List<Tab> tabs;
  final List<Widget> tabViews;
  final int initialIndex;
  final Widget? title;
  final List<Widget>? actions;
  final PreferredSizeWidget? appBarBottom;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomBar;
  final ValueChanged<int>? onTabChanged;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndex,
      length: tabs.length,
      child: Builder(
        builder: (context) {
          final controller = DefaultTabController.of(context);
          controller.addListener(() {
            onTabChanged?.call(controller.index);
          });

          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              title: title,
              actions: actions,
              bottom: appBarBottom ?? TabBar(tabs: tabs),
            ),
            body: TabBarView(children: tabViews),
            floatingActionButton: floatingActionButton,
            drawer: drawer,
            endDrawer: endDrawer,
            bottomNavigationBar: bottomBar,
          );
        },
      ),
    );
  }
}

/// Scaffold with nested scroll: sliver app bar + tabs + scrollable content
class AppNestedScrollScaffold extends StatefulWidget {
  const AppNestedScrollScaffold({
    super.key,
    required this.tabs,
    required this. tabViews,
    this. title,
    this. actions,
    this. headerSlivers,
    this. initialIndex = 0,
    this. expandedHeight = 200,
    this. flexibleBackground,
    this. pinned = true,
    this. floating = false,
    this. bottomNavigationBar,
    this. drawer,
    this. endDrawer,
    this. backgroundColor,
    this. onTabChanged,
  });

  final List<Tab> tabs;
  final List<Widget> tabViews;
  final Widget? title;
  final List<Widget>? actions;
  final List<Widget>? headerSlivers;
  final int initialIndex;
  final double expandedHeight;
  final Widget? flexibleBackground;
  final bool pinned;
  final bool floating;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final ValueChanged<int>? onTabChanged;

  @override
  State<AppNestedScrollScaffold> createState() => _AppNestedScrollScaffoldState();
}

class _AppNestedScrollScaffoldState extends State<AppNestedScrollScaffold>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        widget.onTabChanged?.call(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      drawer: widget.drawer,
      endDrawer: widget.endDrawer,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: widget.title,
              actions: widget.actions,
              pinned: widget.pinned,
              floating: widget.floating,
              expandedHeight: widget.expandedHeight,
              flexibleSpace: widget.flexibleBackground != null
                  ? FlexibleSpaceBar(
                      background: widget.flexibleBackground!,
                    )
                  : null,
              bottom: TabBar(
                controller: _tabController,
                tabs: widget.tabs,
              ),
            ),
            if (widget.headerSlivers != null) ...widget.headerSlivers!,
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: widget.tabViews,
        ),
      ),
    );
  }
}
