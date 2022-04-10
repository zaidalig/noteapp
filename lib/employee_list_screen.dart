import 'package:flutter/material.dart';
import 'employee.dart';
import 'package:hive/hive.dart';
import 'add_or_edit_employee_screen.dart';

class EmployeesListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EmployeesListState();
  }
}

class EmployeesListState extends State<EmployeesListScreen> {
  List<Employee> listEmployees = [];

  void getEmployees() async {
    final box = await Hive.openBox<Employee>('employee');
    setState(() {
      listEmployees = box.values.toList();
    });
  }

  @override
  void initState() {
    getEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Note Taker"),
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AddOrEditEmployeeScreen(false)));
              },
            )
          ],
        ),
        body: Container(
            padding: const EdgeInsets.only(top:15,left:15),
            child: ListView.builder(
                itemCount: listEmployees.length,
                itemBuilder: (context, position) {
                  Employee getEmployee = listEmployees[position];
                  var salary = getEmployee.empSalary;
                  var age = getEmployee.empAge;
                  var name =getEmployee.empName;
                  return Card(
                    elevation: 8,
                    child: IntrinsicHeight(
                      child: Container(
                        padding: EdgeInsets.only(top:10,left:10),
                        child: Column(
                          children: <Widget>[
                            Align(
                                alignment: Alignment.topLeft,

                                  child: Text("$name ",style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),),
                                ),

                            Align(
                                alignment: Alignment.bottomLeft,

                                  child: Text("$salary\n Date: $age",
                                      style: const TextStyle(fontSize: 20)),
                                ),
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 4),
                                    child: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => AddOrEditEmployeeScreen(
                                                      true, position, getEmployee)));
                                        }),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 4),

                                    child: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: (){
                                          final box = Hive.box<Employee>('employee');
                                          box.deleteAt(position);
                                          setState(() => {
                                            listEmployees.removeAt(position)
                                          });
                                        }),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}