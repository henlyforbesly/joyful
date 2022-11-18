class Task {
  int? id;
  String? task;
  String? date;
  String? time;
  int? isCompleted;
  String? description;

  Task({this.id, this.task, this.date, this.time, this.isCompleted, this.description});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }
    map['task'] = task;
    map['date'] = date;
    map['time'] = time;
    map['isCompleted'] = isCompleted;
    map['description'] = description;
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    task = map['task'];
    date = map['date'];
    time = map['time'];
    isCompleted = map['isCompleted'];
    description = map['description'];
  }
}

