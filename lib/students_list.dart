import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_project/db_function.dart';
import 'package:hive_project/display_student_screen.dart';
import 'package:hive_project/edit_student.dart';
class ListStudents extends StatefulWidget {
  const ListStudents({super.key});

  @override
  State<ListStudents> createState() => _ListStudentsState();
}

class _ListStudentsState extends State<ListStudents> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (ctx, studentModel, Widget? child) {
        return ListView.separated(
            itemBuilder: ((context, index) {
              final data = studentModel[index];
              return Padding(
                padding:  EdgeInsets.all(15.0),
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
                                    photo: '');
                              }),
                            ),
                          );
                          // EditStudent();
                        }),
                        icon: Icon(
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
                                padding: EdgeInsets.all(20.0),
                                child: AlertDialog(
                                  title: Text(
                                    'Delete??',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  content: Text(
                                    "Do you want to delete this student",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: (() {
                                        popoutfunction(context);
                                        deleteStudent(index);
                                      }),
                                      child: Text('Yes'),
                                    ),
                                    TextButton(
                                        onPressed: (() {
                                          popoutfunction(context);
                                        }),
                                        child:  Text('No'))
                                  ],
                                ),
                              );
                            }),
                          );
                        }),
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        tooltip: 'Delete',
                      ),
                      // icon-2
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
              return Divider();
            }),
            itemCount: studentModel.length);
      },
    );
  }

  popoutfunction(BuildContext context) {
    return Navigator.of(context).pop();
  }
}




