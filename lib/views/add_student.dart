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

class AddStudent extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
  final PickedImageController pickedImageController =
      Get.put(PickedImageController());
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final placeController = TextEditingController();
  final phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: paleBlue,
        body: Obx(
          () => CustomForm(
            icon: GestureDetector(
              onTap: () => pickImage(pickedImageController),
              child: Padding(
                padding: const EdgeInsets.only(left: 140, top: 115),
                child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    child: pickedImageController.selectedimage.value != null
                        ? ClipOval(
                            child: Image.file(
                              pickedImageController.selectedimage.value!,
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
                        controller: phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'place cant be empty';
                          } else {
                            return null;
                          }
                        },
                        hintext: 'Phone no.',
                        labeltext: 'Enter your phone no.'),
                    const SizedBox(height: 15),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding:const  EdgeInsets.only(
                              left: 128, right: 128, top: 15, bottom: 15),
                          foregroundColor: Colors.white,
                          backgroundColor:const   Color.fromARGB(255, 147, 168, 178),
                        ),
                        onPressed: saveStudent,
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

  void saveStudent() async {
    if (formKey.currentState!.validate()) {
      
      StudentModel student = StudentModel();
      student.studentName = nameController.text.trim();
      student.age = ageController.text.trim();
      student.place = placeController.text.trim();
      student.phoneNo = phoneController.text.trim();
      student.photo = pickedImageController.selectedimage.value?.path ?? '';

      await studentController.addStudent(student);
    }
  }

  void pickImage(PickedImageController controller) async {
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

class PickedImageController extends GetxController {
  Rx<File?> selectedimage = Rx<File?>(null);
}
