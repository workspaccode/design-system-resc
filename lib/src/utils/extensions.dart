import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// Bool (4)
// ═══════════════════════════════════════════════════════════════════════════════

extension BoolX on bool {
  bool get toggle => !this;
  int get toInt => this ? 1 : 0;
  String to([String t = 'Yes', String f = 'No']) => this ? t : f;
}

// ═══════════════════════════════════════════════════════════════════════════════
// Color (10)
// ═══════════════════════════════════════════════════════════════════════════════

extension ColorX on Color {
  Color get contrastText => isLight ? Colors.black : Colors.white;
  bool get isDark => computeLuminance() <= 0.5;
  bool get isLight => computeLuminance() > 0.5;
  String get toHex =>
      '#${(toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  String get toHexA =>
      '#${toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
  Color blend(Color other, double t) => Color.lerp(this, other, t)!;
  Color darken(double amount) =>
      Color.lerp(this, Colors.black, amount.clamp(0.0, 1.0))!;
  Color lighten(double amount) =>
      Color.lerp(this, Colors.white, amount.clamp(0.0, 1.0))!;
}

// ═══════════════════════════════════════════════════════════════════════════════
// BuildContext (29)
// ═══════════════════════════════════════════════════════════════════════════════

extension ContextX on BuildContext {
  /// Screen width breakpoints
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 840;
  static const double _desktopBreakpoint = 1200;

  /// Adaptive column count for grids/layouts
  int get adaptiveColumns {
    if (isWindowCompact) return 1;
    if (isWindowMedium) return 2;
    if (isWindowExpanded) return 3;
    return 4;
  }

  /// Adaptive padding based on screen size
  double get adaptivePadding {
    if (isWindowCompact) return 16;
    if (isWindowMedium) return 24;
    if (isWindowExpanded) return 32;
    return 40;
  }

  double get bottomInset => mq.viewInsets.bottom;
  double get bottomPadding => mq.padding.bottom;
  bool get canPop => Navigator.of(this).canPop();
  ColorScheme get colorScheme => theme.colorScheme;
  double get heightSize => mediaQuery.height;
  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isDesktop => screenWidth >= _desktopBreakpoint;
  bool get isLandscape => mq.orientation == Orientation.landscape;
  bool get isLightMode => theme.brightness == Brightness.light;

  /// Device type based on screen width
  bool get isMobile => screenWidth < _mobileBreakpoint;
  bool get isMobileLandscape => isMobile && isLandscape;

  /// Device orientation specific checks
  bool get isMobilePortrait => isMobile && isPortrait;
  bool get isPortrait => mq.orientation == Orientation.portrait;
  bool get isTablet =>
      screenWidth >= _mobileBreakpoint && screenWidth < _desktopBreakpoint;

  bool get isTabletLandscape => isTablet && isLandscape;

  bool get isTabletPortrait => isTablet && isPortrait;

  /// Material Design 3 window size classes
  bool get isWindowCompact => screenWidth < _mobileBreakpoint;

  bool get isWindowExpanded =>
      screenWidth >= _tabletBreakpoint && screenWidth < _desktopBreakpoint;
  bool get isWindowLarge => screenWidth >= _desktopBreakpoint;

  // ═══════════════════════════════════════════════════════════════════════════════
  // Responsive Breakpoints (Material Design 3)
  // ═══════════════════════════════════════════════════════════════════════════════

  bool get isWindowMedium =>
      screenWidth >= _mobileBreakpoint && screenWidth < _tabletBreakpoint;
  Size get mediaQuery => MediaQuery.sizeOf(this);
  MediaQueryData get mq => MediaQuery.of(this);

  double get screenHeight => mq.size.height;
  double get screenLongestSide => mq.size.longestSide;
  double get screenShortestSide => mq.size.shortestSide;

  Size get screenSize => mq.size;

  /// Screen size category for adaptive layouts
  String get screenSizeCategory {
    if (isWindowCompact) return 'compact';
    if (isWindowMedium) return 'medium';
    if (isWindowExpanded) return 'expanded';
    return 'large';
  }

  double get screenWidth => mq.size.width;
  TextTheme get textTheme => theme.textTheme;

