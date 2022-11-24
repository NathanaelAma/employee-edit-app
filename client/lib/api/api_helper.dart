import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../model/employee.dart';
import 'api_constants.dart';

class ApiHelper {
  static Future<List<Employee>> getEmployees() async {
    try {
      var url = Uri.parse(
          "http://${ApiConstants.baseUrl}:${ApiConstants.port}${ApiConstants.apiEndpoint}");
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List<Employee> employeeList = employeesFromMap(response.body);
        return employeeList;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
    throw Exception('Failed to connect to url');
  }

  static Future<Employee> getEmployee(String id) async {
    try {
      var url = Uri.parse(
          "http://${ApiConstants.baseUrl}:${ApiConstants.port}${ApiConstants.apiEndpoint}/$id");
      http.Response response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        List<Employee> employee = employeesFromMap(response.body);
        return employee.first;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
    throw Exception('Failed to to get url');
  }

  static Future createEmployee(Employee employee) async {
    try {
      var url = Uri.parse(
          "http://${ApiConstants.baseUrl}:${ApiConstants.port}${ApiConstants.apiEndpoint}");
      http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(employee.toMap()));
      if (response.statusCode == 200) {
        return response.body;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
    throw Exception('Failed to to get url');
  }

  static Future updateEmployee(Employee employee) async {
    try {
      var url = Uri.parse(
          "http://${ApiConstants.baseUrl}:${ApiConstants.port}${ApiConstants.apiEndpoint}/${employee.id}");
      http.Response response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(employee.toMap()));
      if (response.statusCode == 200) {
        return response.body;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
    throw Exception('Failed to to get url');
  }

  static Future deleteEmployee(String id) async {
    try {
      var url = Uri.parse(
          "http://${ApiConstants.baseUrl}:${ApiConstants.port}${ApiConstants.apiEndpoint}/$id");
      http.Response response = await http.delete(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
    throw Exception('Failed to to get url');
  }
}
