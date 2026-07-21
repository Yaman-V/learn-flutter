// TOPIC: String manipulation in Dart
// Run: dart run string_manipulation.dart
//
// Covers: interpolation, concatenation, multi-line/raw strings,
// case conversion, trimming, splitting/joining, replace, contains,
// substring, StringBuffer for efficient building.
//
// Deliberately deferred (revisit when needed): RegExp-based parsing,
// String.codeUnits / rune-level unicode handling.

void main() {
  // --- Interpolation & concatenation ---
  final name = 'Yaman';
  final track = 'Flutter';
  print('Hello, $name!'); // simple interpolation
  print('Learning: ${track.toUpperCase()}'); // expression interpolation
  final combined = name + ' - ' + track; // concatenation with +
  print(combined);

  // --- Multi-line & raw strings ---
  final multiLine = '''
  This spans
  multiple lines.
  ''';
  print(multiLine.trim());

  final rawPath = r'C:\Users\yaman\dart_gaps'; // raw string, no escaping
  print(rawPath);

  // --- Case conversion & trimming ---
  final messy = '   Some MESSY text   ';
  print(messy.trim().toLowerCase()); // 'some messy text'
  print(messy.trim().toUpperCase()); // 'SOME MESSY TEXT'

  // --- Splitting & joining ---
  final csv = 'java,dart,python';
  final langs = csv.split(','); // ['java', 'dart', 'python']
  print(langs);
  print(langs.join(' | ')); // 'java | dart | python'

  // --- Searching & replacing ---
  final sentence = 'Dart is fun, Dart is fast';
  print(sentence.contains('fast')); // true
  print(sentence.replaceAll('Dart', 'Flutter'));
  print(sentence.replaceFirst('Dart', 'Flutter')); // only first match

  // --- Substrings & indexing ---
  final word = 'BackendJourney';
  print(word.substring(0, 7)); // 'Backend'
  print(word[0]); // 'B' (indexing gives a String, not char)
  print(word.indexOf('Journey')); // 7

  // --- StringBuffer: efficient building in loops ---
  // Using + in a loop creates a new String each time (O(n^2) behavior).
  // StringBuffer avoids that.
  final buffer = StringBuffer();
  for (var i = 1; i <= 5; i++) {
    buffer.write('item$i ');
  }
  print(buffer.toString().trim());

  // --- Useful checks ---
  print(''.isEmpty); // true
  print('  '.trim().isEmpty); // true
  print('123'.isEmpty); // false
}
