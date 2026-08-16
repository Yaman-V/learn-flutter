Future<void> main() async {
  print('=== Async Programming Demo ===\n');

  await case1WithoutAwait();
  print('\n-----------------------------\n');

  await case2WithAwait();
  print('\n-----------------------------\n');

  await case3ThenChaining();
  print('\n-----------------------------\n');

  await case4TryCatchError();
}

// This file contains small async examples with real returned data.
// Each case shows a different async pattern.

/// Case 1:
/// Start a Future without await.
/// The code keeps moving, and the delayed result appears later.
Future<void> case1WithoutAwait() async {
  final stopwatch = Stopwatch()..start();

  // this format (cascade operator) is equivalent to:
  // final stopwatch = Stopwatch();
  // stopwatch.start();

  print('Case 1: without await');
  print('Start time: ${stopwatch.elapsedMilliseconds} ms');

  Future.delayed(const Duration(seconds: 2), () {
    print('Async result: user name = Ali');
  });

  print('This prints immediately');
  print('Current time: ${stopwatch.elapsedMilliseconds} ms');

  // ADD THIS: Wait for 3 seconds just to let the previous Future finish
  // before we return to main(), preventing console overlap.
  await Future.delayed(const Duration(seconds: 3));
}

/// Case 2:
/// Use await to wait for the Future and get the actual value.
Future<void> case2WithAwait() async {
  final stopwatch = Stopwatch()..start();

  print('Case 2: with await');
  print('Before await: ${stopwatch.elapsedMilliseconds} ms');

  final city = await Future.delayed(const Duration(seconds: 2), () => 'Amman');

  print('Received data: city = $city');
  print('After await: ${stopwatch.elapsedMilliseconds} ms');
}

/// Case 3:
/// Use .then() and return real data from the Future.
Future<void> case3ThenChaining() async {
  final stopwatch = Stopwatch()..start();

  print('Case 3: .then() chaining');
  print('Before Future: ${stopwatch.elapsedMilliseconds} ms');

  Future.delayed(const Duration(seconds: 2)).then((_) => 42).then((value) {
    print('Async result: value = $value');
    print('Printed after ${stopwatch.elapsedMilliseconds} ms');
  });

  print('After .then(): ${stopwatch.elapsedMilliseconds} ms');
}

/// Case 4:
/// Show error handling with a Future that throws an error.
Future<void> case4TryCatchError() async {
  final stopwatch = Stopwatch()..start();

  print('Case 4: try/catch');
  print('Before async work: ${stopwatch.elapsedMilliseconds} ms');

  try {
    // ignore: unused_local_variable
    final result = await Future.delayed(const Duration(seconds: 1), () {
      throw Exception('Failed to load data');
    });

    // print('Result: $result'); // This line will not run.
  } catch (e) {
    print('Caught error: $e');
    print('Error happened after ${stopwatch.elapsedMilliseconds} ms');
  }

  print('Program continued normally');
}

Future<void> case5FutureWait() async {
  final stopwatch = Stopwatch()..start();
  print('Case 5: Future.wait (Parallel Execution)');

  // Start both futures at the same time
  final future1 = Future.delayed(const Duration(seconds: 2), () => 'Profile');
  final future2 = Future.delayed(const Duration(seconds: 2), () => 'Settings');

  // Wait for BOTH to finish. This will take 2 seconds total, not 4!
  final results = await Future.wait([future1, future2]);

  print('Results: ${results[0]} and ${results[1]}');
  print('Finished in: ${stopwatch.elapsedMilliseconds} ms');
}

Future<void> case6CatchError() {
  print('Case 6: .catchError() with chaining');

  return Future.delayed(const Duration(seconds: 1), () {
    throw Exception('API crashed');
  }).then((data) => print('Success: $data')).catchError((error) {
    print('Caught error via chain: $error');
  });
}
