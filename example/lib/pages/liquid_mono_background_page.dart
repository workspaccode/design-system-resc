import 'package:amicons/amicons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;

class LiquidMonoBackgroundPage extends StatelessWidget {
  const LiquidMonoBackgroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ds.AppScaffold(
      title: 'Liquid Mono Background',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(context, 'Full-Screen Liquid Mono', children: [
            const SizedBox(
              height: 400,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: ds.LiquidMonoBackground(
                  duration: Duration(seconds: 11),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Amicons.lucide_droplets,
                            color: Colors.white70, size: 40),
                        SizedBox(height: 8),
                        Text(
                          'Liquid Mono',
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
          _section(context, 'Custom Duration', children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: ds.LiquidMonoBackground(
                            duration: Duration(seconds: 5),
                            child: Center(
                              child: Text(
                                'Fast',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('5 seconds', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: ds.LiquidMonoBackground(
                            duration: Duration(seconds: 11),
                            child: Center(
                              child: Text(
                                'Default',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('11 seconds', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: ds.LiquidMonoBackground(
                            duration: Duration(seconds: 20),
                            child: Center(
                              child: Text(
                                'Slow',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('20 seconds', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ]),
          _section(context, 'With Content Overlay', children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: ds.LiquidMonoBackground(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Amicons.lucide_shield,
                              color: Colors.white70, size: 32),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Secure & Private',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Your data is protected with end-to-end encryption',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
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
