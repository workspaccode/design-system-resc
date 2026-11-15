import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;

void main() {
  group('AppScreenAnimated', () {
    testWidgets('renders without child', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimated(),
          ),
        ),
      );

      expect(find.byType(ds.AppScreenAnimated), findsOneWidget);
    });

    testWidgets('renders with child overlay', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimated(
              child: Text('Hello'),
            ),
          ),
        ),
      );

      expect(find.byType(ds.AppScreenAnimated), findsOneWidget);
      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('accepts custom color and ring count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimated(
              color: Colors.pinkAccent,
              secondaryColor: Colors.amberAccent,
              ringCount: 4,
              ringStrokeWidth: 3,
            ),
          ),
        ),
      );

      expect(find.byType(ds.AppScreenAnimated), findsOneWidget);
    });

    testWidgets('animates over time', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimated(),
          ),
        ),
      );

      expect(find.byType(ds.AppScreenAnimated), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 700));
      expect(find.byType(ds.AppScreenAnimated), findsOneWidget);
    });

    testWidgets('disposes without error', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimated(),
          ),
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(),
          ),
        ),
      );

      expect(find.byType(ds.AppScreenAnimated), findsNothing);
    });

    testWidgets('resizes with LayoutBuilder', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              height: 400,
              child: ds.AppScreenAnimated(),
            ),
          ),
        ),
      );

      expect(find.byType(ds.AppScreenAnimated), findsOneWidget);
    });
  });

  group('AppScreenAnimatedDot', () {
    testWidgets('renders with default size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimatedDot(),
          ),
        ),
      );

      expect(find.byType(ds.AppScreenAnimatedDot), findsOneWidget);
    });

    testWidgets('renders with custom size and color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimatedDot(
              size: 120,
              color: Colors.tealAccent,
              ringCount: 5,
            ),
          ),
        ),
      );

      expect(find.byType(ds.AppScreenAnimatedDot), findsOneWidget);
    });

    testWidgets('disposes without error', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimatedDot(),
          ),
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(),
          ),
        ),
      );

      expect(find.byType(ds.AppScreenAnimatedDot), findsNothing);
    });
  });

  group('AppScreenAnimatedField', () {
    testWidgets('renders with default dot count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimatedField(),
          ),
        ),
      );

      expect(find.byType(ds.AppScreenAnimatedField), findsOneWidget);
    });

    testWidgets('renders with custom config', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimatedField(
              dotCount: 3,
              color: Colors.deepPurpleAccent,
              dotSize: 80,
              pulseSpeed: 2.0,
            ),
          ),
        ),
      );

      expect(find.byType(ds.AppScreenAnimatedField), findsOneWidget);
    });

    testWidgets('animates over time', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimatedField(
              dotCount: 8,
              color: Colors.purpleAccent,
              pulseSpeed: 0.6,
              dotSize: 50,
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 1000));
      expect(find.byType(ds.AppScreenAnimatedField), findsOneWidget);
    });
  });

  group('AppScreenAnimatedAurora', () {
    testWidgets('renders with default colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimatedAurora(),
          ),
        ),
      );

      expect(find.byType(ds.AppScreenAnimatedAurora), findsOneWidget);
    });

    testWidgets('renders with custom colors and child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimatedAurora(
              backgroundColor: Color(0xFF0D0208),
              colors: [
                Color(0xFFFF6B35),
                Color(0xFFFF4E8C),
              ],
              blobCount: 3,
              blurSigma: 70,
              child: Text('Aurora'),
            ),
          ),
        ),
      );

      expect(find.byType(ds.AppScreenAnimatedAurora), findsOneWidget);
      expect(find.text('Aurora'), findsOneWidget);
    });

    testWidgets('animates over time', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimatedAurora(
              blobCount: 4,
              baseSpeed: 2.0,
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(ds.AppScreenAnimatedAurora), findsOneWidget);
    });

    testWidgets('disposes without error', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ds.AppScreenAnimatedAurora(),
          ),
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(),
          ),
        ),
      );

      expect(find.byType(ds.AppScreenAnimatedAurora), findsNothing);
    });
  });
}
