import 'dart:ffi';

import 'package:employee_edit_app/model/employee.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._init();

  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }


  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase('employee.db');
    return _database!;
  }

  Future<Database> _initDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = 'BOOLEAN NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE tblEmployee (
  employeeID $idType,
  employeeName $textType,
  employeePosition $textType,
  employeeOrManager $boolType
)
''');
  }

  Future<int> createItem(Employee empl) async {
    final db = await _instance.database;

    final id = await db.insert('tblEmployee', empl.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Employee>> getAllEmployees() async {
    final db = await _instance.database;

    final result = await db.query('tblEmployee');

    return result.map((e) => Employee.fromMap(e)).toList();
  }

  Future<Employee> getEmployee(int id) async {
    final db = await _instance.database;
    final result =
        await db.query('tblEmployee', where: 'id = ?', whereArgs: [id]);
    return Employee.fromMap(result.first);
  }

  Future<void> deleteEmployee(int id) async {
    final db = await _instance.database;

    try {
      await db.delete('tblEmployee', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }

  Future close() async {
    final db = await _instance.database;

    return db.close();
  }
}
