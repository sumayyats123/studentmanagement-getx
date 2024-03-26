import 'package:sqflite/sqflite.dart';
import 'package:studentdataapplication/model/student_model.dart';


class DbHelper {
  Database? _database;

  Future<Database?> getDatabase() async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
      return _database;
    }
  }

  Future<Database?> initDB() async {
    return await openDatabase(
      "studentsDb",
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute(
            'CREATE TABLE studentTable(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, department TEXT, place TEXT, phoneNumber INTEGER, guardianName TEXT, imageUrl TEXT)');
      },
    );
  }

  Future<void> insertData(StudentModel studentData) async {
    final db = await getDatabase();
    db!.insert('studentTable', studentData.toMap());
  }

  Future<List<Map<String, dynamic>>> getAllStudentsData() async {
    final db = await getDatabase();
    final value = await db!.rawQuery('SELECT * FROM studentTable');
    return value;
  }

  Future<void> updateStudentDetailsFromDB(StudentModel updatedStudent) async {
    final db = await getDatabase();

    await db!.update(
      'studentTable',
      {
        'id': updatedStudent.id,
        'name': updatedStudent.name,
        'age': updatedStudent.age,
        'department': updatedStudent.department,
       
        'phoneNumber': updatedStudent.phoneNumber,
       
        'imageUrl': updatedStudent.imageUrl
      },
      where: 'id = ?',
      whereArgs: [updatedStudent.id],
    );
  }

  Future<void> deleteStudent(int id) async {
    final db = await getDatabase();
    await db!.rawDelete('DELETE FROM studentTable WHERE id = ?', [id]);
  }
}









