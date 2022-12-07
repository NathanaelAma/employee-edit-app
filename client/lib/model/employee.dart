// To parse this JSON data, do
//
//     final employees = employeesFromMap(jsonString);

import 'dart:convert';

List<Employee> employeesFromMap(String str) => List<Employee>.from(json.decode(str).map((x) => Employee.fromMap(x)));

String employeesToMap(List<Employee> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Employee {
    Employee({
        required this.id,
        required this.employeeName,
        required this.employeePosition,
        required this.employeeOrManager,
    });

    String id;
    String employeeName;
    String employeePosition;
    int employeeOrManager;

    factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        id: json["id"],
        employeeName: json["employee_name"],
        employeeOrManager: json["employee_or_manager"],
        employeePosition: json["employee_position"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "employee_name": employeeName,
        "employee_or_manager": employeeOrManager,
        "employee_position": employeePosition,
    };

  //getters
  String get getId => id;
  String get getEmployeeName => employeeName;
  String get getEmployeePosition => employeePosition;
  int get getEmployeeOrManager => employeeOrManager;

  //setters
  void setId(String id) {
    this.id = id;
  }

  void setEmployeeName(String employeeName) {
    this.employeeName = employeeName;
  }

  void setEmployeePosition(String employeePosition) {
    this.employeePosition = employeePosition;
  }

  void setEmployeeOrManager(int employeeOrManager) {
    this.employeeOrManager = employeeOrManager;
  }
}
