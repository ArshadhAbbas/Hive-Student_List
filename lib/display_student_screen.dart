import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_project/edit_student.dart';

class DisplayStudent extends StatelessWidget {
  final String name;
  final String age;
  final String address;
  final String number;
  final String photo;
  final int index;
  DisplayStudent({
    super.key,
    required this.name,
    required this.age,
    required this.address,
    required this.number,
    required this.index,
    required this.photo,
    // required String photo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Student Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(20),
            child: Column(
              children: [
                 Center(
                  child: Text(
                    'Student Full Details',
                    style: TextStyle(fontSize: 25, color: Color(0xFF284350)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(
                    File(
                      photo,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Name: $name',
                  style:  TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Age: $age',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Address: $address',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                 SizedBox(
                  height: 10,
                ),
                Text(
                  'Phone Number: $number',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                ElevatedButton.icon(
                    onPressed: (() {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: ((context) {
                        return EditStudent(
                            name: name,
                            age: age,
                            address: address,
                            number: number,
                            index: index,
                            image: photo,
                            photo: '');
                      })));
                    }),
                    icon:  Icon(Icons.edit),
                    label:  Text('Edit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}