import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hive_project/database/db_functions/db_function_provider.dart';
import 'package:hive_project/display_student_screen.dart';
import 'package:hive_project/edit_student.dart';

class ListStudents extends StatelessWidget {
  const ListStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (ctx, studentModel, Widget? child) {
        return studentModel.studentList.isEmpty
            ? const Center(
                child: Text("No students details. Please Add New"),
              )
            : ListView.separated(
                itemBuilder: ((context, index) {
                  final data = studentModel.studentList[index];
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(
                          File(data.photo),
                        ),
                      ),
                      title: Text(data.name),
                      trailing: Wrap(
                        spacing: 12,
                        children: <Widget>[
                          IconButton(
                            onPressed: (() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) {
                                    return EditStudent(
                                      name: data.name,
                                      age: data.age,
                                      address: data.address,
                                      number: data.phnNumber,
                                      index: index,
                                      image: data.photo,
                                    );
                                  }),
                                ),
                              );
                            }),
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.brown,
                            ),
                            tooltip: 'Edit',
                          ),
                          IconButton(
                            onPressed: (() {
                              showDialog(
                                context: context,
                                builder: ((context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: AlertDialog(
                                      title: const Text(
                                        'Delete??',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      content: const Text(
                                        "Do you want to delete this student",
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: (() {
                                              Navigator.of(context).pop();
                                            }),
                                            child: const Text('No')),
                                        TextButton(
                                          onPressed: (() {
                                            Navigator.of(context).pop();
                                            Provider.of<StudentProvider>(
                                                    context,
                                                    listen: false)
                                                .deleteStudent(index);
                                          }),
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              );
                            }),
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            tooltip: 'Delete',
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return DisplayStudent(
                                name: data.name,
                                age: data.age,
                                address: data.address,
                                number: data.phnNumber,
                                index: index,
                                photo: data.photo,
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  );
                }),
                separatorBuilder: ((context, index) {
                  return const Divider();
                }),
                itemCount: studentModel.studentList.length);
      },
    );
  }
}