  ThemeData get theme => Theme.of(this);
  double get topPadding => mq.padding.top;
  double get widthSize => mediaQuery.width;
  void appPop<T>([T? result]) => Navigator.pop(this, result);

  Future<T?> appPush<T>(Widget page) =>
      Navigator.push<T>(this, MaterialPageRoute(builder: (_) => page));

  Future<T?> appPushReplacement<T>(Widget page) =>
      Navigator.pushReplacement<T, dynamic>(
          this, MaterialPageRoute(builder: (_) => page));

  void appShowSnack(String msg, {Color? color}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg), backgroundColor: color));
  }

  /// Check if screen width is within a custom range
  bool isScreenWidthBetween(double min, double max) =>
      screenWidth >= min && screenWidth <= max;
}

// ═══════════════════════════════════════════════════════════════════════════════
// DateTime (12)
// ═══════════════════════════════════════════════════════════════════════════════

extension DateTimeX on DateTime {
  int get age => DateTime.now().difference(this).inDays ~/ 365;
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  bool get isFuture => isAfter(DateTime.now());

  bool get isPast => isBefore(DateTime.now());
  bool get isToday =>
      difference(DateTime.now()).inDays == 0 && day == DateTime.now().day;

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  DateTime get startOfDay => DateTime(year, month, day);

  String get timeAgo {
    final diff = DateTime.now().difference(this);
    if (diff.inSeconds < 60) return '${diff.inSeconds}s';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()}mo';
    return '${(diff.inDays / 365).floor()}y';
  }

  String formatDate({String sep = '-'}) =>
      '${year.toString().padLeft(4, '0')}$sep${month.toString().padLeft(2, '0')}$sep${day.toString().padLeft(2, '0')}';
  String formatTime() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

extension DoubleX on double {
  String formatCompact() {
    if (this >= 1000000) return '${(this / 1000000).toStringAsFixed(1)}M';
    if (this >= 1000) return '${(this / 1000).toStringAsFixed(1)}K';
    return toStringAsFixed(1);
  }

  double roundTo(int decimals) => double.parse(toStringAsFixed(decimals));
}

// ═══════════════════════════════════════════════════════════════════════════════
// EdgeInsets (3)
// ═══════════════════════════════════════════════════════════════════════════════

extension EdgeInsetsX on EdgeInsetsGeometry {
  EdgeInsets addAll(double v) =>
      resolve(TextDirection.ltr).add(EdgeInsets.all(v)) as EdgeInsets;
}

extension IntX on int {
  String formatCompact() {
    if (this >= 1000000) return '${(this / 1000000).toStringAsFixed(1)}M';
    if (this >= 1000) return '${(this / 1000).toStringAsFixed(1)}K';
    return toString();
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Iterable (8)
// ═══════════════════════════════════════════════════════════════════════════════

extension IterableX<T> on Iterable<T> {
  Iterable<T> distinctBy<K>(K Function(T) key) {
    final seen = <K>{};
    return where((e) => seen.add(key(e)));
  }

  List<R> mapIndexed<R>(R Function(int i, T e) fn) {
    var i = 0;
    return map((e) => fn(i++, e)).toList();
  }

  List<T> sortedBy<K extends Comparable<K>>(K Function(T) key) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));
  List<T> whereIndexed(bool Function(int i, T e) fn) {
    var i = 0;
    return where((e) => fn(i++, e)).toList();
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// List (14)
// ═══════════════════════════════════════════════════════════════════════════════

extension ListX<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull => isEmpty ? null : last;
  List<T> get unique => toSet().toList();
  double averageBy(num Function(T) fn) =>
      isEmpty ? 0 : fold(0.0, (s, e) => s + fn(e)) / length;

  List<List<T>> chunked(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, (i + size).clamp(0, length)));
    }
    return chunks;
  }

  Map<K, List<T>> groupBy<K>(K Function(T) key) {
    final map = <K, List<T>>{};
    for (final item in this) {
      map.putIfAbsent(key(item), () => []).add(item);
    }
    return map;
  }

  T? maxBy<K extends Comparable<K>>(K Function(T) key) {
    if (isEmpty) return null;
    return reduce((a, b) => key(a).compareTo(key(b)) >= 0 ? a : b);
  }

  T? minBy<K extends Comparable<K>>(K Function(T) key) {
    if (isEmpty) return null;
    return reduce((a, b) => key(a).compareTo(key(b)) <= 0 ? a : b);
  }

  T? safeGet(int index) => index >= 0 && index < length ? this[index] : null;
  List<T> separatedBy(Widget separator) =>
      expand((e) => [e, separator as T]).toList()..removeLast();

  int sumBy(int Function(T) fn) => fold(0, (s, e) => s + fn(e));
}

