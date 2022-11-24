import 'package:employee_edit_app/api/api_helper.dart';
import 'package:employee_edit_app/model/employee.dart';
import 'package:employee_edit_app/ui/add_employee.dart';
import 'package:employee_edit_app/ui/edit_employee.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<Employee>> employeeList;
  late Uuid uuid = const Uuid();

  @override
  void initState() {
    
    super.initState();
    employeeList = ApiHelper.getEmployees();
  }

  @override
  void dispose() {
    super.dispose();
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
              future: employeeList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Employee>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, index) {
                        return Card(
                          child: ListTile(
                            leading:
                                snapshot.data![index].employeeOrManager == 0
                                    ? const Icon(Icons.computer)
                                    : const Icon(Icons.engineering_rounded),
                            contentPadding: const EdgeInsets.all(8.0),
                            title: Text(snapshot.data![index].employeeName),
                            subtitle:
                                Text(snapshot.data![index].employeePosition),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditEmployee(
                                                employeeToEdit:
                                                    snapshot.data![index])));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        ApiHelper.deleteEmployee(
                                            snapshot.data![index].id);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 20,
                                    ))
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddEmployee.route);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  //Widget _listView(AsyncSnapshot snapshot) {}

  Future<void> _pullRefresh() async {
    List<Employee> newEmployees = await ApiHelper.getEmployees();
  }
}