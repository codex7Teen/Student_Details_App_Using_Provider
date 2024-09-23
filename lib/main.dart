import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_details_getx/model/student_model.dart';
import 'package:student_details_getx/provider/student_provider.dart';
import 'package:student_details_getx/provider/theme_provider.dart';
import 'package:student_details_getx/screens/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register the Hive Adapter for your StudentModel
  Hive.registerAdapter(StudentModelAdapter());
  
  // Run the app with multiple providers for theme and student data
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
      ChangeNotifierProvider(create: (ctx) => StudentProvider())
    ],
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      // changes the theme according to themeprovider applythemefunction
      theme: context.watch<ThemeProvider>().applyThemeData(),
      title: 'Student_Details_App using Hive & Provider',
      debugShowCheckedModeBanner: false,
      home: ScreenSplash(),
    );
}
}