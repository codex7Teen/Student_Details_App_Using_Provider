// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details_getx/provider/student_provider.dart';
import 'package:student_details_getx/screens/view_student.dart';
import 'package:student_details_getx/widgets/student_list_widget.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {

    // creating a variable for studentprovide
  final studentProvider = context.watch<StudentProvider>();

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
          color: Colors.black,
        ),
          backgroundColor: Colors.yellow[300],
          title: Text(
            'Serach Students',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(Icons.search),
            )
          ],
        ),
        //! body
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: CupertinoSearchTextField(
                backgroundColor: Colors.white,
                padding: EdgeInsets.all(10),
                onChanged: (query) {
                  studentProvider.filterStudents(query);
                },
              ),
            ),

            Expanded(
              child: studentProvider.hasSearched ? studentProvider.filteredStudentList.isNotEmpty ? ListView.builder(
                          itemCount: studentProvider.filteredStudentList.length,
                          itemBuilder: (context, index) {
                            //data
                            final data = studentProvider.filteredStudentList[index];
                            return InkWell(
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScreenViewStudent(
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
                                  classs: data.classs,
                                  age: data.age,
                                ));
                          }) : Center(child: Text("NO MATCHING STUDENT FOUND!!!"),) : Center(child: Text("SEARCH FOR STUDENTS..."),)
            )
          ],
        ));
  }
}
