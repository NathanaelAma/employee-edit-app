import 'package:employee_edit_app/database/database_helper.dart';
import 'package:flutter/material.dart';

class EditEmployee extends StatefulWidget {
  const EditEmployee({Key? key}) : super(key: key);

  @override
  EditEmployeeState createState() => EditEmployeeState();
}

class EditEmployeeState extends State<EditEmployee> {
  late DatabaseHelper _databaseHelper;

  @override
  void dispose() {
    _databaseHelper.close();
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
      body: Container(),
    );
  }
}
