void main() {
  // ---------------------------------------------------------
  // 1. CREATION & ACCESS
  // ---------------------------------------------------------
  // Creating a Map where keys and values must be of type String
  Map<String, String> countryCapital = {
    'USA': 'Washington, D.C.',
    'India': 'New Delhi',
    'China': 'Beijing',
  };

  // Accessing a value by its key
  print("Accessing value for USA: ${countryCapital['USA']}");

  // ---------------------------------------------------------
  // 2. ADDING, UPDATING & REMOVING
  // ---------------------------------------------------------
  // Adding a new element to the existing Map
  countryCapital['Japan'] = 'Tokio';

  // Updating an existing element of the Map
  countryCapital['USA'] = 'Washington, D.C.'; // Updating item

  // Removing an item from the Map
  countryCapital.remove('USA');

  // ---------------------------------------------------------
  // 3. MAP PROPERTIES
  // ---------------------------------------------------------
  Map<String, double> expenses = {'sun': 3000.0, 'mon': 3000.0, 'tue': 3234.0};

  print("All keys of Map: ${expenses.keys}");
  print("All values of Map: ${expenses.values}");
  print("Is Map empty: ${expenses.isEmpty}");
  print("Is Map not empty: ${expenses.isNotEmpty}");
  print("Length of map is: ${expenses.length}");

  // ---------------------------------------------------------
  // 4. MAP METHODS
  // ---------------------------------------------------------
  // Converting keys and values to Lists
  print("All keys with List: ${expenses.keys.toList()}");
  print("All values with List: ${expenses.values.toList()}");

  // Checking if the Map contains a specific key or value
  print("Does Map contain key sun: ${expenses.containsKey('sun')}");
  print("Does Map contain value 3000.0: ${expenses.containsValue(3000.0)}");

  // ---------------------------------------------------------
  // 5. LOOPING OVER MAPS
  // ---------------------------------------------------------
  Map<String, dynamic> book = {
    'title': 'Misson Mangal',
    'author': 'Kuber Singh',
    'page': 233,
  };

  // Looping using Map.entries
  for (MapEntry entry in book.entries) {
    print('Key is ${entry.key}, value ${entry.value}');
  }

  // Looping using forEach
  book.forEach((key, value) => print('Key is $key and value is $value'));
}
