import 'package:amicons/amicons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;

class AnimatedLiquidBorderPage extends StatelessWidget {
  const AnimatedLiquidBorderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ds.AppScaffold(
      title: 'Animated Liquid Border',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(context, 'Basic Usage', children: [
            const ds.AnimatedLiquidBorder(
              radius: 32,
              borderWidth: 2.5,
              duration: Duration(seconds: 8),
              backgroundColor: Color(0xFF757374),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Liquid animated border',
                    style: TextStyle(
                      color: Color(0xFFE8E6E6),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ]),
          _section(context, 'With Liquid Mono Background', children: [
            SizedBox(
              height: 350,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: const ds.LiquidMonoBackground(
                  child: SafeArea(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: ds.AnimatedLiquidBorder(
                          radius: 32,
                          duration: Duration(seconds: 9),
                          child: SizedBox(
                            height: 220,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
          _section(context, 'Different Border Widths', children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ds.AnimatedLiquidBorder(
                        radius: 20,
                        borderWidth: 1.5,
                        padding: EdgeInsets.all(1.5),
                        duration: Duration(seconds: 6),
                        child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              'Thin',
                              style: TextStyle(
                                color: Color(0xFFE8E6E6),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('1.5px', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      ds.AnimatedLiquidBorder(
                        radius: 20,
                        borderWidth: 2.2,
                        padding: EdgeInsets.all(1.8),
                        duration: Duration(seconds: 6),
                        child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              'Default',
                              style: TextStyle(
                                color: Color(0xFFE8E6E6),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('2.2px', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      ds.AnimatedLiquidBorder(
                        radius: 20,
                        borderWidth: 3.0,
                        padding: EdgeInsets.all(3.0),
                        duration: Duration(seconds: 6),
                        child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              'Thick',
                              style: TextStyle(
                                color: Color(0xFFE8E6E6),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('3.0px', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ]),
          _section(context, 'Different Animation Speeds', children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ds.AnimatedLiquidBorder(
                        radius: 20,
                        duration: Duration(seconds: 3),
                        child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              'Fast',
                              style: TextStyle(
                                color: Color(0xFFE8E6E6),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('3s', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      ds.AnimatedLiquidBorder(
                        radius: 20,
                        duration: Duration(seconds: 7),
                        child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              'Default',
                              style: TextStyle(
                                color: Color(0xFFE8E6E6),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('7s', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      ds.AnimatedLiquidBorder(
                        radius: 20,
                        duration: Duration(seconds: 12),
                        child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              'Slow',
                              style: TextStyle(
                                color: Color(0xFFE8E6E6),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('12s', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ]),
          _section(context, 'Card with Content', children: [
            ds.AnimatedLiquidBorder(
              radius: 24,
              duration: const Duration(seconds: 8),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Amicons.lucide_shield_check,
                              color: Colors.white.withValues(alpha: 0.8),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Premium Feature',
                                  style: TextStyle(
                                    color: Color(0xFFE8E6E6),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Secure & Encrypted',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'This card features an animated liquid border that creates a premium metallic effect with smooth gradient transitions.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
          _section(context, 'Button Style', children: [
            Center(
              child: ds.AnimatedLiquidBorder(
                radius: 50,
                borderWidth: 2.0,
                padding: const EdgeInsets.all(2.0),
                duration: const Duration(seconds: 6),
                backgroundColor: const Color(0xFF6E6B6C),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF737172),
                    borderRadius: BorderRadius.circular(48),
                  ),
                  child: const Text(
                    'Animated Button',
                    style: TextStyle(
                      color: Color(0xFFE8E6E6),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
