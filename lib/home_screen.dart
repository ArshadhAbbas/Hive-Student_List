import 'package:flutter/material.dart';
import 'package:hive_project/add_students.dart';
import 'package:hive_project/db_function.dart';
import 'package:hive_project/search_screen.dart';
import 'package:hive_project/students_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    getallstudents();
    return Scaffold(
      appBar: AppBar(
        title: Text('Students List'),
        actions: <Widget>[
          IconButton(
            icon:  Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddStudentClass();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: ListStudents(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: SearchWidget(),
          );
        },
        child:Icon(Icons.search),
      ),
    );
  }
}
