import 'package:amicons/amicons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;

class ScreenBackgroundAnimatedPage extends StatelessWidget {
  const ScreenBackgroundAnimatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ds.AppScaffold(
      title: 'Animated Background',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(context, 'Full-Screen Sonar Pulse', children: [
            const SizedBox(
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: ds.AppScreenAnimated(
                  color: Colors.cyanAccent,
                  ringCount: 4,
                  pulseSpeed: 0.8,
                  ringStrokeWidth: 2,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Amicons.lucide_waves,
                            color: Colors.white70, size: 40),
                        SizedBox(height: 8),
                        Text(
                          'Loading...',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
          _section(context, 'Compact Dot Variant', children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ds.AppScreenAnimatedDot(
                  size: 80,
                  color: Colors.deepPurpleAccent,
                  ringCount: 3,
                ),
                ds.AppScreenAnimatedDot(
                  size: 100,
                  color: Colors.tealAccent,
                  ringCount: 4,
                ),
                ds.AppScreenAnimatedDot(
                  size: 60,
                  color: Colors.orangeAccent,
                  ringCount: 2,
                ),
              ],
            ),
          ]),
          _section(context, 'Scattered Field Effect', children: [
            const SizedBox(
              height: 250,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: ds.AppScreenAnimatedField(
                  dotCount: 8,
                  color: Colors.purpleAccent,
                  pulseSpeed: 0.6,
                  dotSize: 50,
                ),
              ),
            ),
          ]),
          _section(context, 'With Secondary Color Ring', children: [
            const SizedBox(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: ds.AppScreenAnimated(
                  color: Colors.pinkAccent,
                  secondaryColor: Colors.amberAccent,
                  ringCount: 3,
                  pulseSpeed: 1.2,
                  ringStrokeWidth: 3,
                  child: Center(
                    child: Text(
                      'Dual Color',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
          _section(context, 'Animated Sweep Gradient', children: [
            const SizedBox(
              height: 250,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: ds.AppScreenAnimated(
                  gradientColors: [
                    Colors.cyan,
                    Colors.purple,
                    Colors.pink,
                    Colors.amber,
                    Colors.cyan,
                  ],
                  ringCount: 4,
                  pulseSpeed: 0.8,
                  ringStrokeWidth: 3,
                  coreDotRatio: 0.15,
                  child: Center(
                    child: Text(
                      'Sweep Gradient',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
          _section(context, 'Animated Radial Gradient Field', children: [
            const SizedBox(
              height: 250,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: ds.AppScreenAnimatedField(
                  dotCount: 6,
                  color: Colors.tealAccent,
                  pulseSpeed: 0.7,
                  dotSize: 70,
                  gradientColors: [
                    Colors.teal,
                    Colors.indigo,
                    Colors.purple,
                    Colors.teal,
                  ],
                  gradientStyle: ds.GradientStyle.radial,
                ),
              ),
            ),
          ]),
          _section(context, 'Aurora Mesh Gradient', children: [
            const SizedBox(
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: ds.AppScreenAnimatedAurora(
                  backgroundColor: Color(0xFF0D0208),
                  colors: [
                    Color(0xFFFF6B35),
                    Color(0xFFFF4E8C),
                    Color(0xFF9D4EDD),
                    Color(0xFFFF8500),
                  ],
                  blobCount: 5,
                  blurSigma: 70,
                  baseSpeed: 0.8,
                  child: Center(
                    child: Text(
                      'Aurora Gradient',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _section(BuildContext context, String title,
      {required List<Widget> children}) {
    final theme = Theme.of(context);
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
