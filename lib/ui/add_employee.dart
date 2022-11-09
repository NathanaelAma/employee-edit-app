import 'package:employee_edit_app/database/database_helper.dart';
import 'package:employee_edit_app/model/employee.dart';
import 'package:employee_edit_app/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);
  static const String route = '/add';

  @override
  AddEmployeeState createState() => AddEmployeeState();
}

enum DefaultEmployeeOrManger { employee, manager }

class AddEmployeeState extends State<AddEmployee> {
  late DatabaseHelper _databaseHelper;
  late Uuid uuid = const Uuid();
  late TextEditingController textController;
  late DefaultEmployeeOrManger _employeeOrManger =
      DefaultEmployeeOrManger.employee;

  static const List<String> radioEmployeePositionList = <String>[
    'Intern',
    'Junior',
    'Senior',
    'Analyst'
  ];

  String dropDownValue = radioEmployeePositionList.first;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    textController = TextEditingController();

    _databaseHelper.initDatabase().whenComplete(() async {});
  }

  @override
  void dispose() {
    textController.dispose();
    _databaseHelper.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Employee',
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
                },
              ),
              DropdownButtonFormField(
                value: dropDownValue,
                items: radioEmployeePositionList
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
                          id: uuid.v4(),
                          employeeName: textController.text,
                          employeePosition: dropDownValue,
                          employeeOrManager: _employeeOrManger ==
                                  DefaultEmployeeOrManger.manager
                              ? 1
                              : 0);
                      _addEmployee(newEmployee);
                      setState(() {
                        _databaseHelper.initDatabase();
                      });
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const Home()), // this mymainpage is your page to refresh
                        (Route<dynamic> route) => false,
                      );
                    }
                  }),
                  child: const Text('Add employee'),
                ),
              )
            ],
          )),
    );
  }

  _addEmployee(Employee employee) {
    _databaseHelper.createEmployee(employee);
  }
}
