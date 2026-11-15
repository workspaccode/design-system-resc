import 'package:material_ui/material_ui.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> defaultOnGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(settings.name ?? 'Route')),
        body: Center(
          child: Text('No route defined for: ${settings.name}'),
        ),
      ),
    );
  }

  static RouteTransitionsBuilder get defaultTransition =>
      (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      };
}
