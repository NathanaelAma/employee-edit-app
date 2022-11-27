import 'package:employee_edit_app/ui/employee/employee_form.dart';
import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);
  static const String route = '/add';

  @override
  AddEmployeeState createState() => AddEmployeeState();
}

class AddEmployeeState extends State<AddEmployee> {
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
          'Add Employee',
        ),
      ),
      body: const EmployeeForm(),
    );
  }
}
