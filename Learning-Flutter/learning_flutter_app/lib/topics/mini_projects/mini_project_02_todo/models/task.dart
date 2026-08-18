class Task {
  String title;
  Priority priority;
  Label? label;
  bool isChecked = false;

  Task({required this.title, this.label, required this.priority});
}

enum Priority { low, medium, high }

enum Label { personal, work, chore }
