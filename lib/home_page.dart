import 'package:flutter/material.dart';
import 'package:joyful/db/db_helper.dart';
import 'package:joyful/form_task.dart';
import 'package:joyful/model/task.dart';

import 'package:joyful/add_page.dart';
import 'package:provider/provider.dart';
import 'Provider/main_provider.dart';
import 'Provider/dark_theme_preferences.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> listTask = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    super.initState();
    _getAllTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JOYFUL'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listTask.length,
                  itemBuilder: (context, index) {
                    Task task = listTask[index];

                    return Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        splashColor: Colors.amber[300]!.withAlpha(30),
                        onTap: () {
                          _openFormEdit(task);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: task.isCompleted == 0 ? false : true,
                                onChanged: (bool? value) {
                                  markTaskCompleted(task, index);
                                },
                              ),
                              Expanded(
                                child: Text(
                                  '${task.task}',
                                  style: TextStyle(
                                      decoration: task.isCompleted == 1
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    _deleteTask(task, index);
                                  },
                                  icon: const Icon(Icons.close,
                                      color: Colors.red)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              ListTile(
                title: Text('Dark Mode'),
                trailing: DarkModeSwitch(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openFormCreate();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> _getAllTask() async {
    var list = await db.getAllTask();
    setState(() {
      listTask.clear();
      for (var task in list!) {
        listTask.add(Task.fromMap(task));
      }
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FormTask()));
    if (result == 'save') {
      await _getAllTask();
    }
  }

  Future<void> _openFormEdit(Task task) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormTask(task: task)));
    if (result == 'update') {
      await _getAllTask();
    }
  }

  Future<void> _deleteTask(Task task, int index) async {
    await db.deleteTask(task.id!);

    setState(() {
      listTask.removeAt(index);
    });
  }

  Future<void> markTaskCompleted(Task task, int index) async {
    await db.markTaskCompleted(Task.fromMap({
      'id': task.id,
      'task': task.task,
      'date': task.date,
      'time': task.time,
      'description': task.description,
      'isCompleted': task.isCompleted == 0 ? 1 : 0,
    }));

    setState(() {
      listTask[index].isCompleted = task.isCompleted == 0 ? 1 : 0;
    });
  }
}

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({super.key});

  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeIcon>(context);

        return Switch.adaptive(
          value: themeChange.darkTheme1,
          onChanged: (value) {
            themeChange.toogleTheme();
          },
        );
      }
  }
