void main() {
  print('Hello, Dart!');
  print(' this file contains the basics and introduction to Dart.');

  print("\n***********Data Type**********\n");

  print("\n*** Numbers ***");
  // num is a superclass of int and double.
  int num1 = 100; // without decimal point.
  double num2 = 130.2; // with decimal point.
  num num3 = 50;
  num num4 = 50.4;

  // For Sum
  num sum = num1 + num2 + num3 + num4;

  // Printing Info
  print("Num 1 is $num1");
  print("Num 2 is $num2");
  print("Num 3 is $num3");
  print("Num 4 is $num4");
  print("Sum is $sum");
  // double to String with fixed decimal places
  double longdouble = 189.123456789;
  print("Fixed to 2 decimal places is ${longdouble.toStringAsFixed(2)}");

  // Intefer Division
  print(
    'To perform integer division in Dart, you can use the ~/ operator. This operator divides two numbers and returns the integer part of the result, discarding any remainder. For example:20 / 6 =  ${20 ~/ 6}',
  ); // 3

  print('\n*** Strings ***');
  print('multiple line string');
  // ignore: unused_local_variable
  String multiLineString = '''
 To create a multi-line string in Dart, you can use triple quotes (\'\'\') (either single or double). This allows you to write strings that span multiple lines without needing to concatenate them. ''';

  print('\n*** Immutable Variables ***');
  // ignore: unused_local_variable
  const String immutableString = 'This is an immutable string';
  print('to make an immutable variable, use the const keyword. ');
  // const vs final
  print('const vs fina');
  print(
    'const: compile-time constant, must be initialized at compile time, cannot be changed.',
  );
  print(
    'final: run-time constant, can be initialized at run time, cannot be changed.',
  );
  print(
    'meaning we use final when we want to assign a value to a variable that is not known at compile time (user input or runtime assignment).',
  );

  print('\n*** Dynamic Variables ***');
  print('dynamic vs var');
  print('dynamic: can hold any type of value, can change type at runtime.');
  print(
    'var: can hold any type of value, but once assigned a type, it cannot change type at runtime.',
  );

  dynamic myDynamicVariable = 42; // Initially an int
  print('Dynamic variable initially holds an int: $myDynamicVariable');
  myDynamicVariable = 'Hello, Dart!'; // Now a String
  var myVarVariable = 42; // Initially an int
  print(
    'Var variable initially holds an int: $myVarVariable. And not it can not be changed to a String. If we try to assign a String to it, it will throw an error.',
  );

  print('\n*** Type Conversion ***');
  // int & double -> String
  // int.toString()
  print('**int & double -> String**');
  int myInt = 42;
  double myDouble = 3.14;
  String intToString = myInt.toString();
  String doubleToString = myDouble.toStringAsFixed(
    2,
  ); // Format to 2 decimal places
  print('Int to String: $intToString');
  print('Double to String: $doubleToString');

  // String -> int & double
  // parse() and tryParse() methods
  print('**String -> int & double**');
  String intString = '42';
  String doubleString = '3.14';
  print(
    'converting String to int and double using parse() method',
  ); // parse(), if not valid will throw an exception
  int stringToInt = int.parse(intString);
  double stringToDouble = double.parse(doubleString);
  print('String to Int: $stringToInt');
  print('String to Double: $stringToDouble');
  print(
    'converting String to int and double using tryParse() method',
  ); // tryParse(), if not valid will return null, so remember sure to use '?'
  int? safeStringToInt = int.tryParse(intString);
  double? safeStringToDouble = double.tryParse(doubleString);
  print('String to Int (safe): $safeStringToInt');
  print('String to Double (safe): $safeStringToDouble');

  // double to int
  print('**double -> int**');
  double myDoubleValue = 3.99;
  int myIntValue = myDoubleValue.toInt();
  print('Double to Int: $myIntValue');

  print('\n*** Data Structures ***');

  print("\n*** Lists ***");

  // The list holds multiple values in a single variable. It is also called arrays. If you want to store multiple values without creating multiple variables, you can use a list.
  var fruits = [
    'Apple',
    'Banana',
    'Mango',
    'Lemon',
  ]; // var -> List<String> and unlike dynamic, it is type safe meaning it can only hold String values
  print(fruits);

  // mostly lists are used to store "date" real objects.
  List<dynamic> persons = [
    {
      "name": "John",
      "age": 30,
      "hobbies": ["Reading", "Swimming"],
    },
    {
      "name": "Jane",
      "age": 25,
      "hobbies": ["Cooking", "Traveling"],
    },
    {
      "name": "Bob",
      "age": 40,
      "hobbies": ["Fishing", "Hiking"],
    },
  ];
  print(persons);
  // to access the data in the list, we can use the index of the list and the key of the map.
  print(persons[0]['name']); // John
  print(persons[1]['hobbies'][0]); // Cooking

  print("\n*** Sets ***");
  // A set is an unordered collection of unique items. It is similar to a list, but it does not allow duplicate values. If you try to add a duplicate value to a set, it will be ignored.
  // Set<String> colors = {'Red', 'Green', 'Blue', 'Red'};
  // print(colors); // {Red, Green, Blue}

  print("\n*** Maps ***");
  // A map is a collection of key-value pairs. Keys are unique, and each key maps to exactly one value. Values can be of any type, and can be duplicated.
  Map<String, String> student = {'Arther': 'C+', 'John': 'F', 'Jane': 'A+'};
  print(student); // {Arther: C+, John: F, Jane: A+}

  print("\n******************************\n");

  print("*** String Interpolation ***");
  String str = 'Welcome to Dart';
  // print the same string but the first char is capitalized
  print(str[0].toUpperCase() + str.substring(1)); // Welcome to Dart

  String name = 'adam smith zana';
  // print the names capitalized
  List<String> names = name.split(' ');
  String capitalizedNames = names
      .map((n) => n[0].toUpperCase() + n.substring(1))
      .join(' ');
  print(capitalizedNames); // Adam Smith
}
