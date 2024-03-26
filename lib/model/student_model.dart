class StudentModel {
  int? id;
  late String name;
  late int age;
  late String department;
  late int phoneNumber;
 final  String? imageUrl;

  StudentModel(
      {this.id,
      required this.name,
      required this.age,
      required this.department,
      
      required this.phoneNumber,
       this.imageUrl});

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
        id: map['id'],
        name: map['name'],
        age: map['age'],
        department: map['department'],
       
        phoneNumber: map['phoneNumber'],
       
        imageUrl: map['imageUrl']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'department': department,
    
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
    };
  }
}
