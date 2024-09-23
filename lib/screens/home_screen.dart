// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details_getx/provider/student_provider.dart';
import 'package:student_details_getx/provider/theme_provider.dart';
import 'package:student_details_getx/screens/add_student.dart';
import 'package:student_details_getx/screens/search_screen.dart';
import 'package:student_details_getx/screens/view_student.dart';
import 'package:student_details_getx/widgets/student_list_widget.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
    context.read<StudentProvider>().getStudentDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.yellow,
            child: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScreenAddStudent(
                        addOrUpdate: 'Add Student',
                        heading: 'Add Student Details',
                      )));
            }),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          leading: InkWell(
              onTap: () {
                // calls toggle-theme function
                context.read<ThemeProvider>().toggleTheme();
              },
              // watches for the buttonclick and changes icon
              child: context.watch<ThemeProvider>().isDarkTheme
                  ? Icon(
                      Icons.light_mode_rounded,
                      color: Colors.black,
                    )
                  : Icon(Icons.dark_mode, color: Colors.black)),
          backgroundColor: Colors.yellow[300],
          title: Text(
            'Student Details',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ScreenSearch())),
                  child: Icon(Icons.search, color: Colors.black)),
            )
          ],
        ),
        //! body
        body: Consumer<StudentProvider>(
          builder: (context, studentDb, child) {
            return studentDb.studentList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                        itemCount: studentDb.studentList.length,
                        itemBuilder: (context, index) {
                          //data
                          final data = studentDb.studentList[index];
                          return InkWell(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScreenViewStudent(
                                              imagePath: data.image,
                                              name: data.name,
                                              age: data.age,
                                              classs: data.classs,
                                              gender: data.gender))),
                              child: StudentListWidget(
                                name: data.name,
                                gender: data.gender,
                                id: data.key,
                                imagePath: data.image,
                                age: data.age,
                                classs: data.classs,
                              ));
                        }))
                : Center(
                    child: Text("NO STUDENT DATA"),
                  );
          },
        ));
  }
}
