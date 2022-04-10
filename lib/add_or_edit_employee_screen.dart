import 'package:flutter/material.dart';
import 'employee.dart';
import 'employee_list_screen.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';


class AddOrEditEmployeeScreen extends StatefulWidget {

     Employee? employeeModel;

  AddOrEditEmployeeScreen(isEdit,   [position ,employeeModel,]   );

  @override
  State<StatefulWidget> createState() {
    return AddEditEmployeeState();
  }
}

class AddEditEmployeeState extends State<AddOrEditEmployeeScreen> {
  TextEditingController controllerName =  TextEditingController();
  TextEditingController controllerSalary =  TextEditingController();
  TextEditingController controllerAge =  TextEditingController();

  @override
  Widget build(BuildContext context) {



    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(25),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text("Note title:", style:  TextStyle(fontSize: 18)),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                                controller: controllerName,
                              minLines: 1,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              focusColor: Colors.red,
                                fillColor: Colors.red,
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                       const Text("Note Description: ", style: TextStyle(fontSize: 18)),
                      const   SizedBox(width: 20),
                        Expanded(
                          child: TextField(

                              controller: controllerSalary,
                            minLines: 2,
                            maxLines: null,

                              decoration: InputDecoration(

                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusColor: Colors.red,
                                fillColor: Colors.red,
                              )
                              ),
                        )
                      ],
                    ),

                    const SizedBox(height: 100),
                    RaisedButton(
                      color: Colors.grey,
                      child: const Text("Submit",
                          style: const TextStyle(color: Colors.green, fontSize: 18)),
                      onPressed: () async {
                        var getEmpName = controllerName.text;
                        var now =  DateTime.now();
                        var formatter = DateFormat('yyyy-MM-dd');
                        String formattedDate = formatter.format(now);
                        var getEmpSalary = controllerSalary.text;
                        if (getEmpName.isNotEmpty &&
                        getEmpSalary.isNotEmpty
                        ) {

                            Employee addEmployee =  Employee(
                                empName: getEmpName,
                                empSalary: getEmpSalary,
                                empAge: formattedDate);
                            var box = await Hive.openBox<Employee>('employee');
                            box.add(addEmployee);

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => EmployeesListScreen()),
                                  (r) => false);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}