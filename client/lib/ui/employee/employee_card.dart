import 'package:employee_edit_app/model/employee.dart';
import 'package:flutter/material.dart';
import '../../api/api_service.dart';
import '../../globals.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({Key? key, required this.employee}) : super(key: key);
  final Employee employee;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: ListTile(
          leading: employee.employeeOrManager == 0
              ? const Icon(Globals.employeeIcon)
              : const Icon(Globals.managerIcon),
          title: Text(employee.employeeName),
          subtitle: Text(employee.employeePosition),
          trailing: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Globals.editIcon),
                onPressed: () {
                  Navigator.pushNamed(context, '/employeeForm',
                      arguments: employee);
                },
              ),
              IconButton(
                icon: const Icon(Globals.deleteIcon),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Employee'),
                          content: const Text(
                              'Are you sure you want to delete this employee?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Delete'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                ApiService.deleteEmployee(employee.id);
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
