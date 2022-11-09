import 'package:employee_edit_app/model/employee.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'employeeDB.db');

    if (kDebugMode) {
      print('initDatabase() called');
    }

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS tblEmployee(id INTEGER PRIMARY KEY, employeeName TEXT NOT NULL, employeePosition TEXT NOT NULL, employeeOrManager INTEGER NOT NULL)');
      },
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE IF NOT EXISTS tblEmployee (
  id $idType,
  employeeName $textType,
  employeePosition $textType,
  employeeOrManager $boolType
)
''');
    if (kDebugMode) {
      print('createDB called()');
    }
  }

  Future<int> createEmployee(Employee empl) async {
    final Database db = await initDatabase();

    final id = await db.insert('tblEmployee', empl.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> createEmployees(List<Employee> employees) async {
    int result = 0;

    final Database db = await initDatabase();
    for (var employee in employees) {
      result = await db.insert('tblEmployee', employee.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    if (kDebugMode) {
      print('createEmployees() called');
    }
    return result;
  }

  Future<List<Employee>> getAllEmployees() async {
    final Database db = await initDatabase();

    final result = await db.query('tblEmployee');

    return result.map((e) => Employee.fromMap(e)).toList();
  }

  Future<Employee> getEmployee(int id) async {
    final Database db = await initDatabase();
    final result =
        await db.query('tblEmployee', where: 'id = ?', whereArgs: [id]);
    return Employee.fromMap(result.first);
  }

  Future<void> deleteEmployee(int id) async {
    final db = await initDatabase();
    try {
      await db.delete('tblEmployee', where: 'id = ?', whereArgs: [id]);
      if (kDebugMode) {
        print('deleteEmployee $id successfully');
      }
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }

  Future<int?> getCount() async {
    int? count = 0;
    //database connection
    final Database db = await initDatabase();
    final x = await db.rawQuery('SELECT COUNT (*) from tblEmployee');
    count = Sqflite.firstIntValue(x);
    return count;
  }

  Future close() async {
    final Database db = await initDatabase();

    return db.close();
  }
}
