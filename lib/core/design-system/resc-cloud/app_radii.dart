import 'package:material_ui/material_ui.dart';

/// **Radius tokens.** Used everywhere a corner radius is needed.
class AppRadii {
  AppRadii._();

  static const double xs = 6;
  static const double sm = 10;
  static const double md = 12; // inputs, chips
  static const double lg = 16; // cards
  static const double xl = 20;
  static const double xxl = 24; // bottom sheets
  static const double pill = 999;

  static BorderRadius circular(double r) => BorderRadius.circular(r);
  static BorderRadius all(double r) => BorderRadius.all(Radius.circular(r));

  static const BorderRadius card = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius input = BorderRadius.all(Radius.circular(md));
  static const BorderRadius chip = BorderRadius.all(Radius.circular(pill));
  static const BorderRadius sheet = BorderRadius.vertical(
    top: Radius.circular(xxl),
  );
}
