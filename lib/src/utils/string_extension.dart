extension StringExtension on String {
  /// Capitalises the first letter of a word.
  ///
  /// Example:
  /// ```dart
  /// 'hello'.capitalise // returns 'Hello'
  /// ```
  String get capitalise {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
