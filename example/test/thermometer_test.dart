import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

void main() {
  group('ThermometerWidget Tests', () {
    testWidgets(
        'Renders ThermometerWidget with Celsius and Fahrenheit defaults',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ThermometerWidget(
                celsius: 25,
                width: 220,
                height: 420,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ThermometerWidget), findsOneWidget);
      expect(find.byIcon(Icons.wb_sunny_rounded), findsOneWidget);
    });

    testWidgets('Supports custom fluid theme and minor labels toggle',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ThermometerWidget(
                celsius: -10,
                fluidTheme: ThermometerFluidTheme.cryoBlue,
                showMinorLabels: true,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ThermometerWidget), findsOneWidget);
    });

    testWidgets('Supports interaction drag on thermometer',
        (WidgetTester tester) async {
      double? updatedTemp;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ThermometerWidget(
                celsius: 20,
                interactive: true,
                onChanged: (val) {
                  updatedTemp = val;
                },
              ),
            ),
          ),
        ),
      );

      // Drag up/down on the widget
      final center = tester.getCenter(find.byType(ThermometerWidget));
      await tester.dragFrom(center, const Offset(0, -50));
      await tester.pumpAndSettle();

      expect(updatedTemp, isNotNull);
    });

    testWidgets('Supports hiding Fahrenheit or Celsius scales',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                Expanded(
                  child: ThermometerWidget(
                    celsius: 30,
                    showFahrenheit: false, // Only Celsius
                  ),
                ),
                Expanded(
                  child: ThermometerWidget(
                    celsius: 15,
                    showCelsius: false, // Only Fahrenheit
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ThermometerWidget), findsNWidgets(2));
    });

    testWidgets(
        'Adapts responsively to parent container constraints without fixed width/height',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 180,
              height: 380,
              child: ThermometerWidget(
                celsius: 28,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ThermometerWidget), findsOneWidget);
    });

    testWidgets(
        'Supports ThermometerReadoutStyle options and ThermometerWheelReadout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: ThermometerWidget(
                    celsius: 24.5,
                    readoutStyle: ThermometerReadoutStyle.circularWheel,
                  ),
                ),
                ThermometerWheelReadout(
                  celsius: 24.5,
                  unit: '°C',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ThermometerWidget), findsOneWidget);
      expect(find.byType(ThermometerWheelReadout), findsOneWidget);
      expect(find.text('24.5°C'), findsOneWidget);
      expect(find.text('26°'), findsOneWidget); // +1 faded tick
      expect(find.text('24°'), findsOneWidget); // -1 faded tick
    });

    testWidgets(
        'Supports custom topWidget, topWidgetBuilder, and custom valueFormatter formula',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ThermometerWidget(
                celsius: 35.0,
                readoutStyle: ThermometerReadoutStyle.integratedScaleWheel,
                valueFormatter: (c) => '${(c + 273.15).toStringAsFixed(1)} K',
                thresholds: const ThermometerThresholds(
                  cool: 15,
                  normal: 25,
                  warm: 35,
                  hot: 45,
                ),
                topWidgetBuilder: (context, celsius, state) {
                  return Text('STATE: ${state.name}');
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byType(ThermometerWidget), findsOneWidget);
      expect(find.text('STATE: warm'), findsOneWidget);
    });

    test('ThermometerThresholds correctly classifies thermal states', () {
      const thresholds = ThermometerThresholds(
        cool: 18.0,
        normal: 27.0,
        warm: 36.0,
        hot: 45.0,
      );

      expect(thresholds.getState(10), equals(ThermometerTemperatureState.cool));
      expect(
          thresholds.getState(22), equals(ThermometerTemperatureState.normal));
      expect(thresholds.getState(30), equals(ThermometerTemperatureState.warm));
      expect(thresholds.getState(42), equals(ThermometerTemperatureState.hot));
    });

    testWidgets('Supports optional humidity display and standalone HygrometerWidget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: ThermometerWidget(
                    celsius: 26.0,
                    humidity: 55.0,
                    showHumidity: true,
                    humidityPosition: ThermometerHumidityPosition.bottomPill,
                  ),
                ),
                HygrometerWidget(
                  humidity: 85.0,
                  size: 90,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ThermometerWidget), findsOneWidget);
      expect(find.byType(HygrometerWidget), findsOneWidget);
      expect(find.text('55%'), findsOneWidget);
      expect(find.text('85%'), findsOneWidget);
    });

    test('ThermometerHumidityThresholds correctly classifies humidity states', () {
      const humThresholds = ThermometerHumidityThresholds(
        dryThreshold: 30.0,
        humidThreshold: 60.0,
      );

      expect(humThresholds.getState(15), equals(ThermometerHumidityState.dry));
      expect(humThresholds.getState(45), equals(ThermometerHumidityState.comfortable));
      expect(humThresholds.getState(75), equals(ThermometerHumidityState.humid));
    });

    testWidgets('Triggers danger alert callback when temperature reaches criticalMaxCelsius', (tester) async {
      double? triggeredCelsius;
      bool? isMaxTriggered;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ThermometerWidget(
              celsius: 42.0,
              criticalMaxCelsius: 40.0,
              enableAlertVibration: true,
              onAlertTriggered: (c, isMax) {
                triggeredCelsius = c;
                isMaxTriggered = isMax;
              },
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(ThermometerWidget), findsOneWidget);
      expect(triggeredCelsius, equals(42.0));
      expect(isMaxTriggered, isTrue);
    });

    testWidgets('Supports custom text labels, units, and custom ThermometerColors', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ThermometerWidget(
              celsius: 25.0,
              humidity: 60.0,
              showHumidity: true,
              celsiusUnitLabel: 'م°',
              humidityUnitLabel: '٪',
              comfortableLabel: 'معتدل تماماً',
              colors: ThermometerColors(
                fluidPrimary: Colors.purple,
                majorText: Colors.purple,
                humidityText: Colors.purple,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(ThermometerWidget), findsOneWidget);
      expect(find.text('60٪'), findsOneWidget);
      expect(find.text('معتدل تماماً'), findsOneWidget);
    });

    testWidgets('Supports configurable topWidgetSpacing and humiditySpacing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ThermometerWidget(
              celsius: 30.0,
              humidity: 50.0,
              showHumidity: true,
              topWidgetSpacing: 25.0,
              humiditySpacing: 30.0,
              topWidget: Text('CUSTOM_TOP_HEADER'),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('CUSTOM_TOP_HEADER'), findsOneWidget);
      expect(find.byType(ThermometerWidget), findsOneWidget);
    });

    testWidgets('Supports autoTheme and fluidThemeBuilder dynamic color changing based on value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ThermometerWidget(
              celsius: 15.0,
              autoTheme: true,
              fluidThemeBuilder: (celsius, state) {
                if (celsius < 20) return ThermometerFluidTheme.cryoBlue;
                return ThermometerFluidTheme.redSpirit;
              },
              colorsBuilder: (celsius, state) {
                return ThermometerColors(
                  fluidPrimary: celsius < 20 ? Colors.blue : Colors.red,
                );
              },
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(ThermometerWidget), findsOneWidget);
    });
  });
}
