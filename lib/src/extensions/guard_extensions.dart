import '../guard.dart';

extension GuardExtensions on Guard {
  /// Throws an ArgumentError if [input] doesn't match the [regexPattern].
  /// Returns [input] otherwise.
  String invalidFormat(
    String input,
    String regexPattern, {
    String? name,
    String? message,
    bool caseSensitive = true,
    bool multiline = false,
  }) {
    RegExpMatch? match = RegExp(regexPattern).firstMatch(input);
    if (match == null) {
      throw ArgumentError.value(
          input, name, message ?? 'Input was not in required format');
    }

    return input;
  }

  /// Throws an ArgumentError if [input] doesn't satisfy the predicate function.
  /// Returns [input] otherwise.
  T invalidInput<T>(
    T input,
    bool Function(T) predicate, {
    String? name,
    String? message,
  }) {
    if (!predicate(input)) {
      throw ArgumentError.value(
          input, name, message ?? 'Input did not satisfy the requirement');
    }

    return input;
  }

  /// Throws an ArgumentError if [input] is negative. Returns [input] otherwise.
  T negative<T extends num>(
    T input, {
    String? name,
    String? message,
  }) {
    if (input < 0) {
      throw ArgumentError.value(
          input, name, message ?? "Required input cannot be negative.");
    }

    return input;
  }

  /// Throws an ArgumentError if [input] is negative or zero. Returns [input] otherwise.
  T negativeOrZero<T extends num>(
    T input, {
    String? name,
    String? message,
  }) {
    if (input <= 0) {
      throw ArgumentError.value(
          input, name, message ?? 'Required input cannot be zero or negative.');
    }

    return input;
  }

  /// Throws an ArgumentError if [input] is null. Returns [input] otherwise.
  T nullValue<T>(T input, {String? name}) {
    if (input == null) {
      throw ArgumentError.notNull(name);
    }

    return input;
  }

  /// Throws an ArgumentError if [input] is null or empty. Returns [input] otherwise.
  String nullOrEmpty(String? input, {String? name, String? message}) {
    nullValue(input, name: name);

    if (input == '') {
      throw ArgumentError.value(
          input, name, message ?? 'Input cannot be empty.');
    }

    return input!;
  }

  /// Throws an ArgumentError if [input] is null or an empty collection. Returns input otherwise.
  T nullOrEmptyCollection<T extends Iterable>(
    T? input, {
    String? name,
    String? message,
  }) {
    nullValue(input, name: name);
    if (input!.isEmpty) {
      throw ArgumentError.value(
          input, name, message ?? 'Input cannot be an empty collection.');
    }

    return input;
  }

  /// Throws an ArgumentError if [input] is null, empty, or white space. Returns [input] otherwise.
  String nullOrWhitespace(String? input, {String? name, String? message}) {
    nullOrEmpty(input, name: name, message: message);
    if (input!.trim() == '') {
      throw ArgumentError.value(
          input, name, message ?? 'Input was null, empty, or whitespace.');
    }

    return input;
  }

  /// Throws an ArgumentError if [input] is null or doesn't satisfy the [predicate] function.
  /// Returns [input] otherwise.
  T nullOrInvalidInput<T>(
    T? input,
    bool Function(T?) predicate, {
    String? name,
    String? message,
  }) {
    nullValue(input, name: name);
    return invalidInput(
      input!,
      predicate,
      name: name,
      message: message,
    );
  }

  /// Throws a RangeError if [input] is not a valid enum index. Returns [input] otherwise.
  int indexOutOfRange(int input, Iterable values, {String? name}) {
    if (values.length - 1 < input || input < 0) {
      throw RangeError.index(input, values);
    }
    return input;
  }

  /// Throws an ArgumentError if any [input] item is less than [rangeFrom] or greater than [rangeTo].
  /// Returns [input] otherwise.
  T outOfRangeItems<T extends Iterable, U extends Comparable>(
    T input,
    U rangeFrom,
    U rangeTo, {
    String? name,
    String? message,
  }) {
    if (rangeFrom.compareTo(rangeTo) > 0) {
      throw ArgumentError(
          message ?? 'rangeFrom should be less than or equal to rangeTo', name);
    }

    if (input
        .any((x) => x.compareTo(rangeFrom) < 0 || x.compareTo(rangeTo) > 0)) {
      throw ArgumentError(message ?? 'Input had out of range items.', name);
    }

    return input;
  }

  /// Throws a RangeError if [input] is less than [rangeFrom] or greater than [rangeTo].
  /// Returns [input] otherwise.
  T outOfRange<T extends Comparable>(
    T input,
    T rangeFrom,
    T rangeTo, {
    String? name,
    String? message,
  }) {
    if (rangeFrom.compareTo(rangeTo) > 0) {
      throw RangeError('rangeFrom should be less than or equal to rangeTo');
    }

    if (input.compareTo(rangeFrom) < 0 || input.compareTo(rangeTo) > 0) {
      throw RangeError(message ?? 'Input was out of range');
    }

    return input;
  }

  /// Throws an ArgumentError if [input] is zero. Returns [input] otherwise.
  T zero<T extends num>(T input, {String? name, String? message}) {
    if (input == 0) {
      throw ArgumentError.value(input, name, message ?? 'Input cannot be zero');
    }
    return input;
  }
}
