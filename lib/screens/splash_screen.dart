// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details_getx/provider/student_provider.dart';
import 'package:student_details_getx/screens/home_screen.dart';

class ScreenSplash extends StatefulWidget {
   ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {

  @override
  void initState() {
    super.initState();
    context.read<StudentProvider>().getStudentDetails();
    Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ScreenHome()))); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/logo.png", width: 180),
      ),
    );
  }
}