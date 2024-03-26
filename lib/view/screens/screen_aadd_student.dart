import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentdataapplication/controller/getController/student_controller.dart';
import 'package:studentdataapplication/controller/services/snackfunction.dart';
import 'package:studentdataapplication/model/student_model.dart';
import 'package:studentdataapplication/view/core/constant.dart';
import 'package:studentdataapplication/view/screens/screen_student_details.dart';
import 'package:studentdataapplication/view/widgets/app_bar_widget.dart';
import 'package:studentdataapplication/view/widgets/circle_avatar_widget.dart';
import 'package:studentdataapplication/view/widgets/text_formfield_widget.dart';

final StudentController studentsController = Get.put(StudentController());

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController departmentController = TextEditingController();
    TextEditingController phoneNoController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    RxString pickedimage = RxString('');

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 70),
          child: AppBarWidget(
            title: 'Students Information',
            // lefticon: Icons.arrow_back,
            // onTapLeft: () {
            //   Get.back();
            // },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  Center(
                    child: InkWell(
                      onTap: () async {
                        String? imagePath =
                            await studentsController.pickImage(ImageSource.gallery);
                        pickedimage.value = imagePath ?? '';
                      },
                      child: CircleAvatarWidget(pickedimage: pickedimage, radius: 80),
                    ),
                  ),
                  Constants().kheight20,
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextFielddWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 3) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          prefixicon: Icons.person,
                          controller: nameController,
                          hintText: 'Enter the name',
                          labelText: 'Name',
                          inputType: TextInputType.name,
                        ),
                        CustomTextFielddWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty || int.tryParse(value) == null) {
                              return 'Please enter a valid age';
                            }
                            int age = int.parse(value);
                            if (age <= 0 || age >= 120) {
                              return 'Please enter a valid age';
                            }
                            return null;
                          },
                          prefixicon: Icons.numbers,
                          controller: ageController,
                          hintText: 'Enter the age',
                          labelText: 'Age',
                          inputType: TextInputType.number,
                        ),
                        CustomTextFielddWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 3) {
                              return 'Please enter department';
                            }
                            return null;
                          },
                          prefixicon: Icons.person,
                          controller: departmentController,
                          hintText: 'Enter the department',
                          labelText: 'Department',
                          inputType: TextInputType.text,
                        ),
                        CustomTextFielddWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length != 10) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                          prefixicon: Icons.mobile_friendly,
                          controller: phoneNoController,
                          hintText: 'Enter the phone number',
                          labelText: 'Phone Number',
                          inputType: TextInputType.phone,
                        ),
                        Constants().kheight10,
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5),
                            backgroundColor: MaterialStateProperty.all(Constants().kblueAsscent),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate() && pickedimage.isNotEmpty) {
                              studentsController.addStudent(StudentModel(
                                name: nameController.text,
                                age: int.parse(ageController.text),
                                department: departmentController.text,
                                phoneNumber: int.parse(phoneNoController.text),
                                imageUrl: pickedimage.string,
                              ));
                              nameController.clear();
                              ageController.clear();
                              departmentController.clear();
                              phoneNoController.clear();
                              pickedimage.value = '';
                              snackBarFunction(
                                title: 'Success',
                                subtitle: 'Submitted Successfully',
                                backgroundColor: Colors.green,
                                animationDuration: const Duration(milliseconds: 2000),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              Get.to(() => const StudentDetailsScreen()); 
                            } else if (pickedimage.isEmpty) {
                              snackBarFunction(
                                title: 'Submission Failed',
                                subtitle: 'Please select an image',
                                backgroundColor: Colors.red,
                                dismissDirection: DismissDirection.horizontal,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                color: Constants().kwhiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
