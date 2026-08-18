import 'package:flutter/material.dart';
import 'package:learning_flutter_app/topics/mini_projects/mini_project_02_todo/models/task.dart';

// TODO:
// 1. Add model to enter task using `showModalBottomSheet`
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
                      SizedBox(width: 15),
                      Container(
                        color: Colors.red,
                        child: Text((tasks[index].label).toString()),
                      ),
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
          Task newTask = await showModalBottomSheet(
            backgroundColor: Colors.white,
            context: context,
            builder: (context) {
              String title = '';
              Priority priority = Priority.low;
              Label label = Label.work;

              final titileController = TextEditingController();

              return Container(
                height: 900,
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: titileController,
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
                          label = newval!;
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
                          priority = newval!;
                        },
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        title = titileController.text.trim();
                        Navigator.pop(
                          context,
                          Task(title: title, priority: priority, label: label),
                        );
                      },
                      child: Text('Done'),
                    ),
                  ],
                ),
              );
            },
          );

          setState(() {
            tasks.add(newTask);
          });
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
