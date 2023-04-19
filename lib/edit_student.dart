import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_project/database/db_functions/db_function_provider.dart';
import 'package:hive_project/home_screen.dart';
import 'package:hive_project/provider/photo_provider.dart.dart';
import 'package:hive_project/provider/widget_provider.dart';
import 'package:provider/provider.dart';

import 'database/db_model/data_model.dart';

class EditStudent extends StatefulWidget {
  final String name;
  final String age;
  final String address;
  final String number;
  final String image;
  final int index;

  const EditStudent({
    super.key,
    required this.name,
    required this.age,
    required this.address,
    required this.number,
    required this.index,
    required this.image,
  });

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController _nameOfStudent = TextEditingController();
  TextEditingController _ageOfStudent = TextEditingController();
  TextEditingController _addressOfStudent = TextEditingController();
  TextEditingController _phnOfStudent = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _nameOfStudent = TextEditingController(text: widget.name);
    _ageOfStudent = TextEditingController(text: widget.age);
    _addressOfStudent = TextEditingController(text: widget.address);
    _phnOfStudent = TextEditingController(text: widget.number);
    context.read<WidgetFunctionProvider>().photo = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    const Text(
                      'Edit student details',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<WidgetFunctionProvider>(
                      builder: (context, photoProvider, child)=> Stack(children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage:  photoProvider.photo == null
                              ? FileImage(
                                  File(widget.image),
                                )
                              : FileImage(
                                  File(
                                    photoProvider.photo!,
                                  ),
                                ),
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Provider.of<WidgetProvider>(context).textField(
                      fieldcontroller: _nameOfStudent,
                      hintText: "Name",
                      labelText: "Name",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Provider.of<WidgetProvider>(context).textField(
                        fieldcontroller: _ageOfStudent,
                        hintText: "Enter Your Age",
                        labelText: "Age",
                        keyboardType: TextInputType.number,
                        maxLength: 2),
                    const SizedBox(
                      height: 20,
                    ),
                    Provider.of<WidgetProvider>(context).textField(
                        fieldcontroller: _addressOfStudent,
                        hintText: "Enetr Your Address",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              onEditSaveButton(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ));
                            }
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Save'),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Future<void> onEditSaveButton(ctx) async {
    var photoPath = context.read<WidgetFunctionProvider>().photo ?? widget.image;
    final studentmodel = StudentModel(
      name: _nameOfStudent.text,
      age: _ageOfStudent.text,
      phnNumber: _phnOfStudent.text,
      address: _addressOfStudent.text,
      photo: photoPath,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(30),
        backgroundColor: Colors.blueGrey,
        content: Text(
          'Saved',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
    Provider.of<StudentProvider>(context, listen: false)
        .editList(widget.index, studentmodel);
  }


}
