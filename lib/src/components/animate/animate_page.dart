import 'package:material_ui/material_ui.dart';

import '../../theme/app_theme_extension.dart';
import '../../theme/theme_extensions.dart';
import 'animate_types.dart';
import 'app_animate.dart';

class AnimatePage extends StatelessWidget {
  const AnimatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final groups = <String, List<AppAnimateType>>{};
    for (final type in AppAnimateType.values) {
      groups.putIfAbsent(type.group, () => []).add(type);
    }

    return Scaffold(
      backgroundColor: colors.scaffoldBg,
      appBar: AppBar(
        title: const Text('60 Animations'),
        backgroundColor: colors.surface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${AppAnimateType.values.length} Animation Categories',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Apply to any widget — text, icons, containers — with time or loop control.',
            style: TextStyle(color: colors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 20),
          ...groups.entries.map((entry) => _GroupSection(
            group: entry.key,
            types: entry.value,
          )),
        ],
      ),
    );
  }
}

class _GroupSection extends StatelessWidget {
  final String group;
  final List<AppAnimateType> types;

  const _GroupSection({
    required this.group,
    required this.types,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '$group  ·  ${types.length}',
              style: TextStyle(
                color: colors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: types.map((type) => _AnimatePreview(type: type)).toList(),
          ),
        ],
      ),
    );
  }
}

class _AnimatePreview extends StatefulWidget {
  final AppAnimateType type;

  const _AnimatePreview({required this.type});

  @override
  State<_AnimatePreview> createState() => _AnimatePreviewState();
}

class _AnimatePreviewState extends State<_AnimatePreview> {
  late final AppAnimateConfig _config;
  int _key = 0;

  @override
  void initState() {
    super.initState();
    _config = _defaultConfig(widget.type);
  }

  AppAnimateConfig _defaultConfig(AppAnimateType type) {
    switch (type) {
      case AppAnimateType.shimmer:
        return const AppAnimateConfig.shimmer();
      case AppAnimateType.blur:
        return const AppAnimateConfig.blur();
      case AppAnimateType.pulse:
      case AppAnimateType.heartbeat:
      case AppAnimateType.glow:
        return const AppAnimateConfig(duration: Duration(milliseconds: 900), loop: true, reverse: true);
      case AppAnimateType.shake:
      case AppAnimateType.jello:
      case AppAnimateType.swing:
      case AppAnimateType.wobble:
      case AppAnimateType.flash:
      case AppAnimateType.rubberBand:
        return const AppAnimateConfig(duration: Duration(milliseconds: 800), loop: true, reverse: false);
      case AppAnimateType.marquee:
        return const AppAnimateConfig(duration: Duration(seconds: 8), loop: true);
      default:
        return const AppAnimateConfig(duration: Duration(milliseconds: 600), loop: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = widget.type;

    final child = Container(
      width: 100,
      height: 60,
      decoration: BoxDecoration(
        color: colors.surface2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.border),
      ),
      child: Center(
        child: type.isTextOnly
            ? Text(
                'Animate',
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              )
            : Icon(Icons.bolt_rounded, color: colors.neonCyan, size: 22),
      ),
    );

    return GestureDetector(
      onTap: () => setState(() => _key++),
      child: Column(
        key: ValueKey('anim_${type}_$_key'),
        mainAxisSize: MainAxisSize.min,
        children: [
          type.isTextOnly
              ? AppAnimate(
                  type: type,
                  config: _config,
                  child: _TextDemo(colors: colors, type: type),
                )
              : AppAnimate(
                  type: type,
                  config: _config,
                  child: child,
                ),
          const SizedBox(height: 4),
          SizedBox(
            width: 100,
            child: Text(
              type.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.textDim,
                fontSize: 9,
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _TextDemo extends StatelessWidget {
  final AppThemeExtension colors;
  final AppAnimateType type;

  const _TextDemo({required this.colors, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 60,
      decoration: BoxDecoration(
        color: colors.surface2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.border),
      ),
      child: Center(
        child: Text(
          'Hello',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
