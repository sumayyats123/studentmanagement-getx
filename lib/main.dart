import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentdataapplication/view/screens/screen_aadd_student.dart';
import 'package:studentdataapplication/view/screens/screen_student_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home:AddStudentScreen(),
      debugShowCheckedModeBanner: false,
      
     
    );
  }
}
