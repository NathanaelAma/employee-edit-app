import 'package:employee_edit_app/model/employee.dart';
import 'package:employee_edit_app/ui/employee/employee_form.dart';
import 'package:flutter/material.dart';

class EditEmployee extends StatefulWidget {
  final Employee employeeToEdit;
  const EditEmployee({Key? key, required this.employeeToEdit})
      : super(key: key);
  static const String route = '/edit';

  @override
  EditEmployeeState createState() => EditEmployeeState();
}

enum DefaultEmployeeOrManger { employee, manager }

class EditEmployeeState extends State<EditEmployee> {
  

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Employee',
          ),
        ),
        body: EmployeeForm(
          employeeToEdit: widget.employeeToEdit,
        ));
  }

}
