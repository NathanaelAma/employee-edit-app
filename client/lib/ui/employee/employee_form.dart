import 'package:employee_edit_app/globals.dart';
import 'package:employee_edit_app/provider/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../api/api_service.dart';
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
  bool editMode = false;
  late Uuid uuid = const Uuid();
  late Employee editingEmployee;
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
        ? editMode = true
        : editMode = false;

    if (editMode) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Consumer<EmployeeProvider>(
      builder: (context, employeeProvider, child) {
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Employee Name',
                      hintText: "Enter Employee Name"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an employee name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  icon: const Icon(Icons.arrow_downward),
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Globals.employeeIcon),
                    Expanded(
                        child: RadioListTile<DefaultEmployeeOrManger>(
                            title: const Text('Employee'),
                            value: DefaultEmployeeOrManger.employee,
                            groupValue: employeeOrManger,
                            onChanged: (value) {
                              setState(() {
                                employeeOrManger = value!;
                              });
                            })),
                    const Icon(Globals.managerIcon),
                    Expanded(
                        child: RadioListTile<DefaultEmployeeOrManger>(
                            title: const Text('Manager'),
                            value: DefaultEmployeeOrManger.manager,
                            groupValue: employeeOrManger,
                            onChanged: (value) {
                              setState(() {
                                employeeOrManger = value!;
                              });
                            }))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: (() {
                      if (formKey.currentState!.validate()) {
                        if (editMode) {
                          Employee newEmployee = Employee(
                              id: widget.employeeToEdit!.id,
                              employeeName: textEditingController.text,
                              employeePosition: dropDownValue,
                              employeeOrManager: employeeOrManger ==
                                      DefaultEmployeeOrManger.manager
                                  ? 1
                                  : 0);

                          _updateEmployee(newEmployee);
                        } else {
                          Employee newEmployee = Employee(
                              id: uuid.v4(),
                              employeeName: textEditingController.text,
                              employeePosition: dropDownValue,
                              employeeOrManager: employeeOrManger ==
                                      DefaultEmployeeOrManger.manager
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
                    child: editMode
                        ? const Text('Edit Employee')
                        : const Text('Add Employee'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}

_updateEmployee(Employee employee) {
  ApiService.updateEmployee(employee);
}

_addEmployee(Employee employee) {
  ApiService.createEmployee(employee);
}
