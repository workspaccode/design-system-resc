import 'package:material_ui/material_ui.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// TextEditingController (12)
// ═══════════════════════════════════════════════════════════════════════════════

extension TextEditingControllerX on TextEditingController {
  void cursorToEnd() {
    selection = TextSelection.fromPosition(
      TextPosition(offset: text.length),
    );
  }

  void cursorToStart() {
    selection = TextSelection.fromPosition(
      const TextPosition(offset: 0),
    );
  }

  void selectAll() {
    selection = TextSelection(
      baseOffset: 0,
      extentOffset: text.length,
    );
  }

  void replaceText(String replacement) {
    value = TextEditingValue(
      text: replacement,
      selection: TextSelection.collapsed(offset: replacement.length),
    );
  }

  void insertAtCursor(String insertion) {
    final pos = selection.baseOffset;
    final newText = '${text.substring(0, pos)}$insertion${text.substring(pos)}';
    value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: pos + insertion.length),
    );
  }

  void append(String suffix) {
    final newText = text + suffix;
    value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  void prepend(String prefix) {
    final newText = prefix + text;
    value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: prefix.length),
    );
  }

  bool get hasSelection => selection.isValid && selection.start != selection.end;
  bool get isBlank => text.trim().isEmpty;
  String? get nullIfBlank => text.trim().isEmpty ? null : text.trim();

  void removeLast() {
    if (text.isEmpty) return;
    final newText = text.substring(0, text.length - 1);
    value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// String validation (10)
// ═══════════════════════════════════════════════════════════════════════════════

extension StringValidationX on String {
  bool get isValidEmail =>
      RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(this);
  bool get isValidPhone =>
      length >= 7 && length <= 15 &&
      RegExp(r'^[\+0-9\s\-\(\)]+$').hasMatch(this);
  bool get isValidUrl =>
      RegExp(r'^https?://[\w/\-]+(\.[\w/\-]+)+[/#?]?.*$').hasMatch(this);
  bool get isValidPassword =>
      length >= 8 &&
      contains(RegExp(r'[A-Z]')) &&
      contains(RegExp(r'[a-z]')) &&
      contains(RegExp(r'[0-9]')) &&
      contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
  bool get isValidUsername =>
      length >= 3 && length <= 20 &&
      RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(this);
  bool get containsUppercase => contains(RegExp(r'[A-Z]'));
  bool get containsLowercase => contains(RegExp(r'[a-z]'));
  bool get containsNumber => contains(RegExp(r'[0-9]'));
  bool get containsSpecial => contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
  bool get isBlank => trim().isEmpty;
}

// ═══════════════════════════════════════════════════════════════════════════════
// String formatting (10)
// ═══════════════════════════════════════════════════════════════════════════════

extension StringFormatX on String {
  String get toTitleCase =>
      split(RegExp(r'[\s_\-]')).where((w) => w.isNotEmpty).map((w) =>
          w.length == 1
              ? w.toUpperCase()
              : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}').join(' ');

  String get toCamelCase {
    final words = split(RegExp(r'[\s_\-]')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return '';
    return words[0].toLowerCase() +
        words.skip(1).map((w) =>
            w[0].toUpperCase() + w.substring(1).toLowerCase()).join();
  }

  String get toSnakeCase =>
      trim().toLowerCase().replaceAll(RegExp(r'[\s\-]'), '_');

  String get toConstantCase =>
      trim().toUpperCase().replaceAll(RegExp(r'[\s\-]'), '_');

  String get stripNewlines => replaceAll(RegExp(r'[\r\n]+'), ' ');

  String ellipsis(int max) =>
      length <= max ? this : '${substring(0, max)}...';

  String padLeftTo(int length, {String pad = '0'}) =>
      this.length >= length ? this : this.padLeft(length, pad);

  String get removeDiacritics =>
      replaceAll(RegExp(r'[àáâãäå]'), 'a')
          .replaceAll(RegExp(r'[èéêë]'), 'e')
          .replaceAll(RegExp(r'[ìíîï]'), 'i')
          .replaceAll(RegExp(r'[òóôõö]'), 'o')
          .replaceAll(RegExp(r'[ùúûü]'), 'u')
          .replaceAll(RegExp(r'[ñ]'), 'n')
          .replaceAll(RegExp(r'[ç]'), 'c');

  String? get nullIfBlank => trim().isEmpty ? null : this;

  String withMax(int max) => length <= max ? this : substring(0, max);
}
