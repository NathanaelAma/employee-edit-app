import 'package:employee_edit_app/api/api_service.dart';
import 'package:employee_edit_app/globals.dart';
import 'package:employee_edit_app/model/employee.dart';
import 'package:employee_edit_app/ui/employee/add_employee.dart';
import 'package:employee_edit_app/ui/employee/edit_employee.dart';
import 'package:employee_edit_app/ui/employee/employee_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../provider/employee_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Uuid uuid = const Uuid();
  bool isFabVisible = true;

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
    //print();
    context.read<EmployeeProvider>().fetchEmployees();
    print("context.read<EmployeeProvider>().fetchEmployees();");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        actions: [
          IconButton(
            icon: const Icon(Globals.refreshIcon),
            onPressed: () {
              context.read<EmployeeProvider>().fetchEmployees();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return context.read<EmployeeProvider>().fetchEmployees();
        },
        child: Center(
          child: Consumer<EmployeeProvider>(
          builder: (context, employeeProvider, child) {
            return employeeProvider.employeeList.isEmpty &&
                    !employeeProvider.isLoading
                ? const CircularProgressIndicator()
                : employeeProvider.isLoading
                    ? const Text("No employees found")
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return EmployeeCard(
                              employee: employeeProvider.employeeList[index]);
                        },
                      );
          },
        )),
      ),
      floatingActionButton: isFabVisible
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddEmployee.route);
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  // Future<Future<List<Employee>>> _pullRefresh()  {

  //   _showToast("Data has been updated");

  // }

  //shows a custom toast prompt
  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }
}