// ═══════════════════════════════════════════════════════════════════════════════
// Map (8)
// ═══════════════════════════════════════════════════════════════════════════════

extension MapX<K, V> on Map<K, V> {
  Map<K, V> merge(Map<K, V>? other) => {...this, ...?other};
  Map<K, V> omit(Iterable<K> keys) {
    final keySet = keys.toSet();
    return Map.fromEntries(entries.where((e) => !keySet.contains(e.key)));
  }

  Map<K, V> pick(Iterable<K> keys) {
    final result = <K, V>{};
    for (final key in keys) {
      if (containsKey(key)) result[key] = this[key] as V;
    }
    return result;
  }

  V? safeGet(K key) => containsKey(key) ? this[key] : null;
}

// ═══════════════════════════════════════════════════════════════════════════════
// Num / Double (12)
// ═══════════════════════════════════════════════════════════════════════════════

extension NumX on num {
  Widget get asIcon => Icon(null);
  Widget get hGap => SizedBox(width: toDouble());
  Widget get vGap => SizedBox(height: toDouble());
  bool isBetween(num a, num b) => this >= a && this <= b;
}

// ═══════════════════════════════════════════════════════════════════════════════
// Object (6)
// ═══════════════════════════════════════════════════════════════════════════════

extension ObjectX<T> on T {
  T? get nullIfNull => this;
  R let<R>(R Function(T) fn) => fn(this);
  T? takeIf(bool Function(T) test) => test(this) ? this : null;
}

// ═══════════════════════════════════════════════════════════════════════════════
// Platform specific extensions (9)
// ═══════════════════════════════════════════════════════════════════════════════

extension PlatformX on BuildContext {
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;
  bool get isDesktop =>
      Theme.of(this).platform == TargetPlatform.macOS ||
      Theme.of(this).platform == TargetPlatform.windows ||
      Theme.of(this).platform == TargetPlatform.linux;
  bool get isFuchsia => Theme.of(this).platform == TargetPlatform.fuchsia;
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
  bool get isLinux => Theme.of(this).platform == TargetPlatform.linux;
  bool get isMacOS => Theme.of(this).platform == TargetPlatform.macOS;
  bool get isMobilePlatform =>
      Theme.of(this).platform == TargetPlatform.android ||
      Theme.of(this).platform == TargetPlatform.iOS;
  bool get isWeb => kIsWeb;
  bool get isWindows => Theme.of(this).platform == TargetPlatform.windows;
}

// ═══════════════════════════════════════════════════════════════════════════════
// String (20)
// ═══════════════════════════════════════════════════════════════════════════════

extension StringX on String {
  String get capitalize =>
      isEmpty ? this : this[0].toUpperCase() + substring(1);
  String get capitalizeAll => split(' ').map((w) => w.capitalize).join(' ');
  String get digitsOnly => replaceAll(RegExp(r'[^0-9]'), '');
  bool get isAlpha => RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  bool get isAlphaNumeric => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);
  bool get isEmail => RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$').hasMatch(this);
  bool get isNumeric => double.tryParse(this) != null;

  bool get isPhone => RegExp(r'^[\+0-9]{7,15}$')
      .hasMatch(replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  bool get isStrongPassword =>
      length >= 8 &&
      contains(RegExp(r'[A-Z]')) &&
      contains(RegExp(r'[a-z]')) &&
      contains(RegExp(r'[0-9]')) &&
      contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
  bool get isUrl =>
      RegExp(r'^https?://[\w/-]+(\.[\w/-]+)+[/#?]?.*$').hasMatch(this);
  String get lettersOnly => replaceAll(RegExp(r'[^a-zA-Z]'), '');
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');
  String get toSlug =>
      trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-');
  String obscure({int visibleLast = 4}) => length <= visibleLast
      ? this
      : '*' * (length - visibleLast) + substring(length - visibleLast);
  double toDouble() => double.tryParse(this) ?? 0.0;
  int toInt() => int.tryParse(this) ?? 0;
  String truncate(int max) => length <= max ? this : '${substring(0, max)}...';
}

