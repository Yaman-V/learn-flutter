// TOPIC: Random numbers in Dart (dart:math)
// Run: dart run random_numbers.dart
//
// Covers: Random(), nextInt, nextDouble, nextBool, seeded Random
// for reproducibility, generating a random list, random pick from a list.
//
// Deliberately deferred: cryptographically secure randomness
// (Random.secure()) — revisit if you ever need tokens/secrets, not just
// UI-level randomness.

import 'dart:math';

void main() {
  final rand = Random();

  // --- Basic random values ---
  print(rand.nextInt(100)); // random int in [0, 100)
  print(rand.nextDouble()); // random double in [0.0, 1.0)
  print(rand.nextBool()); // random true/false

  // --- Random int in a custom range, e.g. [10, 20] ---
  int randomInRange(int min, int max) {
    return min + rand.nextInt(max - min + 1);
  }

  print(randomInRange(10, 20));

  // --- Seeded Random: reproducible sequence (useful for tests) ---
  final seeded1 = Random(42);
  final seeded2 = Random(42);
  print(seeded1.nextInt(1000) == seeded2.nextInt(1000)); // true, same seed

  // --- Generating a random list ---
  final randomList = List<int>.generate(5, (_) => rand.nextInt(50));
  print(randomList);

  // --- Random pick from an existing list ---
  final langs = ['Java', 'Dart', 'Python', 'Kotlin'];
  final pick = langs[rand.nextInt(langs.length)];
  print('Random pick: $pick');

  // --- Shuffling a list in place ---
  final numbers = [1, 2, 3, 4, 5];
  numbers.shuffle(rand);
  print(numbers);
}
