import 'package:employee_edit_app/database/database_helper.dart';
import 'package:employee_edit_app/model/employee.dart';
import 'package:employee_edit_app/ui/edit_employee.dart';
import 'package:flutter/material.dart';

Future<List<Employee>> fetchEmployeesFromDatabase() async {
  var dbHelper = DatabaseHelper();
  Future<List<Employee>> employees = dbHelper.getAllEmployees();
  return employees;
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.initDatabase('employee.db').whenComplete(() async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Employee>>(
              future: fetchEmployeesFromDatabase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            snapshot.data![index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          Text(
                            snapshot.data![index].position,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          const Divider()
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('There was a problem! ${snapshot.error}');
                }
                return Container(
                    alignment: AlignmentDirectional.center,
                    child: const CircularProgressIndicator());
              })),
      floatingActionButton:
          const FloatingActionButton(onPressed: null, child: Icon(Icons.add)),
    );
  }
}
