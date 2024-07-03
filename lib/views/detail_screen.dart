import 'dart:io';
import 'package:flutter/material.dart';
import 'package:studentgetx/model/student_model.dart';
import 'package:studentgetx/widgets/detail_row.dart';
import 'package:studentgetx/widgets/divider.dart';

class DetailScreen extends StatelessWidget {
  final StudentModel student;
  const DetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 227, 229),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              CircleAvatar(
                backgroundImage: student.photo.isNotEmpty
                    ? FileImage(File(student.photo))
                    : const AssetImage(
                        'lib/assets/ea829acc861a7c3f81182ad2929a5242.jpg'),
                maxRadius: 50,
              ),
              const SizedBox(
                height: 50,
              ),
              DetailRow(title: 'Name', details: student.studentName ?? ''),
              const Kdivider(),
              DetailRow(title: 'Age', details: student.age ?? ''),
              const Kdivider(),
              DetailRow(title: 'Place', details: student.place ?? ''),
              const Kdivider(),
              DetailRow(title: 'Phone no.', details: student.phoneNo ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
