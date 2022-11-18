import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/task.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  final String databaseName = 'task.db';
  final String tableName = 'tasks';
  final String columnId = 'id';
  final String columnTask = 'task';
  final String columnDate = 'date';
  final String columnTime = 'time';
  final String columnIsCompleted = 'isCompleted';
  final String columnDescription = 'description';

  DbHelper._internal();
  factory DbHelper() => _instance;

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
      "$columnTask TEXT,"
      "$columnDate TEXT,"
      "$columnTime TEXT,"
      "$columnIsCompleted INTEGER,"
      "$columnDescription TEXT)";
    await db.execute(sql);
  }

  Future<int?> saveTask(Task task) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, task.toMap());
  }

  Future<List?> getAllTask() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnTask,
      columnDate,
      columnTime,
      columnDescription,
      columnIsCompleted,
    ]);

    return result.toList();
  }

  Future<int?> deleteTask(int id) async {
    var dbClient = await _db;
    return await dbClient!
      .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int?> updateTask(Task task) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, task.toMap(),
        where: '$columnId = ?', whereArgs: [task.id]);
  }

  Future<int?> markTaskCompleted(Task task) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, task.toMap(),
        where: '$columnId = ?', whereArgs: [task.id]);
  }
}