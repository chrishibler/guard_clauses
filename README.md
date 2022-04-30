<p align="center">
<img width=120 src="https://user-images.githubusercontent.com/137525/163580762-03c40c02-d75e-4ad6-a0af-9e516e1deaf4.svg">
</p>
<br />

<p align="center">
<a href="https://github.com/chrishibler/guard_clauses/actions"><img src="https://github.com/chrishibler/guard_clauses/workflows/build/badge.svg" alt="coverage"></a>
&nbsp
<a href="https://codecov.io/gh/chrishibler/guard_clauses"><img src="https://codecov.io/gh/chrishibler/guard_clauses/branch/main/graph/badge.svg?token=ZKK8W1KKAE" alt="build"></a>
</p>

# Guard Clauses

A dart port of the excellent [C# Guard Clauses](https://github.com/ardalis/GuardClauses) package by Ardalis.

A simple extensible package with guard clause extensions.

A [guard clause](https://deviq.com/design-patterns/guard-clause) is a software pattern that simplifies complex functions by "failing fast", checking for invalid inputs up front and immediately failing if any are found.

## Usage

```dart
void processOrder(Order? order)
{
    Guard.against.nullValue(order, 'order');

    // process order here
}

// OR

class Order
{
    String _name;
    int _quantity;
    double _max;
    double _unitPrice;

    Order(String name, int quantity, double max, double unitPrice) {
        _name = Guard.against.nullOrWhiteSpace(name);
        _quantity = Guard.against.negativeOrZero(quantity);
        _max = Guard.against.zero(max);
        _unitPrice = Guard.against.negative(unitPrice);
    }
}
```

## Supported Guard Clauses

- **Guard.against.invalidInput** (throws if predicate expression returns false)
- **Guard.against.invalidFormat** (throws if the input string doesn't match the provided regex)
- **Guard.against.negative** (throws if the input is negative)
- **Guard.against.negativeOrZero** (throws if the input is negative or zero)
- **Guard.against.nullValue** (throws if input is null)
- **Guard.against.nullOrEmpty** (throws if string input is null or empty)
- **Guard.against.nullOrEmptyCollection** (throws if the input collection is null or empty)
- **Guard.against.nullOrWhiteSpace** (throws if string input is null, empty or whitespace)
- **Guard.against.nullOrInvalidInput** (throws if input is null, or predicate expression returns false)
- **Guard.against.indexOutOfRange** (throws if input is not a valid index)
- **Guard.against.outOfRangeItems** (throws if any values in the input collection are outside the provided range)
- **Guard.against.outOfRange** (throws if the input collection is outside the provided range)
- **Guard.against.zero** (throws if number input is zero)

## Extending with your own Guard Clauses

To extend by creating your own guard clauses, create a new extension class for `Guard`.

```dart
extension GuardExtensions on Guard {
  /// Throws an ArgumentError if [input] is 'foo'.
  /// Returns [input] otherwise.
  String foo(String input, {String? name}) {
    if (input.toLowerCase()) {
      throw ArgumentError.value(input, name);
    }

    return input;
  }
}

// Usage
void sumpin(String otherSumpin) {
    Guard.against.foo(otherSumpin);
    ...
}
```


## References
The references are C#-centric but the concepts apply well.

- [Getting Started with Guard Clauses](https://blog.nimblepros.com/blogs/getting-started-with-guard-clauses/)
- [How to write clean validation clauses in .NET](https://www.youtube.com/watch?v=Tvx6DNarqDM) (Nick Chapsas, YouTube, 9 minutes)
- [Guard Clauses (podcast: 7 minutes)](https://www.weeklydevtips.com/004)
- [Guard Clause](https://deviq.com/guard-clause/)