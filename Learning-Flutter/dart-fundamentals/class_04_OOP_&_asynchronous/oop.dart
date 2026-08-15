// TOPIC: OOP in Dart
// Run: dart run oop.dart
//
// Covers: classes & constructors, named constructors, factory constructors,
// inheritance, abstract classes, interfaces (implements), mixins,
// getters/setters, static members.
//
// Deliberately deferred: generics on classes (class Box<T>) and
// operator overloading — revisit once you're building your own
// data-structure-style classes.

// --- Abstract class acting as an interface-ish contract ---
abstract class Shape {
  double area(); // no body -> subclasses must implement
  String describe() => 'A shape with area ${area().toStringAsFixed(2)}';
}

// --- Basic class + constructor + inheritance ---
class Circle extends Shape {
  final double radius;

  Circle(this.radius); // shorthand constructor assigning to field directly

  @override
  double area() => 3.14159 * radius * radius;
}

class Rectangle extends Shape {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  // Named constructor: alternate way to construct the same type
  Rectangle.square(double side) : width = side, height = side;

  @override
  double area() => width * height;
}

// --- Mixin: reusable behavior without inheritance ---
mixin Loggable {
  void log(String message) => print('[LOG] $message');
}

class Circle2 extends Circle with Loggable {
  Circle2(super.radius);
}

// --- Getters/setters + static members ---
class Counter {
  int _value = 0; // underscore = private to the library/file

  int get value => _value; // getter
  set value(int newValue) {
    // setter with validation
    if (newValue < 0) throw ArgumentError('Cannot be negative');
    _value = newValue;
  }

  static int instancesCreated = 0; // shared across all instances

  Counter() {
    Counter.instancesCreated++;
  }
}

// --- Factory constructor: returns cached/existing instance instead of new one ---
class Logger {
  static final Map<String, Logger> _cache = {};
  final String name;

  Logger._internal(this.name); // private named constructor

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }
}

void main() {
  final circle = Circle(3);
  final rect = Rectangle(4, 5);
  final square = Rectangle.square(4);

  print(circle.describe());
  print(rect.describe());
  print(square.describe());

  final loggingCircle = Circle2(2);
  loggingCircle.log('Created a logging-enabled circle');
  print(loggingCircle.area());

  final counter = Counter();
  counter.value = 10;
  print(counter.value);
  print('Counters created: ${Counter.instancesCreated}');

  // Factory returns the SAME instance for the same name
  final logA = Logger('network');
  final logB = Logger('network');
  print(identical(logA, logB)); // true
}
