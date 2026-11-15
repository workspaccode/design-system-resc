import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/generated/assets.dart';

import '../../../theme/theme_extensions.dart';
import '../../animate/animate_types.dart';
import '../widgets/png_loading.dart';

/// A comprehensive loading page demonstrating various PNG loading animations.
class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      appBar: AppBar(
        title: const Text('Loading Animations'),
        backgroundColor: context.colors.surface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(theme, 'Frame Animation', children: [
            const Center(
              child: PngLoadingDual(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPulsingLogo(80),
                _buildPulsingLogo(60),
                _buildPulsingLogo(40),
              ],
            ),
          ]),
          _section(theme, 'Continuous Pulse', children: [
            const Center(
              child: PngLoadingPulse(
                imagePath: Assets.imageRescDark,
                size: 150,
                pulseDuration: Duration(milliseconds: 1000),
              ),
            ),
          ]),
          _section(theme, 'Fade Animation', children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PngLoadingFade(
                  imagePath: Assets.imageRescDark,
                  size: 60,
                  fadeDuration: const Duration(milliseconds: 300),
                ),
                PngLoadingFade(
                  imagePath: Assets.imageRescDark,
                  size: 80,
                  fadeDuration: const Duration(milliseconds: 500),
                ),
                PngLoadingFade(
                  imagePath: Assets.imageRescDark,
                  size: 100,
                  fadeDuration: const Duration(milliseconds: 700),
                ),
              ],
            ),
          ]),
          _section(theme, 'Custom Frame Animation', children: [
            const Center(
              child: PngLoading(
                imagePaths: [
                  Assets.imageRescDark,
                  Assets.imageRescLigh,
                ],
                frameDuration: Duration(milliseconds: 400),
                size: 180,
                curve: Curves.easeInOut,
              ),
            ),
          ]),
          _section(theme, 'V2 — Pulse (AppAnimate)', children: [
            Center(
              child: PngLoadingV2(
                controller: PngLoadingController(
                  animationType: AppAnimateType.pulse,
                  size: 200,
                  loopCount: 0,
                ),
              ),
            ),
          ]),
          _section(theme, 'V2 — Rotate In', children: [
            Center(
              child: PngLoadingV2(
                controller: PngLoadingController(
                  animationType: AppAnimateType.rotateIn,
                  size: 150,
                  loopCount: 3,
                ),
              ),
            ),
          ]),
          _section(theme, 'V2 — Heartbeat', children: [
            Center(
              child: PngLoadingV2(
                controller: PngLoadingController(
                  animationType: AppAnimateType.heartbeat,
                  size: 120,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildPulsingLogo(double size) {
    return PngLoadingFade(
      imagePath: Assets.imageRescDark,
      size: size,
      fadeDuration: const Duration(milliseconds: 500),
    );
  }

  Widget _section(ThemeData theme, String title,
      {required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
