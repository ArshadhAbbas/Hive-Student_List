import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hive_project/database/db_functions/db_function_provider.dart';
import 'package:hive_project/students_list.dart';

class SearchWidget extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final studentListProvider = Provider.of<StudentProvider>(context);
    final searchResults = studentListProvider.studentList
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase().trim()))
        .toList();
    return searchResults.isEmpty
        ? const Center(
            child: Text('No Data Found'),
          )
        : ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (ctx, index) {
              final data = searchResults[index];
              return Column(
                children: [
                  Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return const ListStudents();
                            }),
                          ),
                        );
                      },
                      title: Text(data.name),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.photo)),
                      ),
                    ),
                  ),
                  const Divider()
                ],
              );
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final studentListProvider = Provider.of<StudentProvider>(context);
    final searchResults = studentListProvider.studentList
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase().trim()))
        .toList();
    return searchResults.isEmpty
        ? ListView(
          children: const [
            Card(
              child: ListTile(
                leading: CircleAvatar(backgroundColor: Colors.transparent,),
                title: Text("No Matching result"),
              ),
            )
          ],
        )
        : ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (ctx, index) {
              final data = searchResults[index];
              return Column(
                children: [
                  Card(
                    child: ListTile(
                      title: Text(data.name),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.photo)),
                      ),
                    ),
                  ),
                  const Divider()
                ],
              );
            },
          );
  }
}
