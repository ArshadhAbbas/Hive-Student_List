import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hive_project/add_students.dart';
import 'package:hive_project/database/db_functions/db_function_provider.dart';
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
    Provider.of<StudentProvider>(context).getallstudents();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Student Record'),
        actions: <Widget>[
          IconButton(
             onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddStudentClass();
              },
            ),
          );
        },
            icon: const CircleAvatar(
                backgroundColor: Colors.white, child: Icon(Icons.add)),
                tooltip: "Add new",
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchWidget(),
              );
            },
            tooltip: "Search",
          ),
        ],
      ),
      body: const ListStudents(),
    );
  }
}
