import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:joyful/db/db_helper.dart';
import 'model/task.dart';
import 'Provider/Theme_data.dart';
import 'Provider/dark_theme_preferences.dart';
import 'Provider/main_provider.dart';

class FormTask extends StatefulWidget {
  final Task? task;

  const FormTask({this.task});

  @override
  State<FormTask> createState() => _FormTaskState();
}

class _FormTaskState extends State<FormTask> {
  DbHelper db = DbHelper();

  DateTime now = DateTime.now();
  TextEditingController? _task;
  TextEditingController? _date;
  TextEditingController? _time;
  TextEditingController? _description;

  @override
  void initState() {
    _task = TextEditingController(
        text: widget.task == null ? '' : widget.task!.task);
    _date = TextEditingController(
        text: widget.task == null ? '' : widget.task!.date);
    _time = TextEditingController(
        text: widget.task == null ? '' : widget.task!.time);
    _description = TextEditingController(
        text: widget.task == null ? '' : widget.task!.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _task,
                decoration: const InputDecoration(
                  labelText: 'Tugas',
                  icon: Icon(Icons.assessment),
                  focusedBorder: OutlineInputBorder(),
                ),
                maxLines: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _date,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today_rounded),
                      labelText: "Tanggal"),
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3000));

                    if (pickeddate != null) {
                      setState(() {
                        _date!.text =
                            DateFormat('yyyy.MM.dd').format(pickeddate);
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _time,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.timer), labelText: "waktu"),
                  onTap: () async {
                    TimeOfDay? pickedtime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    if (pickedtime != null) {
                      setState(() {
                        DateTime parsedTime = DateFormat.jm()
                            .parse(pickedtime.format(context).toString());
                        String formattedTime =
                            DateFormat('HH:mm:ss').format(parsedTime);
                        setState(() {
                          _time!.text =
                              formattedTime; //set the value of text field.
                        });
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              TextField(
                controller: _description,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  focusedBorder: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 239, 198, 63)),
                  onPressed: () {
                    upsertTask();
                  },
                  child: Text(widget.task != null ? "EDIT" : "ADD",
                      style: const TextStyle(color: Color(0xFF000000))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> upsertTask() async {
    if (widget.task != null) {
      await db.updateTask(Task.fromMap({
        'id': widget.task!.id,
        'task': _task!.text,
        'date': _date!.text,
        'time': _time!.text,
        'description': _description!.text,
        'isCompleted': 0,
      }));
      Navigator.pop(context, 'update');
    } else {
      await db.saveTask(Task(
        task: _task!.text,
        date: _date!.text,
        time: _time!.text,
        description: _description!.text,
        isCompleted: 0,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
