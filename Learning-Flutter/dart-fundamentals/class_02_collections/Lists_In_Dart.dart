// ignore_for_file: dead_code

import 'dart:math';

void main() {
  print('*** Collections.dart ***');
  print(
    "This is the Collections file study main collections and useful methods",
  );

  print('\n*** List ***');
  print('this list 1 is fixed length and filled with 1');
  var list1 = List<int>.filled(
    5,
    1,
  ); // create a list of 5 elements filled with 1
  print(list1);

  print('this list 2 is growable and filled with Random numbers');
  List<int> list2 = List.generate(
    5,
    (_) => Random().nextInt(100),
    growable: true,
  );
  // create a list of 5 elements filled with random numbers
  print(list2);

  print('list 3 that add elements to the list 1 and list 2');
  // The ... operator in Dart is called the spread operator. It inserts all the elements of one collection into another collection.
  List<int> list3 = [
    ...list1,
    ...list2,
  ]; // create a list of 10 elements filled with the elements of list1 and list2
  print(list3);
  print(
    'add an element (6) after the 5th element to the list 3 using the insert method',
  );
  list3.insert(5, 6); // insert an element at the specified index
  print(list3);

  // raplaceRange()
  //  replaceRange takes 3 parameters: start, end index and the replacement, and replace the range with whatever is the replacment is.
  print(
    'replace all elemments exept the first and the last with 4, 5, 10 using the replaceRange. those two methods can take a target parameter',
  );

  list3.replaceRange(1, list3.length - 1, [
    4,
    5,
    10,
  ]); // replace all elements except the first and the last with 4, 5, 10
  print(list3);

  // Removing List Elements
  print(
    'we can remove first instant of target element using the remove(target) and last using the removeLast() method',
  );
  list3.remove(4); // remove the first element with value 4
  list3.removeLast(); // remove the last element
  print(list3);
  print(
    'if we want to remove element at a specific index we use removeAt(index)',
  );
  list3.removeAt(1); // remove the element at index 1
  print('this is the list3 after removing the element at index 1: $list3');
  print(
    'if we want to remove all elements from specific range we use removeRange(start, end) method',
  );
  list3.removeRange(1, 2); // remove all elements from index 1 to 2
  print(
    'this is the list3 after removing the elements from index 1 to 2: $list3',
  );

  print(
    ' if we all element that satisfy a specific condition we use removeWhere((element) => condition) method',
  );
  list3.removeWhere(
    (element) => element > 5,
  ); // remove all elements greater than 5
  print('this is the list3 after removing all elements greater than 5: $list3');

  print('\n*** Looping in Lists ***');
  List<int> list4 = List.generate(
    20,
    (index) => index + 1,
  ); // create a list of 20 elements filled with numbers from 1 to 20
  print('This is the list4: $list4');
  print(
    'we can use the forEach method to loop through the list and print each element',
  );
  list4.forEach((element) => print(element));

  print(
    '\nmap() method is used to transform each element of the list and return a new list with the transformed elements it does NOT change the original list',
  );
  List<int> list5 = list4.map((element) => element * 2).toList();
  print(
    'This is the list5: $list5 contains the elements of list4 multiplied by 2',
  );
  print('This is the list4: $list4');

  print(
    '\nwhere() method is used to filter the elements of the list and return a new list with the filtered elements it does NOT change the original list',
  );
  List<int> numbers = [1, 2, 3, 4, 5, 5, 7];
  print("This is the Original numbers: $numbers");
  List<int> doubleNumbers = numbers.map((num) => num * 2).toList();
  print("This is the doubleNumbers: $doubleNumbers");
  List<int> evenNumbers = numbers.where((num) => num % 2 == 0).toList();
  print("This is the evenNumbers: $evenNumbers");

  print('\n*** Collection if and for ***');
  // also we can use conditions inside the list
  var conditionalList = [
    1,
    2,
    if (true)
      3, // if the condition is true, the value will be added to the list
    if (false)
      4, // if the condition is false, the value will not be added to the list
  ];
  print("This is the conditionalList: $conditionalList");

  // also we can use loops inside the list
  var loopList = [
    for (var i = 0; i < 5; i++)
      i, // the loop will run 5 times and add the value of i to the list
    // However, using the {} ??
  ];
  print("This is the loopList: $loopList");
}
