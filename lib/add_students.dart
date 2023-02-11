import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_project/data_model.dart';
import 'package:hive_project/db_function.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentClass extends StatefulWidget {
  const AddStudentClass({Key? key}) : super(key: key);

  @override
  State<AddStudentClass> createState() => _AddStudentClassState();
}

class _AddStudentClassState extends State<AddStudentClass> {
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
        title: Text('Add Student details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _photo?.path == null
                    ? CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                            "https://icon-library.com/images/person-head-icon/person-head-icon-27.jpg"))
                    : CircleAvatar(
                        backgroundImage: FileImage(
                          File(
                            _photo!.path,
                          ),
                        ),
                        radius: 60,
                      ),
                ElevatedButton.icon(
                  onPressed: () {
                    getPhoto();
                  },
                  icon: Icon(
                    Icons.image_outlined,
                  ),
                  label: Text(
                    'Add An Image',
                  ),
                ),
                TextFormField(
                  controller: _nameOfStudent,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter student Name',
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Name is Required';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _ageOfStudent,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter age',
                    labelText: 'age',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Age is Required';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _addressOfStudent,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter address',
                    labelText: 'address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Address is Required';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _phnOfStudent,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the number',
                    labelText: 'number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    } else {
                      return null;
                    }
                  },
                ),
                ElevatedButton.icon(
                    onPressed: (() {
                      if (_formKey.currentState!.validate() && _photo != null) {
                        onStudentAddButtonClick();
                        Navigator.of(context).pop();
                      } else {
                        imageAlert = true;
                      }
                    }),
                    icon: Icon(Icons.add),
                    label: Text('Add student'))
              ],
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
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          content: Text("Student added Successfully"),
        ),
      );
    // }
    final student = StudentModel(
      name: name,
      age: age,
      phnNumber: number,
      address: address,
      photo: _photo!.path,
    );
    addStudent(student);
  }

  File? _photo;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      setState(
        () {
          _photo = File(photo.path);
        },
      );
    }
  }
}
