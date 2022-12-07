import 'package:employee_edit_app/api/api_service.dart';
import 'package:employee_edit_app/model/employee.dart';
import 'package:flutter/foundation.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> _employeeList = <Employee>[];

  Employee _employee = Employee(
      id: '', employeeName: '', employeePosition: '', employeeOrManager: 0);

  bool isLoading = false;

  List<Employee> get employeeList => _employeeList;

  Employee get employee => _employee;

  Future<void> fetchEmployees() async {
    isLoading = true;
    notifyListeners();
    final response = await ApiService.getEmployees();
    _employeeList = response;
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateEmployee(Employee employee) async {
    isLoading = true;
    notifyListeners();
    final response = await ApiService.updateEmployee(employee);
    employee = response;
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSingleEmployee(String id) async {
    isLoading = true;
    notifyListeners();
    final response = await ApiService.getEmployee(id);
    _employee = response;
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteEmployee(String id) async {
    isLoading = true;
    notifyListeners();
    final response = await ApiService.deleteEmployee(id);
    _employee = response;
    isLoading = false;
    notifyListeners();
  }

  void initialValues() {
    _employee = Employee(
        id: '', employeeName: '', employeePosition: '', employeeOrManager: 0);
    _employeeList = <Employee>[];
    notifyListeners();
  }
}
