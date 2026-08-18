import 'package:flutter/material.dart';
import 'package:learning_flutter_app/topics/mini_projects/mini_project_02_todo/models/task.dart';

// TODO:
// 2. the main body should be a Row with two expanded children and each child is a list view. shoud I keep one list or two? and how to order if I should anyway.
// 3. Edit btn
// 4. Delete
// 5. coplete the task
// 6. design
// 7. Review and see how will cloud do it and the nesting and writting solutions

class TodoMainScreen extends StatefulWidget {
  const TodoMainScreen({super.key});

  @override
  State<TodoMainScreen> createState() => _TodoMainScreenState();
}

class _TodoMainScreenState extends State<TodoMainScreen> {
  List<Task> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos', style: TextStyle(fontSize: 30))),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => Card(
          child: Row(
            children: [
              Checkbox(
                value: tasks[index].isChecked,
                onChanged: (_) {
                  setState(() {
                    tasks[index].isChecked = !tasks[index].isChecked;
                  });
                },
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tasks[index].title),

                  Row(
                    children: [
                      Container(
                        color: Colors.blue,
                        child: Text((tasks[index].priority).toString()),
                      ),

                      if (tasks[index].label != null) ...[
                        const SizedBox(width: 15),
                        Container(
                          color: Colors.red,
                          child: Text(tasks[index].label.toString()),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
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
            backgroundColor: Colors.white,
            context: context,
            builder: (context) {
              //  Wrap in StatefulBuilder so your Dropdowns can visually update
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Container(
                    height: 900,
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
                                child: Text(item.toString()),
                              );
                            }).toList(),
                            onChanged: (newval) {
                              // -> Use setModalState to update UI inside the sheet
                              setModalState(() {
                                label = newval as Label;
                              });
                            },
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
                                child: Text(item.toString()),
                              );
                            }).toList(),
                            onChanged: (newval) {
                              //  Use setModalState to update UI inside the sheet
                              setModalState(() {
                                priority = newval as Priority;
                              });
                            },
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            if (titleController.text.trim().isEmpty) {
                              title = 'task #${tasks.length + 1}';
                            } else {
                              titleController.text.trim();
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
