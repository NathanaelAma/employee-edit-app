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

    final String id;
    final String employeeName;
    final String employeePosition;
    final int employeeOrManager;

    factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        id: json["id"],
        employeeName: json["employeeName"],
        employeePosition: json["employeePosition"],
        employeeOrManager: json["employeeOrManager"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "employeeName": employeeName,
        "employeePosition": employeePosition,
        "employeeOrManager": employeeOrManager,
    };
}
