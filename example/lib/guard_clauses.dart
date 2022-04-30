import 'package:guard_clauses/guard_clauses.dart';

/// Represents a majestic unicorn.
class Unicorn {
  bool likesCandy = true;
  bool lovesRainbows = true;

  /// Pose the unicorn to take a selfie with it.
  void pose(int poseDurationInSeconds, String poseDescription) {
    Guard.against.negativeOrZero(poseDurationInSeconds);
    Guard.against.nullOrWhitespace(poseDescription, name: 'poseDescription', message: 'must have a value');

    print("the 'corn posed for $poseDurationInSeconds in the following way: $poseDescription");
  }

  /// The corn eats some skittles.
  void eatSkittles(int numSkittles) {
    print('corn ate ${Guard.against.negative(numSkittles)} yummy skittles');
  }
}

/// Represents a pretty rainbow.
class Rainbow {
  /// The unicorn will ride the rainbow.
  void ride(Unicorn corn) {
    Guard.against.invalidInput<Unicorn>(corn, (u) => u.lovesRainbows, name: 'corn', message: 'must love rainbows');
    print('the unicorn jumps into the air breathtakingly and flys on the rainbow');
  }

  /// Change the displayed colors of the rainbow.
  void changeColors(List<String> newColors) {
    Guard.against.nullOrEmptyCollection(newColors);
  }
}
