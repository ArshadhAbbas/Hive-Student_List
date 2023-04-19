import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_project/provider/photo_provider.dart.dart';
import 'package:hive_project/provider/widget_provider.dart';

import 'package:hive_project/database/db_functions/db_function_provider.dart';
import 'package:provider/provider.dart';

import 'database/db_model/data_model.dart';

class AddStudentClass extends StatefulWidget {
  const AddStudentClass({Key? key}) : super(key: key);
  @override
  State<AddStudentClass> createState() => _AddStudentClassState();
}

class _AddStudentClassState extends State<AddStudentClass> {
  @override
  void initState() {
    context.read<WidgetFunctionProvider>().photo = null;
    super.initState();
  }

  final _nameOfStudent = TextEditingController();
  final _ageOfStudent = TextEditingController();
  final _addressOfStudent = TextEditingController();
  final _phnOfStudent = TextEditingController();
  bool imageAlert = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Consumer<WidgetFunctionProvider>(
              builder: (context, photoProvider, child) => Column(
                children: [
                  photoProvider.photo == null
                      ? Stack(children: [
                          const CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(
                                  "https://cdn.onlinewebfonts.com/svg/img_561160.png")),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                child: IconButton(
                                    onPressed: () async {
                                      await context
                                          .read<WidgetFunctionProvider>()
                                          .getPhoto();
                                    },
                                    icon: const Icon(Icons.add)),
                              ))
                        ])
                      : Stack(children: [
                          CircleAvatar(
                            backgroundImage: FileImage(
                              File(
                                photoProvider.photo!,
                              ),
                            ),
                            radius: 80,
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                child: IconButton(
                                    onPressed: () async {
                                      await context
                                          .read<WidgetFunctionProvider>()
                                          .getPhoto();
                                    },
                                    icon: const Icon(Icons.edit)),
                              ))
                        ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Provider.of<WidgetProvider>(context).textField(
                    fieldcontroller: _nameOfStudent,
                    hintText: "Enter Name",
                    labelText: "Name",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Provider.of<WidgetProvider>(context).textField(
                      fieldcontroller: _ageOfStudent,
                      hintText: "Enter Your Age",
                      labelText: "Age",
                      maxLength: 2,
                      keyboardType: TextInputType.number),
                  const SizedBox(
                    height: 20,
                  ),
                  Provider.of<WidgetProvider>(context).textField(
                      fieldcontroller: _addressOfStudent,
                      hintText: "Enter Your Address",
                      maxLines: 3,
                      labelText: "Address"),
                  const SizedBox(
                    height: 20,
                  ),
                  Provider.of<WidgetProvider>(context).textField(
                    fieldcontroller: _phnOfStudent,
                    hintText: "Phone Number",
                    keyboardType: TextInputType.number,
                    labelText: "Number",
                  ),
                  ElevatedButton.icon(
                      onPressed: (() {
                        if (_formKey.currentState!.validate() &&
                            photoProvider.photo != null) {
                          onStudentAddButtonClick();
                          Navigator.of(context).pop();
                        } else {
                          imageAlert = true;
                        }
                      }),
                      icon: const Icon(Icons.add),
                      label: const Text('Add student'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onStudentAddButtonClick() async {
    final name = _nameOfStudent.text.trim();
    final age = _ageOfStudent.text.trim();
    final address = _addressOfStudent.text.trim();
    final number = _phnOfStudent.text.trim();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
        content: Text("Student added Successfully"),
      ),
    );

    final student = StudentModel(
      name: name,
      age: age,
      phnNumber: number,
      address: address,
      photo: context.read<WidgetFunctionProvider>().photo!,
    );
    context.read<StudentProvider>().addStudent(student);
  }
}
