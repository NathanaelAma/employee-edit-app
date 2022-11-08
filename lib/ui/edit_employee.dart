import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditEmployee extends StatefulWidget {
  const EditEmployee({Key? key}) : super(key: key);

  @override
  EditEmployeeState createState() => EditEmployeeState();
}

class EditEmployeeState extends State<EditEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Employee',
        ),
      ),
      body: Container(),
    );
  }
}
