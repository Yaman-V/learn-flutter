import 'package:learning_flutter_app/models/topic.dart';
import 'package:learning_flutter_app/topics/classes/classes.dart';
import 'package:learning_flutter_app/topics/assignments/assignments.dart';
import 'package:learning_flutter_app/topics/mini_projects/mini_projects.dart';

// This is the data list of I ever added
final List<Topic> topics = [
  // Assignments
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
  Topic(
    id: 'assignment_08',
    title: 'Forms: User Inputs',
    category: Category.assignments,
    builder: (context) => const Assignment08(),
  ),
  // Classes
  Topic(
    id: 'class_01',
    title: 'Hello FLutter!',
    category: Category.classes,
    builder: (context) => const Class01PersonalProfile(),
  ),
  Topic(
    id: 'class_02',
    title: 'Scaffold elements',
    category: Category.classes,
    builder: (context) => const Class02(),
  ),
  Topic(
    id: 'class_03',
    title: 'List View',
    category: Category.classes,
    builder: (context) => Class03(),
  ),
  Topic(
    id: 'class_04',
    title: 'Animations and Forms',
    category: Category.classes,
    builder: (context) => Class04(),
  ),
  Topic(
    id: 'class_05',
    title: 'Data from API',
    category: Category.classes,
    builder: (context) => Class05(),
  ),
  // Mini Projects
  Topic(
    id: 'mini_project_1',
    title: 'Rehab Tourism',
    category: Category.miniProjects,
    builder: (context) => TourismInRihab(),
  ),
];
