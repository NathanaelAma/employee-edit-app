import 'package:employee_edit_app/api/api_helper.dart';
import 'package:employee_edit_app/model/employee.dart';
import 'package:employee_edit_app/ui/home.dart';
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
  late Employee editingEmployee;
  late int? employeeListLength;
  late TextEditingController textController;
  late DefaultEmployeeOrManger _employeeOrManger =
      DefaultEmployeeOrManger.employee;

  static const List<String> employeePositionList = <String>[
    'Intern',
    'Junior',
    'Senior',
    'Analyst'
  ];

  String dropDownValue = employeePositionList.first;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    editingEmployee = Employee(
        id: widget.employeeToEdit.id,
        employeeName: widget.employeeToEdit.employeeName,
        employeePosition: widget.employeeToEdit.employeePosition,
        employeeOrManager: widget.employeeToEdit.employeeOrManager);

    textController.text = editingEmployee.employeeName;
    _employeeOrManger = editingEmployee.employeeOrManager == 0
        ? DefaultEmployeeOrManger.employee
        : DefaultEmployeeOrManger.manager;
    dropDownValue = editingEmployee.employeePosition;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Employee',
        ),
      ),
      body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: textController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Employee Name'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an employee name';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                value: dropDownValue,
                items: employeePositionList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    dropDownValue = value!;
                  });
                },
              ),
              Row(
                children: <Widget>[
                  const Icon(Icons.computer),
                  Flexible(
                      child: RadioListTile<DefaultEmployeeOrManger>(
                          title: const Text('Employee'),
                          value: DefaultEmployeeOrManger.employee,
                          groupValue: _employeeOrManger,
                          onChanged: (DefaultEmployeeOrManger? value) {
                            setState(() {
                              _employeeOrManger = value!;
                            });
                          })),
                  const Icon(Icons.engineering),
                  Flexible(
                      child: RadioListTile<DefaultEmployeeOrManger>(
                          title: const Text('Manager'),
                          value: DefaultEmployeeOrManger.manager,
                          groupValue: _employeeOrManger,
                          onChanged: (DefaultEmployeeOrManger? value) {
                            setState(() {
                              _employeeOrManger = value!;
                            });
                          }))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: (() {
                    if (formKey.currentState!.validate()) {
                      Employee newEmployee = Employee(
                          id: widget.employeeToEdit.id,
                          employeeName: textController.text,
                          employeePosition: dropDownValue,
                          employeeOrManager: _employeeOrManger ==
                                  DefaultEmployeeOrManger.manager
                              ? 1
                              : 0);
                      setState(() {
                        _updateEmployee(newEmployee);
                      });
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  }),
                  child: const Text('Edit employee'),
                ),
              )
            ],
          )),
    );
  }

  _updateEmployee(Employee employee) {
    ApiHelper.updateEmployee(employee);
  }
}
