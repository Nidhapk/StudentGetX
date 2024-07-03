import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:studentgetx/controller/student_controller.dart';
import 'package:studentgetx/model/student_model.dart';
import 'package:studentgetx/views/detail_screen.dart';
import 'package:studentgetx/widgets/custom_listview.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final StudentController studentController = Get.find();
    studentController.filteredStudentList.clear();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 227, 229),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CupertinoSearchTextField(
              padding: const EdgeInsets.all(20),
              controller: searchController,
              onChanged: (value) =>
                  studentController.searchStudent(searchController.text),
            ),
            Obx(
              () => studentController.filteredStudentList.isEmpty &&
                      searchController.text.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 150.0),
                      child: SvgPicture.asset(
                        'lib/assets/55024593_9264820.svg',
                        height: 200,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount:
                              studentController.filteredStudentList.length,
                          itemBuilder: (context, index) {
                            StudentModel student =
                                studentController.filteredStudentList[index];
                            return InkWell(
                              onTap: () {
                                Get.to(DetailScreen(student: student));
                              },
                              child: CustomListView(
                                backgroundImage: student.photo.isNotEmpty
                                    ? FileImage(File(student.photo))
                                    : const AssetImage(
                                        'lib/assets/ea829acc861a7c3f81182ad2929a5242.jpg'),
                                title: student.studentName!,
                                subtitle: student.age!,
                              ),
                            );
                          }),
                    ),
            )
          ],
        ),
      )),
    );
  }
}
