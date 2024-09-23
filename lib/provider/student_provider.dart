import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_details_getx/model/student_model.dart';

class StudentProvider extends ChangeNotifier {

  // List to store students
  List<StudentModel> studentList = [];

  //! Add Student
  Future<void> addStudentDetails(StudentModel value) async {
  final studentDb = await Hive.openBox<StudentModel>(StudentModel.boxName);

  await studentDb.add(value);

  studentList.add(value);

  notifyListeners();

  log('add success');
}

//! Get Student
  Future<void> getStudentDetails() async {
  final studentDb = await Hive.openBox<StudentModel>(StudentModel.boxName);

  studentList = studentDb.values.toList();

  notifyListeners();

  log('get success');
}

//! Delete Student
  Future<void> deleteStudent(int id) async {
  final studentDb = await Hive.openBox<StudentModel>(StudentModel.boxName);

  await studentDb.delete(id);
  await getStudentDetails();
  notifyListeners();

  log('delete success');
}

//! Update Student
  Future<void> updateStudent(int id, StudentModel newValue) async {
  final studentDb = await Hive.openBox<StudentModel>(StudentModel.boxName);

  await studentDb.put(id, newValue);

  await getStudentDetails();
  
  notifyListeners();

  log('update success');
}
  
}
