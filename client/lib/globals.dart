import 'package:flutter/material.dart';

class Globals {
  static const String baseUrl = '192.168.3.9';
  static const String port = '8080';
  static const String apiEndpoint = '/api/employees';

  static const List<String> employeePositionList = <String>[
    'Intern',
    'Junior',
    'Senior',
    'Analyst'
  ];

  static const List<String> employeeOrManagerList = <String>[
    'Employee',
    'Manager'
  ];

  static const employeeIcon = Icons.computer;
  static const managerIcon = Icons.engineering_rounded;
  static const editIcon = Icons.edit;
  static const deleteIcon = Icons.delete;
  static const refreshIcon = Icons.refresh;
}