// ═══════════════════════════════════════════════════════════════════════════════
// TextStyle (3)
// ═══════════════════════════════════════════════════════════════════════════════

extension TextStyleX on TextStyle {
  TextStyle get w100 => copyWith(fontWeight: FontWeight.w100);
  TextStyle get w200 => copyWith(fontWeight: FontWeight.w200);
  TextStyle get w300 => copyWith(fontWeight: FontWeight.w300);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);
  TextStyle get w900 => copyWith(fontWeight: FontWeight.w900);
  TextStyle letter(double s) => copyWith(letterSpacing: s);
  TextStyle lineH(double h) => copyWith(height: h);
  TextStyle size(double s) => copyWith(fontSize: s);
  TextStyle withColor(Color c) => copyWith(color: c);
}

extension TimeFixed on num {
  Duration get daysApp =>
      TimeFixed(this * 1000 * 1000 * 60 * 60 * 24).microsecondsApp;
  Duration get hoursApp =>
      TimeFixed(this * 1000 * 1000 * 60 * 60).microsecondsApp;
  Duration get microsecondsApp => Duration(microseconds: round());
  Duration get millisecondsApp => TimeFixed(this * 1000).microsecondsApp;
  Duration get minutesApp => TimeFixed(this * 1000 * 1000 * 60).microsecondsApp;
  Duration get msApp => TimeFixed(this * 1000).microsecondsApp;
  Duration get secondsApp => TimeFixed(this * 1000 * 1000).microsecondsApp;
}
// ═══════════════════════════════════════════════════════════════════════════════
// Widget (12)
// ═══════════════════════════════════════════════════════════════════════════════

extension WidgetX on Widget {
  Widget get center => Center(child: this);
  Widget get hidden => this;
  Widget get slidable => this;
  Widget get visible => this;
  Widget clipAll(double r) =>
      ClipRRect(borderRadius: BorderRadius.circular(r), child: this);
  Widget expanded([int flex = 1]) => Expanded(flex: flex, child: this);
  Widget fadeIn({Duration? duration}) => this
      .animate()
      .fadeIn(duration: duration ?? const Duration(milliseconds: 400));
  Widget fadeOut({Duration? duration}) => this
      .animate()
      .fadeOut(duration: duration ?? const Duration(milliseconds: 400));
  Widget flexible([int flex = 1]) => Flexible(flex: flex, child: this);
  Widget onTap(VoidCallback cb) => GestureDetector(onTap: cb, child: this);
  Widget padAll(double v) => Padding(padding: EdgeInsets.all(v), child: this);
  Widget padDir(double v) =>
      Padding(padding: EdgeInsetsDirectional.all(v), child: this);
  Widget padDirOnly(
          {double start = 0,
          double end = 0,
          double top = 0,
          double bottom = 0}) =>
      Padding(
          padding: EdgeInsetsDirectional.only(
              start: start, end: end, top: top, bottom: bottom),
          child: this);
  Widget padDirSym({double start = 0, double end = 0}) => Padding(
      padding:
          EdgeInsetsDirectional.symmetric(horizontal: start, vertical: end),
      child: this);
  Widget padOnly({double l = 0, double t = 0, double r = 0, double b = 0}) =>
      Padding(
          padding: EdgeInsets.only(left: l, top: t, right: r, bottom: b),
          child: this);
  Widget padSym({double h = 0, double v = 0}) => Padding(
      padding: EdgeInsets.symmetric(horizontal: h, vertical: v), child: this);
  Widget slideIn({Duration? duration, Offset begin = const Offset(0, 24)}) =>
      this
          .animate()
          .slideY(
              begin: begin.dy,
              duration: duration ?? const Duration(milliseconds: 400))
          .fadeIn(duration: duration ?? const Duration(milliseconds: 400));
  Widget then(Widget Function() next) => Column(children: [this, next()]);
}
