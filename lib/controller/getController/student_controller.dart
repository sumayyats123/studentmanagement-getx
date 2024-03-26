import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentdataapplication/controller/services/database.dart';
import 'package:studentdataapplication/model/student_model.dart';


class StudentController extends GetxController {
  var students = <StudentModel>[].obs;
  var filteredStudents = <StudentModel>[].obs;
   RxBool isDataFound = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadStudents();
    print('the length of list is ${students.length}');
  }

  Future pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) {
        return;
      }
      return pickedFile.path;
    } catch (e) {
      print('error fetching error');
    }
  }

  void loadStudents() async {
    List<Map<String, dynamic>> studentData =
        await DbHelper().getAllStudentsData();
    students.assignAll(
        studentData.map((data) => StudentModel.fromMap(data)).toList());
    filterStudents(''); 
  }

  void filterStudents(String query) {
    print('Filtering students with query: $query');
    filteredStudents.assignAll(students
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase()))
        .toList());
    print('Filtered students: $filteredStudents');
  }

  void addStudent(StudentModel student) async {
    await DbHelper().insertData(student);
    loadStudents();
  }

  void updateStudent(StudentModel updatedstudent) async {
    await DbHelper().updateStudentDetailsFromDB(updatedstudent);
    loadStudents();
  }

  void deleteStudent(int id) async {
    await DbHelper().deleteStudent(id);
    loadStudents();
  }
}
