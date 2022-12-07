import 'package:employee_edit_app/provider/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'ui/employee/add_employee.dart';
import 'ui/home.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color.fromRGBO(94, 114, 228, 1.0),
    statusBarColor: Color.fromRGBO(94, 114, 228, 1.0),
  ));
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empoyee Database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  ChangeNotifierProvider(
        create: (context) => EmployeeProvider(),
        builder:(context, child) {
        return const Home();
      },),
      initialRoute: '/',
      routes: {
        AddEmployee.route: (context) => const AddEmployee(),
      },
    );
  }
}
