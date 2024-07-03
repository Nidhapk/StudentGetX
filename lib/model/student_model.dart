import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel extends HiveObject {
  @HiveField(0)
 late String? studentName;

  @HiveField(1)
 late String? place;

  @HiveField(2)
 late String? phoneNo;

  @HiveField(3)
 late String photo = '';

  @HiveField(4)
 late String? age;

  // StudentModel(
  //     {this.studentName, this.place, this.phoneNo, this.photo, this.age});
}
