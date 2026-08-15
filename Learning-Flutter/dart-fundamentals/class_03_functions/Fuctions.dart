// TOPIC: Functions in Dart
// Run: dart run functions.dart
//
// Covers: positional/optional/named params, default values, arrow syntax,
// anonymous functions, functions as first-class values, closures,
// typedefs for function signatures.
//
// Deliberately deferred: generic functions (<T>), revisit alongside
// generics/OOP once you're comfortable with generics there first.

// --- Basic function ---
int add(int a, int b) {
  return a + b;
}

// --- Arrow syntax for single-expression bodies ---
int square(int x) => x * x;

// --- Optional positional parameters ([]) ---
String greet(String name, [String? title]) {
  if (title != null) return 'Hello, $title $name';
  return 'Hello, $name';
}

// --- Named parameters ({}) with defaults ---
// Named params are the idiom you'll see constantly in Flutter widgets.
void createUser({required String name, int age = 18, String role = 'user'}) {
  print('User: $name, age: $age, role: $role');
}

// --- Function as a parameter (higher-order function) ---
int applyOperation(int a, int b, int Function(int, int) operation) {
  return operation(a, b);
}

// --- typedef for a named function signature (readability) ---
typedef IntOperation = int Function(int, int);

int multiply(int a, int b) => a * b;

// --- Closures: function that captures surrounding state ---
Function makeCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

void main() {
  print(add(2, 3));
  print(square(5));

  print(greet('Yaman'));
  print(greet('Yaman', 'Eng.'));

  createUser(name: 'Yaman'); // uses defaults for age/role
  createUser(name: 'Yaman', age: 22, role: 'admin');

  // Passing a named function
  print(applyOperation(4, 5, multiply));

  // Passing an anonymous function inline
  print(applyOperation(4, 5, (a, b) => a - b));

  // Using the typedef explicitly
  IntOperation op = multiply;
  print(op(3, 3));

  // Closures — each call to makeCounter() has its own independent state
  final counterA = makeCounter();
  final counterB = makeCounter();
  print(counterA()); // 1
  print(counterA()); // 2
  print(counterB()); // 1 (independent from counterA)
}
