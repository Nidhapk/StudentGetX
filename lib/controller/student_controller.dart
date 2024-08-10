import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:studentgetx/model/student_model.dart';
import 'package:studentgetx/widgets/botton_nav.dart';

class StudentController extends GetxController {
  RxList<StudentModel> studentRxList = <StudentModel>[].obs;
  final RxList<StudentModel> filteredStudentList = <StudentModel>[].obs;
  late Box<StudentModel> studentBox;

  @override
  void onInit() {
    super.onInit();
    _openBox();
  }

  Future<void> _openBox() async {
    studentBox = await Hive.openBox<StudentModel>('student');
    loadStudents();
  }

  List<StudentModel> get studentList => studentRxList.toList();

  Future<void> loadStudents() async {
    studentRxList.assignAll(studentBox.values.toList().cast<StudentModel>());
    studentBox.watch().listen((event) => studentRxList
        .assignAll(studentBox.values.toList().cast<StudentModel>()));
  }

  Future<void> addStudent(StudentModel student) async {
    try {
      await studentBox.add(student);
      
      Get.snackbar(
        'Success',
        'Student added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAll(const BottomNav());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add student: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> deleteStudent(StudentModel student) async {
    await studentBox.delete(student.key);
    studentRxList.remove(student);
  }

  Future<void> updateStudent(StudentModel student, String name, String place,
      String phoneNo, String photo, String age) async {
    final index =
        studentRxList.indexWhere((element) => element.key == student.key);

    studentRxList[index].studentName = name;
    studentRxList[index].age = age;
    studentRxList[index].place = place;
    studentRxList[index].phoneNo = phoneNo;
    studentRxList[index].photo = photo;

    await studentBox.put(studentRxList[index].key, studentRxList[index]);
  }

  searchStudent(String query) {
    if (query.isEmpty) {
      filteredStudentList.clear();
    } else {
      List<StudentModel> result = studentRxList
          .where((student) =>
              student.studentName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      filteredStudentList.assignAll(result);
    }
  }
}
