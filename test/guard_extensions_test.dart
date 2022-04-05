import 'package:guard_clauses/guard_clauses.dart';
import 'package:test/test.dart';

enum Villians { harleyQuinn, poisonIvy, kingShark }

void main() {
  group('invalidInput', () {
    test('returns input when predicate returns true', () {
      String actual = Guard.against.invalidInput('taco', (param) => true);
      expect(actual, 'taco');
    });

    test('throws ArgumentError when predicate returns false', () {
      clause() => Guard.against.invalidInput(
            'taco',
            (param) => false,
            name: 'parameter1',
            message: 'my message',
          );

      expect(
          clause,
          throwsA(
            isA<ArgumentError>()
                .having(
                  (error) => error.message,
                  'message',
                  'my message',
                )
                .having(
                  (error) => error.invalidValue,
                  'invalidValue',
                  'taco',
                )
                .having(
                  (error) => error.name,
                  'name',
                  'parameter1',
                ),
          ));
    });
  });

  group('invalidFormat', () {
    test('returns input when regex match is found', () {
      String actual = Guard.against.invalidFormat('The dog', '^The');
      expect(actual, 'The dog');
    });

    test('throws ArgumentError when no regex matches found', () {
      clause() => Guard.against.invalidFormat(
            'batman drives the batmobile',
            'word\$',
            name: 'parameter1',
            message: 'my message',
          );

      expect(
          clause,
          throwsA(
            isA<ArgumentError>()
                .having(
                  (error) => error.message,
                  'message',
                  'my message',
                )
                .having(
                  (error) => error.invalidValue,
                  'invalidValue',
                  'batman drives the batmobile',
                )
                .having(
                  (error) => error.name,
                  'name',
                  'parameter1',
                ),
          ));
    });
  });

  group('negative', () {
    test('returns input when input is positive and non-zero', () {
      int actual = Guard.against.negative(17);
      expect(actual, 17);
    });

    test('returns input when input is zero', () {
      int actual = Guard.against.negative(0);
      expect(actual, 0);
    });

    test('throws ArgumentError when input is negative', () {
      clause() => Guard.against.negative(
            -23,
            name: 'parameter1',
            message: 'my message',
          );

      expect(
          clause,
          throwsA(
            isA<ArgumentError>()
                .having((error) => error.message, 'message', 'my message')
                .having((error) => error.invalidValue, 'invalidValue', -23)
                .having((error) => error.name, 'name', 'parameter1'),
          ));
    });
  });

  group('negativeOrZero', () {
    test('returns input when input is positive and non-zero', () {
      int actual = Guard.against.negativeOrZero(17);
      expect(actual, 17);
    });

    test('throws ArgumentError when input is negative', () {
      clause() => Guard.against.negative(-23);
      expect(clause, throwsA(isA<ArgumentError>()));
    });

    test('throws ArgumentError when input is zero', () {
      clause() => Guard.against.negativeOrZero(0);
      expect(clause, throwsA(isA<ArgumentError>()));
    });
  });

  group('nullValue', () {
    test('returns input when input is not null', () {
      int actual = Guard.against.nullValue(17);
      expect(actual, 17);
    });

    test('throws ArgumentError when input is null', () {
      String? nullValueString;
      clause() => Guard.against.nullValue(nullValueString, name: 'parameter1');

      expect(
          clause,
          throwsA(isA<ArgumentError>().having(
            (error) => error.name,
            'name',
            'parameter1',
          )));
    });
  });

  group('nullOrEmpty', () {
    test('returns input when input is not null or empty', () {
      String expected = 'harley quinn has a hammer';
      String actual = Guard.against.nullOrEmpty(expected);
      expect(expected, actual);
    });

    test('throws ArgumentError when input is null', () {
      String? nullValueString;
      clause() => Guard.against.nullOrEmpty(nullValueString, name: 'parameter1');

      expect(
          clause,
          throwsA(
            isA<ArgumentError>().having((error) => error.name, 'name', 'parameter1'),
          ));
    });

    test('throws ArgumentError when input is empty', () {
      clause() => Guard.against.nullOrEmpty('');
      expect(clause, throwsA(isA<ArgumentError>()));
    });
  });

  group('nullOrEmptyCollection', () {
    test('returns input when input is not null or empty', () {
      List<int> expected = [8, 6, 7, 5, 3, 0, 9];
      List<int> actual = Guard.against.nullOrEmptyCollection(expected);
      expect(expected, actual);
    });

    test('throws ArgumentError when input is null', () {
      List<String>? nullCollection;
      clause() => Guard.against.nullOrEmptyCollection(nullCollection, name: 'parameter1');

      expect(
          clause,
          throwsA(isA<ArgumentError>()
              .having((error) => error.name, 'name', 'parameter1')
              .having((error) => error.invalidValue, 'invalidValue', nullCollection)));
    });

    test('throws ArgumentError when input is empty', () {
      clause() => Guard.against.nullOrEmptyCollection(
            <String>[],
            name: 'parameter1',
            message: 'my message',
          );

      expect(
          clause,
          throwsA(
            isA<ArgumentError>()
                .having((error) => error.name, 'name', 'parameter1')
                .having((error) => error.invalidValue, 'invalidValue', <String>[]).having(
              (error) => error.message,
              'message',
              'my message',
            ),
          ));
    });
  });

  group('nullOrWhitespace', () {
    test('returns input when input is not null, empty, or whitespace', () {
      String expected = 'harley quinn has a hammer';
      String actual = Guard.against.nullOrWhitespace(expected);
      expect(expected, actual);
    });

    test('throws ArgumentError when input is null', () {
      String? nullValueString;
      clause() => Guard.against.nullOrWhitespace(nullValueString, name: 'parameter1');

      expect(
          clause,
          throwsA(
            isA<ArgumentError>().having((error) => error.name, 'name', 'parameter1'),
          ));
    });

    test('throws ArgumentError when input is empty', () {
      clause() => Guard.against.nullOrWhitespace('');
      expect(clause, throwsA(isA<ArgumentError>()));
    });

    test('throws ArgumentError when input is whitespace', () {
      clause() => Guard.against.nullOrWhitespace('      ');
      expect(clause, throwsA(isA<ArgumentError>()));
    });
  });

  group('nullOrInvalidInput', () {
    test('returns input when predicate returns true', () {
      int actual = Guard.against.nullOrInvalidInput(17, (input) => true);
      expect(actual, 17);
    });

    test('throws ArgumentError when input is null', () {
      clause() => Guard.against.nullOrInvalidInput<String>(null, (input) => false);
      expect(clause, throwsA(isA<ArgumentError>()));
    });

    test('throws ArgumentError when predicate returns false', () {
      clause() => Guard.against.nullOrInvalidInput('riddler is full of questions', (input) => false);
      expect(clause, throwsA(isA<ArgumentError>()));
    });
  });

  group('enumIndexOutOfRange', () {
    test('returns input when enum index exists', () {
      int actual = Guard.against.indexOutOfRange(2, Villians.values);
      expect(actual, 2);
    });

    test('throws RangeError when index is out of range', () {
      clause() => Guard.against.indexOutOfRange(3, Villians.values);
      expect(clause, throwsA(isA<RangeError>()));
    });

    test('throws RangeError when input is less than zero', () {
      clause() => Guard.against.indexOutOfRange(-1, Villians.values);
      expect(clause, throwsA(isA<RangeError>()));
    });
  });

  group('outOfRangeItems', () {
    test('returns input when input in range', () {
      List<int> expected = [2, 7, 9];
      List<int> actual = Guard.against.outOfRangeItems(expected, -1, 10);
      expect(actual, expected);
    });

    test('throws ArgumentError when rangeFrom is greater than rangeTo', () {
      clause() => Guard.against.outOfRangeItems([5, 5, 9], 17, 12);
      expect(clause, throwsA(isA<ArgumentError>()));
    });

    test('throws ArgumentError when a value is outside the lower range', () {
      clause() => Guard.against.outOfRangeItems([2, 5, 9], 3, 20);
      expect(clause, throwsA(isA<ArgumentError>()));
    });

    test('throws ArgumentError when a value is outside the upper range', () {
      clause() => Guard.against.outOfRangeItems([2, 5, 9], 1, 8);
      expect(clause, throwsA(isA<ArgumentError>()));
    });
  });

  group('outOfRange', () {
    test('returns input when input in range', () {
      double actual = Guard.against.outOfRange(17.0, 16.9, 17.1);
      expect(actual, 17.0);
    });

    test('throws ArgumentError when rangeFrom is greater than rangeTo', () {
      clause() => Guard.against.outOfRange(15, 17, 12);
      expect(clause, throwsA(isA<ArgumentError>()));
    });

    test('throws ArgumentError when input is outside the lower range', () {
      clause() => Guard.against.outOfRange(-2, -1, 20);
      expect(clause, throwsA(isA<ArgumentError>()));
    });

    test('throws ArgumentError when a value is outside the upper range', () {
      clause() => Guard.against.outOfRange(5, 1, 4);
      expect(clause, throwsA(isA<ArgumentError>()));
    });
  });

  group('zero', () {
    test('returns input when input is not zero', () {
      double positiveActual = Guard.against.zero(3.0);
      expect(positiveActual, 3.0);

      int negativeActual = Guard.against.zero(-2);
      expect(negativeActual, -2);
    });

    test('throws ArgumentError when input is zero', () {
      expect(() => Guard.against.zero(0), throwsA(isA<ArgumentError>()));
      expect(() => Guard.against.zero(0.0), throwsA(isA<ArgumentError>()));
    });
  });
}
