import 'dart:io';
import 'package:flutter/material.dart';
import 'package:studentdataapplication/model/student_model.dart';

class StudentImageContainerWidget extends StatelessWidget {
  final StudentModel student;
  final double height;
  final double width;

  const StudentImageContainerWidget({
    Key? key,
    required this.student,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Student image URL: ${student.imageUrl}');
    final file = File(student.imageUrl ?? '');
    print('File exists: ${file.existsSync()}');

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 130, 128, 128).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.file(
          file,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
