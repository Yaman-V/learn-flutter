import 'package:learning_flutter_app/models/topic.dart';
import 'package:learning_flutter_app/screens/topics/classes/classes.dart';
import 'package:learning_flutter_app/screens/topics/assignments/assignments.dart';
import 'package:learning_flutter_app/screens/topics/mini_projects/mini_projects.dart';

// This is the data list of I ever added
final List<Topic> topics = [
  Topic(
    id: 'assignment_05',
    title: 'Drawer',
    category: Category.assignments,
    builder: (context) => const Assignment05Drawer(),
  ),
  Topic(
    id: 'assignment_06',
    title: 'Personal Profile',
    category: Category.assignments,
    builder: (context) => const Assignment06Profile(),
  ),
  Topic(
    id: 'assignment_07',
    title: 'List View',
    category: Category.assignments,
    builder: (context) => const Assignment07ListView(),
  ),
];
