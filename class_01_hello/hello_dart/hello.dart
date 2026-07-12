void main() {
  print('Hello, Dart!');

  print("\n******************************\n");

  print("*** Lists ***");
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

  print("\n******************************\n");

  print("*** Types Conversion ***");
  // String -> int
  int age = int.parse('42');
  print(age);
  // String -> int (Safe: returns null if it fails, avoids crashes)
  int safeAge = int.tryParse('42px') ?? 0;
  print(safeAge);

  // String -> double
  double pi = double.parse('3.14');
  print(pi);

  // Number -> String
  String scoreStr = 100.toString();
  print(scoreStr);

  // double -> String (Format to specific decimal places)
  String price = 19.998.toStringAsFixed(2); // "20.00"
  print(price);

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
