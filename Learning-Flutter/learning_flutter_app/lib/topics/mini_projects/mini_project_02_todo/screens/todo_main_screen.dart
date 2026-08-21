import 'package:flutter/material.dart';
import 'package:learning_flutter_app/topics/mini_projects/mini_project_02_todo/models/task.dart';

class TodoMainScreen extends StatefulWidget {
  const TodoMainScreen({super.key});

  @override
  State<TodoMainScreen> createState() => _TodoMainScreenState();
}

class _TodoMainScreenState extends State<TodoMainScreen> {
  List<Task> tasks = [];
  List<Task> get activeTasks => tasks.where((t) => !t.isChecked).toList();
  List<Task> get doneTasks => tasks.where((t) => t.isChecked).toList();

  void _toggleTask(Task task) {
    setState(() => task.isChecked = !task.isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos', style: TextStyle(fontSize: 30))),
      body: CustomScrollView(
        slivers: [
          // Active List
          _ActiveTasksList(
            activeTasks: activeTasks,
            onTaskToggled: _toggleTask,
          ),

          // Divider
          _TasksDivider(doneTasksLength: doneTasks.length),

          // Done Tasks List
          _DoneTasksList(doneTasks: doneTasks, onTaskToggled: _toggleTask),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          // Move variables and controller OUTSIDE the builder
          // so they survive layout rebuilds (like the keyboard closing).

          // Defult Val
          String title = 'task #${tasks.length + 1}';
          Priority priority = Priority.low;
          Label? label;
          final titleController = TextEditingController();

          // Await the result of the bottom sheet. Note it can be null if dismissed.
          Task? newTask = await showModalBottomSheet<Task>(
            isScrollControlled: true,
            backgroundColor: Colors.white,
            context: context,
            builder: (context) {
              //  Wrap in StatefulBuilder so your Dropdowns can visually update
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    margin: EdgeInsets.all(20),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                              hintText: 'What needs to be done',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),

                        Expanded(
                          child: DropdownButton(
                            menuWidth: double.infinity,
                            value: label,
                            hint: const Text('Select label'),
                            items: Label.values.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (newval) =>
                                setModalState(() => label = newval),
                          ),
                        ),

                        Expanded(
                          child: DropdownButton(
                            menuWidth: double.infinity,
                            value: priority,
                            hint: const Text('Select priority'),
                            items: Priority.values.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (newval) {
                              if (newval != null) {
                                setModalState(() => priority = newval);
                              }
                            },
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            if (titleController.text.trim().isEmpty) {
                              title = 'task #${tasks.length + 1}';
                            } else {
                              title = titleController.text.trim();
                            }

                            Navigator.pop(
                              context,
                              Task(
                                title: title,
                                priority: priority,
                                label: label,
                              ),
                            );
                          },
                          child: Text('Done'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );

          // Always dispose controllers when done
          titleController.dispose();

          // Only add the task if the user pressed 'Done' (didn't just swipe it away)
          if (newTask != null) {
            setState(() {
              tasks.add(newTask);
            });
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _TasksDivider extends StatelessWidget {
  final int doneTasksLength;
  const _TasksDivider({super.key, required this.doneTasksLength});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            const Expanded(child: Divider(thickness: 1, color: Colors.black26)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Completed ($doneTasksLength)', // simple trick here.
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: Divider(thickness: 1, color: Colors.black26)),
          ],
        ),
      ),
    );
  }
}

class _ActiveTasksList extends StatelessWidget {
  final List<Task> activeTasks;

  //   callback function parameter so the parent handel the state managment?
  final Function(Task task) onTaskToggled;
  const _ActiveTasksList({
    super.key,
    required this.activeTasks,
    required this.onTaskToggled,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Card(
          child: Row(
            children: [
              // checkbox
              Checkbox(
                value: activeTasks[index].isChecked,
                onChanged: (_) => onTaskToggled(activeTasks[index]),
              ),
              // Tasks details
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(activeTasks[index].title),
                  Row(
                    children: [
                      Container(
                        color: Colors.blue,
                        child: Text((activeTasks[index].priority).name),
                      ),
                      if (activeTasks[index].label != null) ...[
                        const SizedBox(width: 15),
                        Container(
                          color: Colors.red,
                          child: Text(activeTasks[index].label!.name),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        childCount: activeTasks.length,
      ),
    );
  }
}

class _DoneTasksList extends StatelessWidget {
  final List<Task> doneTasks;
  final Function(Task task) onTaskToggled;

  const _DoneTasksList({
    super.key,
    required this.doneTasks,
    required this.onTaskToggled,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Card(
          child: Row(
            children: [
              Checkbox(
                value: doneTasks[index].isChecked,
                onChanged: (_) => onTaskToggled(doneTasks[index]),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doneTasks[index].title),

                  Row(
                    children: [
                      Container(
                        color: Colors.blue,
                        child: Text((doneTasks[index].priority).name),
                      ),

                      if (doneTasks[index].label != null) ...[
                        const SizedBox(width: 15),
                        Container(
                          color: Colors.red,
                          child: Text(doneTasks[index].label!.name),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        childCount: doneTasks.length,
      ),
    );
  }
}
