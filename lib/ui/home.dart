import 'package:employee_edit_app/database/database_helper.dart';
import 'package:employee_edit_app/model/employee.dart';
import 'package:flutter/material.dart';

Future<int> addEmployeesToDatabase() async {
  var dbHelper = DatabaseHelper();
  Employee dummy1 = const Employee(
      id: 0, name: 'test1', position: 'test', employeeOrManager: true);
  Employee dummy2 = const Employee(
      id: 1, name: 'test2', position: 'test', employeeOrManager: true);
  Employee dummy3 = const Employee(
      id: 2, name: 'test3', position: 'test', employeeOrManager: true);

  List<Employee> employees = [dummy1, dummy2, dummy3];

  return await dbHelper.createEmployees(employees);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
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
          child: FutureBuilder(
              future: _databaseHelper.getAllEmployees(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Employee>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, index) {
                        return Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            title: Text(snapshot.data![index].name),
                            subtitle: Text(snapshot.data![index].position),
                          ),
                        );
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
      floatingActionButton: const FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}
