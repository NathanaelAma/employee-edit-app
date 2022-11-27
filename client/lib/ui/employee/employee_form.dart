import 'package:employee_edit_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../api/api_helper.dart';
import '../../model/employee.dart';
import '../home.dart';

enum DefaultEmployeeOrManger { employee, manager }

class EmployeeForm extends StatefulWidget {
  final Employee? employeeToEdit;
  const EmployeeForm({Key? key, this.employeeToEdit}) : super(key: key);

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  bool editing = false;
  late Uuid uuid = const Uuid();
  late Employee editingEmployee;
  late int? employeeListLength;
  late TextEditingController textEditingController;
  late DefaultEmployeeOrManger employeeOrManger =
      DefaultEmployeeOrManger.employee;

  static const List<String> employeePositionList = Globals.employeePositionList;
  String dropDownValue = employeePositionList.first;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    widget.employeeToEdit?.id.isNotEmpty == true
        ? editing = true
        : editing = false;

    if (editing) {
      editingEmployee = Employee(
          id: widget.employeeToEdit!.id,
          employeeName: widget.employeeToEdit!.employeeName,
          employeePosition: widget.employeeToEdit!.employeePosition,
          employeeOrManager: widget.employeeToEdit!.employeeOrManager);

      textEditingController.text = editingEmployee.employeeName;
      employeeOrManger = editingEmployee.employeeOrManager == 0
          ? DefaultEmployeeOrManger.employee
          : DefaultEmployeeOrManger.manager;
      dropDownValue = editingEmployee.employeePosition;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: textEditingController,
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
              dropDownValue = value!;
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.computer),
              Flexible(
                  child: RadioListTile<DefaultEmployeeOrManger>(
                      title: const Text('Employee'),
                      value: DefaultEmployeeOrManger.employee,
                      groupValue: employeeOrManger,
                      onChanged: (DefaultEmployeeOrManger? value) {
                        employeeOrManger = value!;
                      })),
              const Icon(Icons.engineering),
              Flexible(
                  child: RadioListTile<DefaultEmployeeOrManger>(
                      title: const Text('Manager'),
                      value: DefaultEmployeeOrManger.manager,
                      groupValue: employeeOrManger,
                      onChanged: (DefaultEmployeeOrManger? value) {
                        employeeOrManger = value!;
                      }))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: (() {
                if (formKey.currentState!.validate()) {
                  if (editing) {
                    Employee newEmployee = Employee(
                        id: widget.employeeToEdit!.id,
                        employeeName: textEditingController.text,
                        employeePosition: dropDownValue,
                        employeeOrManager:
                            employeeOrManger == DefaultEmployeeOrManger.manager
                                ? 1
                                : 0);

                    _updateEmployee(newEmployee);
                  } else {
                    Employee newEmployee = Employee(
                        id: uuid.v4(),
                        employeeName: textEditingController.text,
                        employeePosition: dropDownValue,
                        employeeOrManager:
                            employeeOrManger == DefaultEmployeeOrManger.manager
                                ? 1
                                : 0);
                    _addEmployee(newEmployee);
                  }
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                    (Route<dynamic> route) => false,
                  );
                }
              }),
              child: editing? const Text('Add Employee') : const Text('Edit Employee'),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}

_updateEmployee(Employee employee) {
  ApiHelper.updateEmployee(employee);
}

_addEmployee(Employee employee) {
  ApiHelper.createEmployee(employee);
}
