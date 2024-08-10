// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentgetx/common/colors.dart';
import 'package:studentgetx/controller/student_controller.dart';
import 'package:studentgetx/model/student_model.dart';
import 'package:studentgetx/widgets/custom_form.dart';
import 'package:studentgetx/widgets/custom_textform.dart';

class EditStudent extends StatelessWidget {
  StudentModel student;
  //final StudentController studentController = Get.put(StudentController());
  final StudentController studentController = Get.find<StudentController>();

  final PickedImageEditController pickedImageEditController =
      Get.put(PickedImageEditController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  EditStudent({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: student.studentName);
    final TextEditingController ageController =
        TextEditingController(text: student.age);
    final TextEditingController placeController =
        TextEditingController(text: student.place);
    final TextEditingController phoneController =
        TextEditingController(text: student.phoneNo);
    pickedImageEditController.selectedimage.value = File(student.photo);
    return Scaffold(
        backgroundColor: paleBlue,
        body: Obx(
          () => CustomForm(
            icon: GestureDetector(
              onTap: () => pickImage(pickedImageEditController),
              child: Padding(
                padding: const EdgeInsets.only(left: 140, top: 115),
                child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    child: pickedImageEditController.selectedimage.value != null
                        ? ClipOval(
                            child: Image.file(
                              pickedImageEditController.selectedimage.value!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.add_photo_alternate,
                            size: 60,
                            color: Colors.white,
                          )),
              ),
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 130,
                    ),
                    CustomTextForm(
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name cant be empty';
                          } else {
                            return null;
                          }
                        },
                        hintext: 'Name',
                        labeltext: 'Enter your name'),
                    CustomTextForm(
                        keyboardType: TextInputType.number,
                        controller: ageController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'age cant be empty';
                          } else {
                            return null;
                          }
                        },
                        hintext: 'Age',
                        labeltext: 'Enter your age'),
                    CustomTextForm(
                        keyboardType: TextInputType.name,
                        controller: placeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'place cant be empty';
                          } else {
                            return null;
                          }
                        },
                        hintext: 'Place',
                        labeltext: 'Enter your place'),
                    CustomTextForm(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'phone no. cant be empty';
                          } else {
                            return null;
                          }
                        },
                        hintext: 'Phone no.',
                        labeltext: 'Enter your phone no.'),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.only(
                              left: 128, right: 128, top: 15, bottom: 15),
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 147, 168, 178),
                        ),
                        onPressed: () {
                          saveStudent(
                              student,
                              nameController.text.trim(),
                              ageController.text.trim(),
                              placeController.text.trim(),
                              phoneController.text.trim(),
                              pickedImageEditController
                                  .selectedimage.value!.path);
                        },
                        child: const Text('Submit')),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> addStudent(StudentModel student) async {
    final studentBox = await Hive.openBox<StudentModel>('student');
    await studentBox.add(student);
  }

  saveStudent(StudentModel key, String name, String age, String place,
      String phone, String photo) async {
    await studentController.updateStudent(key, name, age, phone, photo, age);
    Get.back();
    Get.snackbar('Updated', 'student has been updated successfully',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
  }

  void pickImage(PickedImageEditController controller) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        controller.selectedimage.value = File(pickedImage.path);
      }
    } catch (e) {
      log(5);
    }
  }
}

class PickedImageEditController extends GetxController {
  Rx<File?> selectedimage = Rx<File?>(null);
}
