import 'dart:async';
import 'dart:math' as math;
import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;

class ThermometerPage extends StatefulWidget {
  const ThermometerPage({super.key});

  @override
  State<ThermometerPage> createState() => _ThermometerPageState();
}

class _TempPreset extends StatelessWidget {
  final String label;
  final double celsius;
  final Color color;
  final VoidCallback onTap;

  const _TempPreset({
    required this.label,
    required this.celsius,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fahrenheit = celsius * 9 / 5 + 32;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${celsius.toStringAsFixed(0)}°C / ${fahrenheit.toStringAsFixed(0)}°F',
              style: TextStyle(
                color: color.withValues(alpha: 0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThermometerPageState extends State<ThermometerPage> {
  double _celsius = 32.0;
  bool _showMinorLabels = true;
  bool _showCelsius = true;
  bool _showFahrenheit = true;
  ds.ThermometerFluidTheme _selectedTheme = ds.ThermometerFluidTheme.redSpirit;
  ds.ThermometerReadoutStyle _readoutStyle =
      ds.ThermometerReadoutStyle.circularWheel;

  // Spacing Configuration (المسافة خارج التصميم للأعلى والأسفل)
  double _topWidgetSpacing = 12.0;
  double _humiditySpacing = 14.0;

  // Danger Alert System (نظام الإنذار والهزاز والصوت عند الحرارة الخطرة)
  bool _enableDangerAlert = true;
  double _criticalMaxCelsius = 39.0;

  // Humidity Feature (الرطوبة)
  double _humidity = 58.0;
  bool _showHumidity = true;
  bool _showTempInHumidityPill = false;
  ds.ThermometerHumidityPosition _humidityPosition =
      ds.ThermometerHumidityPosition.bottomPill;

  // Custom Colors Theme Switch
  bool _useCustomPalette = false;
  bool _autoTheme = true;

  // Custom Top Widget selection (0: Sun Default, 1: Dynamic State Badge/Animation, 2: Custom Lottie/SVG style)
  int _topWidgetType = 1;

  // Custom Temperature Equation / Formatter (0: Default, 1: Celsius, 2: Fahrenheit, 3: Kelvin, 4: With State)
  int _formulaType = 0;

  // Thermal Thresholds
  final ds.ThermometerThresholds _thresholds = const ds.ThermometerThresholds(
    cool: 18.0,
    normal: 27.0,
    warm: 36.0,
    hot: 45.0,
  );

  // Live Hardware Sensor Simulation
  bool _isLiveSensorStreaming = false;
  bool _autoThemeBasedOnSensor = true;
  Timer? _sensorTimer;

  @override
  void dispose() {
    _sensorTimer?.cancel();
    super.dispose();
  }

  void _toggleLiveSensor(bool enable) {
    setState(() {
      _isLiveSensorStreaming = enable;
    });

    _sensorTimer?.cancel();
    if (enable) {
      _sensorTimer =
          Timer.periodic(const Duration(milliseconds: 1400), (timer) {
        final delta = (math.Random().nextDouble() * 4.0) - 1.8;
        final deltaHum = (math.Random().nextDouble() * 5.0) - 2.5;
        final newTemp = (_celsius + delta).clamp(-15.0, 48.0);
        final newHum = (_humidity + deltaHum).clamp(15.0, 95.0);

        setState(() {
          _celsius = double.parse(newTemp.toStringAsFixed(1));
          _humidity = double.parse(newHum.toStringAsFixed(0));
          if (_autoThemeBasedOnSensor) {
            _selectedTheme = ds.ThermometerFluidTheme.fromCelsius(
              _celsius,
              _thresholds,
            );
          }
        });
      });
    }
  }

  String Function(double celsius)? get _currentValueFormatter {
    return switch (_formulaType) {
      1 => (c) => '${c.toStringAsFixed(1)} °C',
      2 => (c) => '${(c * 1.8 + 32).toStringAsFixed(1)} °F',
      3 => (c) => '${(c + 273.15).toStringAsFixed(1)} K',
      4 => (c) {
          final state = _thresholds.getState(c);
          final stateName = switch (state) {
            ds.ThermometerTemperatureState.cool => '❄️ COOL',
            ds.ThermometerTemperatureState.normal => '🌿 NORMAL',
            ds.ThermometerTemperatureState.warm => '☀️ WARM',
            ds.ThermometerTemperatureState.hot => '🔥 HOT',
          };
          return '${c.toStringAsFixed(0)}° $stateName';
        },
      _ => null, // default
    };
  }

  Widget _buildDynamicTopWidget(
    BuildContext context,
    double celsius,
    ds.ThermometerTemperatureState state,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final (icon, color, label) = switch (state) {
      ds.ThermometerTemperatureState.cool => (
          Icons.ac_unit_rounded,
          const Color(0xFF00B0FF),
          'بارد (Cool)'
        ),
      ds.ThermometerTemperatureState.normal => (
          Icons.eco_rounded,
          const Color(0xFF00E676),
          'معتدل (Normal)'
        ),
      ds.ThermometerTemperatureState.warm => (
          Icons.wb_sunny_rounded,
          const Color(0xFFFF9100),
          'دافئ (Warm)'
        ),
      ds.ThermometerTemperatureState.hot => (
          Icons.local_fire_department_rounded,
          const Color(0xFFFF2A2A),
          'حار (Hot)'
        ),
    };

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF222834) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.7), width: 1.8),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: isDark ? 0.4 : 0.25),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 17),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fahrenheit = _celsius * 9 / 5 + 32;

    final customColors = _useCustomPalette
        ? const ds.ThermometerColors(
            fluidPrimary: Color(0xFF8B5CF6), // Purple fluid
            fluidDeep: Color(0xFF5B21B6),
            fluidHighlight: Color(0xFFC4B5FD),
            majorText: Color(0xFF8B5CF6),
            majorTick: Color(0xFF8B5CF6),
            unitHeader: Color(0xFF8B5CF6),
          )
        : null;

    return ds.AppScaffold(
      title: 'Thermometer 100% Realistic',
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // Live Device Sensor Simulation Banner
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _isLiveSensorStreaming
                    ? [
                        const Color(0xFF10B981).withValues(alpha: 0.18),
                        const Color(0xFF059669).withValues(alpha: 0.08),
                      ]
                    : [
                        const Color(0xFF3B82F6).withValues(alpha: 0.12),
                        const Color(0xFF1D4ED8).withValues(alpha: 0.05),
                      ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isLiveSensorStreaming
                    ? const Color(0xFF10B981).withValues(alpha: 0.4)
                    : const Color(0xFF3B82F6).withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _isLiveSensorStreaming
                        ? const Color(0xFF10B981).withValues(alpha: 0.2)
                        : Colors.blue.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isLiveSensorStreaming
                        ? Icons.sensors_rounded
                        : Icons.bluetooth_searching_rounded,
                    color: _isLiveSensorStreaming
                        ? const Color(0xFF10B981)
                        : const Color(0xFF3B82F6),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _isLiveSensorStreaming
                                ? 'جهاز الاستشعار متصل (Live Telemetry)'
                                : 'محاكاة قراءات جهاز الاستشعار (Hardware Sensor)',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          if (_isLiveSensorStreaming) ...[
                            const SizedBox(width: 6),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _isLiveSensorStreaming
                            ? 'بث مباشر للحرارة والرطوبة من الحساس (ESP32 / BLE Sensor)'
                            : 'تفعيل المحاكاة لاستقبال قيم درجات الحرارة والرطوبة تلقائياً',
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.65),
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: _isLiveSensorStreaming,
                  activeTrackColor:
                      const Color(0xFF10B981).withValues(alpha: 0.4),
                  activeThumbColor: const Color(0xFF10B981),
                  onChanged: _toggleLiveSensor,
                ),
              ],
            ),
          ),

          // Danger Alert Indicator Banner (عند الوصول لحد الخطر)
          if (_celsius >= _criticalMaxCelsius && _enableDangerAlert)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFF1744).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFF1744), width: 1.5),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: Color(0xFFFF1744), size: 24),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '⚠️ تحذير: درجة الحرارة تجاوزت حد الخطر! (الهزاز والصوت يعملان تلقائياً)',
                      style: TextStyle(
                        color: Color(0xFFFF1744),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          _section(
              context, 'Glass Thermometer & Hygrometer (بدون أي حاوية ثابتة)',
              children: [
                // Center Thermometer Widget with clean transparent presentation
                Center(
                  child: ds.ThermometerWidget(
                    celsius: _celsius,
                    humidity: _humidity,
                    showHumidity: _showHumidity,
                    humidityPosition: _humidityPosition,
                    showTemperatureInHumidityPill: _showTempInHumidityPill,
                    topWidgetSpacing: _topWidgetSpacing,
                    humiditySpacing: _humiditySpacing,
                    criticalMaxCelsius:
                        _enableDangerAlert ? _criticalMaxCelsius : null,
                    enableAlertVibration: true,
                    colors: customColors,
                    showCelsius: _showCelsius,
                    showFahrenheit: _showFahrenheit,
                    showMinorLabels: _showMinorLabels,
                    fluidTheme: _selectedTheme,
                    autoTheme: _autoTheme,
                    readoutStyle: _readoutStyle,
                    thresholds: _thresholds,
                    valueFormatter: _currentValueFormatter,
                    showSunIcon: true,
                    topWidgetBuilder:
                        _topWidgetType == 1 ? _buildDynamicTopWidget : null,
                    topWidget: _topWidgetType == 2
                        ? Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.auto_awesome_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          )
                        : null,
                    width: 270,
                    height: 480,
                    interactive:
                        !_isLiveSensorStreaming, // Read-only during live sensor mode
                    onChanged: (newCelsius) {
                      setState(() {
                        _celsius = newCelsius;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    _isLiveSensorStreaming
                        ? '⚡ قراءات حية متدفقة للحرارة والرطوبة من الحساس الخارجي'
                        : '💡 يمكنك اللمس والسحب المباشر على مقياس الحرارة لتعديل القيمة',
                    style: TextStyle(
                      fontSize: 12,
                      color: _isLiveSensorStreaming
                          ? const Color(0xFF10B981)
                          : Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Readout Badge
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedTheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: _selectedTheme.primary.withValues(alpha: 0.4),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      _showCelsius && _showFahrenheit
                          ? '${_celsius.toStringAsFixed(1)}°C  /  ${fahrenheit.toStringAsFixed(1)}°F'
                          : _showCelsius
                              ? '${_celsius.toStringAsFixed(1)}°C'
                              : '${fahrenheit.toStringAsFixed(1)}°F',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: _selectedTheme.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Sliders control (only when not streaming)
                if (!_isLiveSensorStreaming) ...[
                  // Temperature Slider
                  Row(
                    children: [
                      const Icon(Icons.thermostat_rounded,
                          size: 18, color: Colors.redAccent),
                      const SizedBox(width: 6),
                      const Text('الحرارة: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                      Text('${_celsius.toStringAsFixed(1)}°C',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent)),
                    ],
                  ),
                  Slider(
                    value: _celsius,
                    min: -30,
                    max: 50,
                    divisions: 160,
                    label: '${_celsius.toStringAsFixed(1)}°C',
                    activeColor: _selectedTheme.primary,
                    onChanged: (value) {
                      setState(() {
                        _celsius = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),

                  // Humidity Slider
                  Row(
                    children: [
                      const Icon(Icons.water_drop_rounded,
                          size: 18, color: Color(0xFF00B0FF)),
                      const SizedBox(width: 6),
                      const Text('الرطوبة (Humidity): ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                      Text('${_humidity.toStringAsFixed(0)}% RH',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00B0FF))),
                    ],
                  ),
                  Slider(
                    value: _humidity,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '${_humidity.toStringAsFixed(0)}%',
                    activeColor: const Color(0xFF00B0FF),
                    onChanged: (value) {
                      setState(() {
                        _humidity = value;
                      });
                    },
                  ),
                ],
                const SizedBox(height: 12),

                // Humidity Options (خيارات وموضع الرطوبة)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF232731)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF333A48)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.water_drop_rounded,
                                  size: 18, color: Color(0xFF00B0FF)),
                              SizedBox(width: 8),
                              Text(
                                'ميزة مقياس الرطوبة (Humidity %RH)',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.5),
                              ),
                            ],
                          ),
                          Switch.adaptive(
                            value: _showHumidity,
                            activeTrackColor:
                                const Color(0xFF00B0FF).withValues(alpha: 0.4),
                            activeThumbColor: const Color(0xFF00B0FF),
                            onChanged: (val) {
                              setState(() {
                                _showHumidity = val;
                              });
                            },
                          ),
                        ],
                      ),
                      if (_showHumidity) ...[
                        const SizedBox(height: 10),
                        const Text('شكل وموضع مقياس الرطوبة:',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ChoiceChip(
                              label: const Text(
                                  '💧 بادج أسفل المستودع (Bottom Pill)'),
                              selected: _humidityPosition ==
                                  ds.ThermometerHumidityPosition.bottomPill,
                              selectedColor: const Color(0xFF00B0FF)
                                  .withValues(alpha: 0.25),
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    _humidityPosition = ds
                                        .ThermometerHumidityPosition.bottomPill;
                                  });
                                }
                              },
                            ),
                            ChoiceChip(
                              label: const Text(
                                  '🧭 قرص هيدروميتر جانبي (Side Dial)'),
                              selected: _humidityPosition ==
                                  ds.ThermometerHumidityPosition.sideDial,
                              selectedColor: const Color(0xFF00B0FF)
                                  .withValues(alpha: 0.25),
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    _humidityPosition =
                                        ds.ThermometerHumidityPosition.sideDial;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                  '🌡️ عرض درجة الحرارة بدل الرطوبة في البادج',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.5)),
                            ),
                            Switch.adaptive(
                              value: _showTempInHumidityPill,
                              activeTrackColor:
                                  const Color(0xFFFF5252).withValues(alpha: 0.4),
                              activeThumbColor: const Color(0xFFFF5252),
                              onChanged: (val) {
                                setState(() {
                                  _showTempInHumidityPill = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Readout Style Selector (نمط عرض البكرة الدائرية)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF232731)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF333A48)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.style_rounded,
                              size: 18, color: Colors.blueAccent),
                          SizedBox(width: 8),
                          Text(
                            'شكل ونمط عرض القيمة الحالية (Readout Style)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ChoiceChip(
                            label: const Text('بكرة دائرية عائمة (3 شرطات)'),
                            selected: _readoutStyle ==
                                ds.ThermometerReadoutStyle.circularWheel,
                            selectedColor:
                                _selectedTheme.primary.withValues(alpha: 0.25),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _readoutStyle =
                                      ds.ThermometerReadoutStyle.circularWheel;
                                });
                              }
                            },
                          ),
                          ChoiceChip(
                            label: const Text('بكرة مدمجة مكان مقياس C'),
                            selected: _readoutStyle ==
                                ds.ThermometerReadoutStyle.integratedScaleWheel,
                            selectedColor:
                                _selectedTheme.primary.withValues(alpha: 0.25),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _readoutStyle = ds.ThermometerReadoutStyle
                                      .integratedScaleWheel;
                                });
                              }
                            },
                          ),
                          ChoiceChip(
                            label: const Text('بادج بسيط (Badge)'),
                            selected: _readoutStyle ==
                                ds.ThermometerReadoutStyle.simpleBadge,
                            selectedColor:
                                _selectedTheme.primary.withValues(alpha: 0.25),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _readoutStyle =
                                      ds.ThermometerReadoutStyle.simpleBadge;
                                });
                              }
                            },
                          ),
                          ChoiceChip(
                            label: const Text('إخفاء (None)'),
                            selected: _readoutStyle ==
                                ds.ThermometerReadoutStyle.none,
                            selectedColor:
                                _selectedTheme.primary.withValues(alpha: 0.25),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _readoutStyle =
                                      ds.ThermometerReadoutStyle.none;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Top Widget / Animation Selector (اختيار الودجيت في الأعلى مكان الشمس)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF232731)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF333A48)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.widgets_rounded,
                              size: 18, color: Colors.orangeAccent),
                          SizedBox(width: 8),
                          Text(
                            'عنصر الواجهة بالأعلى (Top Widget / SVG / Lottie)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ChoiceChip(
                            label: const Text('🌤️ الشمس الافتراضية'),
                            selected: _topWidgetType == 0,
                            selectedColor:
                                Colors.orange.withValues(alpha: 0.25),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _topWidgetType = 0;
                                });
                              }
                            },
                          ),
                          ChoiceChip(
                            label:
                                const Text('❄️🌿☀️🔥 ودجيت تفاعلي مع الحالة'),
                            selected: _topWidgetType == 1,
                            selectedColor: Colors.green.withValues(alpha: 0.25),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _topWidgetType = 1;
                                });
                              }
                            },
                          ),
                          ChoiceChip(
                            label: const Text('✨ مخصص (Custom SVG / Lottie)'),
                            selected: _topWidgetType == 2,
                            selectedColor: Colors.teal.withValues(alpha: 0.25),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _topWidgetType = 2;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Value Equation / Formatter Selector (معادلة وصيغة عرض الحرارة)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF232731)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF333A48)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.functions_rounded,
                              size: 18, color: Colors.purpleAccent),
                          SizedBox(width: 8),
                          Text(
                            'صيغة ومعادلة عرض الحرارة (Value Equation Formatter)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ChoiceChip(
                            label: const Text('افتراضي: 32.0°'),
                            selected: _formulaType == 0,
                            selectedColor:
                                Colors.purple.withValues(alpha: 0.25),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _formulaType = 0;
                                });
                              }
                            },
                          ),
                          ChoiceChip(
                            label: const Text('سيلزيوس: 32.0 °C'),
                            selected: _formulaType == 1,
                            selectedColor:
                                Colors.purple.withValues(alpha: 0.25),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _formulaType = 1;
                                });
                              }
                            },
                          ),
                          ChoiceChip(
                            label: const Text('فهرنهايت: 89.6 °F'),
                            selected: _formulaType == 2,
                            selectedColor:
                                Colors.purple.withValues(alpha: 0.25),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _formulaType = 2;
                                });
                              }
                            },
                          ),
                          ChoiceChip(
                            label: const Text('كلفن: 305.2 K'),
                            selected: _formulaType == 3,
                            selectedColor:
                                Colors.purple.withValues(alpha: 0.25),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _formulaType = 3;
                                });
                              }
                            },
                          ),
                          ChoiceChip(
                            label: const Text('مع الحالة: 32° WARM'),
                            selected: _formulaType == 4,
                            selectedColor:
                                Colors.purple.withValues(alpha: 0.25),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _formulaType = 4;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Spacing Configuration Card (المسافات خارج التصميم)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF232731)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF333A48)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.space_bar_rounded,
                              size: 18, color: Colors.tealAccent),
                          SizedBox(width: 8),
                          Text(
                            'التحكم بمسافة العناصر خارج التصميم (Spacing)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text(
                              'مسافة ودجيت الأعلى (Top Widget Spacing): ',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600)),
                          Text('${_topWidgetSpacing.toStringAsFixed(0)} px',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.tealAccent)),
                        ],
                      ),
                      Slider(
                        value: _topWidgetSpacing,
                        min: 0,
                        max: 40,
                        divisions: 40,
                        activeColor: Colors.tealAccent,
                        onChanged: (val) {
                          setState(() {
                            _topWidgetSpacing = val;
                          });
                        },
                      ),
                      Row(
                        children: [
                          const Text(
                              'مسافة ودجيت الرطوبة بالأسفل (Humidity Spacing): ',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600)),
                          Text('${_humiditySpacing.toStringAsFixed(0)} px',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.tealAccent)),
                        ],
                      ),
                      Slider(
                        value: _humiditySpacing,
                        min: 0,
                        max: 40,
                        divisions: 40,
                        activeColor: Colors.tealAccent,
                        onChanged: (val) {
                          setState(() {
                            _humiditySpacing = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Danger Alert Settings Card (الإنذار والهزاز والصوت)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF232731)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color:
                          _celsius >= _criticalMaxCelsius && _enableDangerAlert
                              ? const Color(0xFFFF1744)
                              : (Theme.of(context).brightness == Brightness.dark
                                  ? const Color(0xFF333A48)
                                  : const Color(0xFFE2E8F0)),
                      width:
                          _celsius >= _criticalMaxCelsius && _enableDangerAlert
                              ? 1.8
                              : 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.notification_important_rounded,
                                  size: 18, color: Color(0xFFFF1744)),
                              SizedBox(width: 8),
                              Text(
                                'إنذار درجة الحرارة الحرجة (هزاز + صوت)',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.5),
                              ),
                            ],
                          ),
                          Switch.adaptive(
                            value: _enableDangerAlert,
                            activeTrackColor:
                                const Color(0xFFFF1744).withValues(alpha: 0.4),
                            activeThumbColor: const Color(0xFFFF1744),
                            onChanged: (val) {
                              setState(() {
                                _enableDangerAlert = val;
                              });
                            },
                          ),
                        ],
                      ),
                      if (_enableDangerAlert) ...[
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text('حد درجة الحرارة الخطرة: ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600)),
                            Text('${_criticalMaxCelsius.toStringAsFixed(0)}°C',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFF1744))),
                          ],
                        ),
                        Slider(
                          value: _criticalMaxCelsius,
                          min: 25,
                          max: 48,
                          divisions: 23,
                          activeColor: const Color(0xFFFF1744),
                          onChanged: (val) {
                            setState(() {
                              _criticalMaxCelsius = val;
                            });
                          },
                        ),
                        const Text(
                          '📱 عند تجاوز هذه الدرجة، يصدر الهاتف هزازاً ملموساً وصوت إنذار مع نبضات ضوئية على مقياس الحرارة.',
                          style: TextStyle(fontSize: 11.5, color: Colors.grey),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Auto-Theme Dynamic Mode Switch (تغيير الألوان تلقائياً حسب القيمة الحالية)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF232731)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _autoTheme
                          ? Colors.cyanAccent.withValues(alpha: 0.5)
                          : (Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF333A48)
                              : const Color(0xFFE2E8F0)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.auto_awesome_rounded,
                              size: 18, color: Colors.cyanAccent),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'تغيير الألوان ديناميكياً حسب الحرارة (Auto-Theme)',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.5),
                              ),
                              Text(
                                'يتحول السائل تلقائياً (أزرق بارد ➔ أخضر معتدل ➔ برتقالي دافئ ➔ أحمر حار)',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Switch.adaptive(
                        value: _autoTheme,
                        activeTrackColor:
                            Colors.cyanAccent.withValues(alpha: 0.4),
                        activeThumbColor: Colors.cyanAccent,
                        onChanged: (val) {
                          setState(() {
                            _autoTheme = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Custom Colors & Styles Theme Switch (100% قابلية التخصيص للون والنصوص)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF232731)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF333A48)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.palette_rounded,
                              size: 18, color: Color(0xFF8B5CF6)),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'تخصيص كامل للألوان (ThermometerColors)',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.5),
                              ),
                              Text(
                                'تطبيق لوحة ألوان بنفسجية مخصصة للزجاج والسائل والتدريجات',
                                style:
                                    TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Switch.adaptive(
                        value: _useCustomPalette,
                        activeTrackColor:
                            const Color(0xFF8B5CF6).withValues(alpha: 0.4),
                        activeThumbColor: const Color(0xFF8B5CF6),
                        onChanged: (val) {
                          setState(() {
                            _useCustomPalette = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Scale Display Option Switches (°C / °F)
                Material(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF232731)
                      : const Color(0xFFF8FAFC),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF333A48)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text(
                          'إظهار مقياس السيلزيوس (°C) على اليمين',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        subtitle: const Text(
                          'المقياس المتري المعتمد في الوطن العربي وأوروبا',
                          style: TextStyle(fontSize: 12),
                        ),
                        value: _showCelsius,
                        activeThumbColor: _selectedTheme.primary,
                        activeTrackColor:
                            _selectedTheme.primary.withValues(alpha: 0.4),
                        onChanged: (val) {
                          setState(() {
                            _showCelsius = val;
                          });
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        title: const Text(
                          'إظهار مقياس الفهرنهايت (°F) على اليسار',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        subtitle: const Text(
                          'المقياس المستخدم في الولايات المتحدة',
                          style: TextStyle(fontSize: 12),
                        ),
                        value: _showFahrenheit,
                        activeThumbColor: _selectedTheme.primary,
                        activeTrackColor:
                            _selectedTheme.primary.withValues(alpha: 0.4),
                        onChanged: (val) {
                          setState(() {
                            _showFahrenheit = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Additional Display Options (Micro-Labels & Auto-Theme)
                Material(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF232731)
                      : const Color(0xFFF8FAFC),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF333A48)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text(
                          'أرقام التدريج الدقيق (Micro-Labels)',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        subtitle: const Text(
                          'إظهار أرقام مصغرة عند كل شرطة فرعية مثل البكارة والمسطرة',
                          style: TextStyle(fontSize: 12),
                        ),
                        value: _showMinorLabels,
                        activeThumbColor: _selectedTheme.primary,
                        activeTrackColor:
                            _selectedTheme.primary.withValues(alpha: 0.4),
                        onChanged: (val) {
                          setState(() {
                            _showMinorLabels = val;
                          });
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        title: const Text(
                          'تغيير لون السائل تلقائياً حسب حرارة الحساس (Auto-Theme)',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        subtitle: const Text(
                          'يتغير اللون ديناميكياً (أزرق للبارد، أخضر للمعتدل، أحمر للحار)',
                          style: TextStyle(fontSize: 12),
                        ),
                        value: _autoThemeBasedOnSensor,
                        activeThumbColor: _selectedTheme.primary,
                        activeTrackColor:
                            _selectedTheme.primary.withValues(alpha: 0.4),
                        onChanged: (val) {
                          setState(() {
                            _autoThemeBasedOnSensor = val;
                            if (val) {
                              _selectedTheme =
                                  ds.ThermometerFluidTheme.fromCelsius(
                                      _celsius);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ]),

          // Standalone 3D Cylindrical Wheel Readout Showcase
          _section(context,
              '3D Rolling Wheel Readout (بكرة القراءة الأسطوانية الدائرية)',
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1B1F27)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF2C3240)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'تأثير البكرة ثلاثية الأبعاد: الشرطة العلوية والسفلية شبه مختفية (تلاشي 60%) والوسطى واضحة تماماً مع القيمة الحية:',
                        style: TextStyle(
                            fontSize: 12.5, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              ds.ThermometerWheelReadout(
                                celsius: _celsius,
                                unit: '°C',
                                activeColor: _selectedTheme.primary,
                              ),
                              const SizedBox(height: 8),
                              const Text('مقياس °C المتري',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              ds.ThermometerWheelReadout(
                                celsius: fahrenheit,
                                unit: '°F',
                                activeColor: _selectedTheme.primary,
                              ),
                              const SizedBox(height: 8),
                              const Text('مقياس °F الأمريكي',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),

          // Fluid Theme Switcher
          _section(context, 'Fluid Themes (أنواع وثيمات السائل)', children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ds.ThermometerFluidTheme.values.map((theme) {
                final isSelected = _selectedTheme == theme;
                final name = switch (theme) {
                  ds.ThermometerFluidTheme.redSpirit => 'الكحول الأحمر (Red)',
                  ds.ThermometerFluidTheme.mercury => 'الزئبق الفضي (Mercury)',
                  ds.ThermometerFluidTheme.cryoBlue =>
                    'الأزرق الثلجي (Cryo Blue)',
                  ds.ThermometerFluidTheme.emerald => 'الزمرد الأخضر (Emerald)',
                  ds.ThermometerFluidTheme.amber =>
                    'الكهرمان البرتقالي (Amber)',
                };

                return ChoiceChip(
                  label: Text(name),
                  selected: isSelected,
                  selectedColor: theme.primary.withValues(alpha: 0.25),
                  side: BorderSide(
                    color: isSelected
                        ? theme.primary
                        : Colors.grey.withValues(alpha: 0.3),
                    width: isSelected ? 2 : 1,
                  ),
                  avatar: CircleAvatar(
                    backgroundColor: theme.primary,
                    radius: 8,
                  ),
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedTheme = theme;
                      });
                    }
                  },
                );
              }).toList(),
            ),
          ]),

          _section(context, 'Temperature Presets (نقاط ضبط سريعة)', children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _TempPreset(
                  label: 'Freezing (تجمّد)',
                  celsius: 0,
                  color: Colors.blue,
                  onTap: () => _setTemperature(0),
                ),
                _TempPreset(
                  label: 'Cold (بارد)',
                  celsius: 10,
                  color: Colors.lightBlue,
                  onTap: () => _setTemperature(10),
                ),
                _TempPreset(
                  label: 'Room (غرفة)',
                  celsius: 22,
                  color: Colors.green,
                  onTap: () => _setTemperature(22),
                ),
                _TempPreset(
                  label: 'Warm (دافئ)',
                  celsius: 30,
                  color: Colors.orange,
                  onTap: () => _setTemperature(30),
                ),
                _TempPreset(
                  label: 'Hot (حار)',
                  celsius: 40,
                  color: Colors.deepOrange,
                  onTap: () => _setTemperature(40),
                ),
                _TempPreset(
                  label: 'Extreme (شديد الحرارة)',
                  celsius: 48,
                  color: Colors.red,
                  onTap: () => _setTemperature(48),
                ),
                _TempPreset(
                  label: 'Sub-Zero (تحت الصفر)',
                  celsius: -20,
                  color: Colors.cyan,
                  onTap: () => _setTemperature(-20),
                ),
              ],
            ),
          ]),

          _section(context, 'Different Sizes (مقاسات متعددة)', children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    ds.ThermometerWidget(
                      celsius: 25,
                      width: 160,
                      height: 320,
                      showMinorLabels: false,
                      fluidTheme: _selectedTheme,
                    ),
                    const SizedBox(height: 8),
                    const Text('Compact (صغير)',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    ds.ThermometerWidget(
                      celsius: 25,
                      width: 230,
                      height: 440,
                      showMinorLabels: true,
                      fluidTheme: _selectedTheme,
                    ),
                    const SizedBox(height: 8),
                    const Text('Standard (قياسي)',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ]),

          _section(context, 'Weather Scenarios (حالات الطقس)', children: [
            GridView.count(
              crossAxisCount: context.isWindowCompact ? 1 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.52,
              children: const [
                _WeatherCard(
                  title: 'Winter Morning',
                  celsius: -9,
                  icon: Icons.ac_unit,
                  color: Colors.blue,
                  theme: ds.ThermometerFluidTheme.cryoBlue,
                ),
                _WeatherCard(
                  title: 'Spring Day',
                  celsius: 18,
                  icon: Icons.wb_sunny_outlined,
                  color: Colors.green,
                  theme: ds.ThermometerFluidTheme.emerald,
                ),
                _WeatherCard(
                  title: 'Summer Heat',
                  celsius: 38,
                  icon: Icons.wb_sunny,
                  color: Colors.orange,
                  theme: ds.ThermometerFluidTheme.redSpirit,
                ),
                _WeatherCard(
                  title: 'Autumn Breeze',
                  celsius: 14,
                  icon: Icons.air,
                  color: Colors.brown,
                  theme: ds.ThermometerFluidTheme.amber,
                ),
              ],
            ),
          ]),

          _section(context, 'Hygrometer Gauges (مقاييس الرطوبة المستقلة)',
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1E2430)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF2E384D)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'عنصر مقياس الرطوبة المستقل (HygrometerWidget) للاستخدام في البطاقات واللوحات الإحصائية:',
                        style: TextStyle(
                            fontSize: 12.5, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 16),
                      Wrap(
                        spacing: 24,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: [
                          Column(
                            children: [
                              ds.HygrometerWidget(humidity: 22, size: 85),
                              SizedBox(height: 6),
                              Text('22% RH (جاف)',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange)),
                            ],
                          ),
                          Column(
                            children: [
                              ds.HygrometerWidget(humidity: 55, size: 85),
                              SizedBox(height: 6),
                              Text('55% RH (مثالي)',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                            ],
                          ),
                          Column(
                            children: [
                              ds.HygrometerWidget(humidity: 88, size: 85),
                              SizedBox(height: 6),
                              Text('88% RH (رطب)',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00B0FF))),
                            ],
                          ),
                        ],
                      ),
                    ],
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
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  void _setTemperature(double c) {
    setState(() {
      _celsius = c;
    });
  }
}

class _WeatherCard extends StatelessWidget {
  final String title;
  final double celsius;
  final IconData icon;
  final Color color;
  final ds.ThermometerFluidTheme theme;

  const _WeatherCard({
    required this.title,
    required this.celsius,
    required this.icon,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final fahrenheit = celsius * 9 / 5 + 32;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ds.ThermometerWidget(
              celsius: celsius,
              width: 140,
              height: 250,
              showMinorLabels: false,
              fluidTheme: theme,
              interactive: false,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${celsius.toStringAsFixed(0)}°C / ${fahrenheit.toStringAsFixed(0)}°F',
            style: TextStyle(
              color: color.withValues(alpha: 0.85),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
