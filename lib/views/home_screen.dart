import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentgetx/controller/student_controller.dart';
import 'package:studentgetx/model/student_model.dart';
import 'package:studentgetx/views/detail_screen.dart';
import 'package:studentgetx/views/edit_screen.dart';
import 'package:studentgetx/widgets/title_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentController studentController = Get.find();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 227, 229),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 20,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TitleContainer(),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                      itemCount: studentController.studentList.length,
                      itemBuilder: (context, index) {
                        final StudentModel student =
                            studentController.studentList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => DetailScreen(student: student));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: student.photo.isNotEmpty
                                      ? FileImage(File(student.photo))
                                      : const AssetImage(
                                          'lib/assets/ea829acc861a7c3f81182ad2929a5242.jpg'),
                                  maxRadius: 30,
                                ),
                                title: Text(student.studentName ?? ''),
                                subtitle: Text(student.age ?? ''),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Get.to(() => EditStudent(
                                              student: student,
                                            ));
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        Get.dialog(AlertDialog(
                                          title: const Text('Delete'),
                                          content: const Text(
                                              'Are you sure you want to delete this student?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text('Cancel')),
                                            TextButton(
                                                onPressed: () {
                                                  studentController
                                                      .deleteStudent(student);
                                                  Get.back();
                                                },
                                                child: const Text('Delete'))
                                          ],
                                        ));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
