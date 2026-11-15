import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;
import 'package:flutter_design_system/generated/assets.dart';

class LoadingAnimationPage extends StatelessWidget {
  const LoadingAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ds.AppScaffold(
      title: 'Loading Animation',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(theme, 'Frame Animation', children: [
            const Center(
              child: ds.PngLoadingDual(
                darkImagePath: Assets.imageRescDark,
                lightImagePath: Assets.imageRescLigh,
                frameDuration: Duration(milliseconds: 600),
                size: 200,
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Loading...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ]),
          _section(theme, 'Multiple Animations', children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ds.PngLoadingFade(
                  imagePath: Assets.imageRescDark,
                  size: 80,
                  fadeDuration: Duration(milliseconds: 500),
                ),
                ds.PngLoadingFade(
                  imagePath: Assets.imageRescDark,
                  size: 60,
                  fadeDuration: Duration(milliseconds: 500),
                ),
                ds.PngLoadingFade(
                  imagePath: Assets.imageRescDark,
                  size: 40,
                  fadeDuration: Duration(milliseconds: 500),
                ),
              ],
            ),
          ]),
          _section(theme, 'Continuous Pulse', children: [
            const Center(
              child: ds.PngLoadingPulse(
                imagePath: Assets.imageRescDark,
                size: 150,
                pulseDuration: Duration(milliseconds: 1000),
              ),
            ),
          ]),
          _section(theme, 'Fade Animation', children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ds.PngLoadingFade(
                  imagePath: Assets.imageRescDark,
                  size: 60,
                  fadeDuration: Duration(milliseconds: 300),
                ),
                ds.PngLoadingFade(
                  imagePath: Assets.imageRescDark,
                  size: 80,
                  fadeDuration: Duration(milliseconds: 500),
                ),
                ds.PngLoadingFade(
                  imagePath: Assets.imageRescDark,
                  size: 100,
                  fadeDuration: Duration(milliseconds: 700),
                ),
              ],
            ),
          ]),
          const SizedBox(height: 32),
        ],
      ),
    );
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
