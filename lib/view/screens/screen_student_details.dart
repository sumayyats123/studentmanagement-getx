import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentdataapplication/controller/getController/student_controller.dart';
import 'package:studentdataapplication/controller/services/snackfunction.dart';
import 'package:studentdataapplication/model/student_model.dart';
import 'package:studentdataapplication/view/core/constant.dart';
import 'package:studentdataapplication/view/screens/screen_edit_student.dart';
import 'package:studentdataapplication/view/widgets/app_bar_widget.dart';
import 'package:studentdataapplication/view/widgets/student_datails_widget.dart';

class StudentDetailsScreen extends StatelessWidget {
  const StudentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StudentController studentsController = Get.put(StudentController());
    studentsController.loadStudents();

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 90),
          child: AppBarWidget(
            onTapRight: () {
              _showSearchBar(context, studentsController);
            },
            righticon: Icons.search,
            lefticon: Icons.arrow_back,
            onTapLeft: () {
              Get.back();
            },
            title: 'Students Details',
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Obx(
              () {
                if (studentsController.students.isEmpty) {
                  return const Text('Student Details Not Found');
                } else {
                  final List<StudentModel> displayStudents =
                      studentsController.filteredStudents.isEmpty
                          ? studentsController.students.toList()
                          : studentsController.filteredStudents.toList();

                  if (displayStudents.isEmpty &&
                      !studentsController.isDataFound.value) {
                    return const Text('No Data Found');
                  } else {
                    return ListView.builder(
                      itemCount: displayStudents.length,
                      itemBuilder: (context, index) {
                        var student = displayStudents[index];
                        return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Constants().kblueAsscent,
                              ),
                              width: 250,
                              height: 300,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Constants().kwhiteColor,
                                      child: StudentImageContainerWidget(
                                        student: student,
                                        height: 135,
                                        width: 135,
                                      ),
                                    ),
                                  ),
                                  Constants().kheight10,
                                  Text(
                                    'Name: ${student.name}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Constants().kred,
                                    ),
                                  ),
                                  Constants().kheight10,
                                  Text(
                                    'Age: ${student.age}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Constants().kred,
                                    ),
                                  ),
                                  Constants().kheight10,
                                  Text(
                                    'Department: ${student.department}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Constants().kred,
                                    ),
                                  ),
                                  Constants().kheight10,
                                  Text(
                                    'Phone: ${student.phoneNumber}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Constants().kred,
                                    ),
                                  ),
                                  Constants().kheight10,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          showDeleteConfirmationDialog(
                                            context,
                                            student,
                                          );
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Get.dialog(EditStudentScreen(
                                              student: student));
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showSearchBar(BuildContext context, StudentController controller) {
    TextEditingController searchController = TextEditingController();

    Get.defaultDialog(
      title: 'Search Students',
      content: TextField(
        controller: searchController,
        decoration: const InputDecoration(
          hintText: 'Enter student name',
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          String query = searchController.text.trim();
          controller.filterStudents(query);
          Get.back();

          if (controller.filteredStudents.isEmpty) {
            Get.snackbar(
              'No Data Found',
              'No student found with the given name',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2),
              onTap: (_) {
                _showAllStudentsDialog(controller);
              },
            );
          } else {
            _showFilteredStudentsDialog(controller.filteredStudents);
          }
        },
        child: const Text('Search'),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('Cancel'),
      ),
    );
  }

  void _showFilteredStudentsDialog(List<StudentModel> students) {
    Get.defaultDialog(
      title: 'Filtered Students',
      content: SingleChildScrollView(
        child: Column(
          children: students.map((student) {
            return Card(
              color: Constants().kblueAsscent,
              child: ListTile(
                leading: CircleAvatar(
                  child: StudentImageContainerWidget(
                    student: student,
                    height: 50,
                    width: 50,
                  ),
                ),
                title: Text(student.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Age: ${student.age}'),
                    Constants().kWidth10,
                    Text('Department: ${student.department}'),
                    Constants().kWidth10,
                    Text('Phone: ${student.phoneNumber}'),
                    Constants().kWidth10,
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showAllStudentsDialog(StudentController controller) {
    Get.defaultDialog(
      title: 'All Students',
      content: SingleChildScrollView(
        child: Column(
          children: controller.students.map((student) {
            return ListTile(
              title: Text(student.name),
              subtitle: Text(student.department),
            );
          }).toList(),
        ),
      ),
    );
  }
}
