import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
 // final ImageProvider<Object>? backgroundImage;
  final Widget? child;
  //final void Function()? onTap;
  final Widget? icon;
  const CustomForm(
      {super.key,
      required this.child,
     // required this.backgroundImage,
     // required this.onTap,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        child: Image.asset(
          'lib/assets/9d41433209bf9b5171b48d038fcacc88.jpg',
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 20, right: 20),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 71, 74, 75).withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            //height: 550,
            child: child),
      ),
    
      
    icon!
    ]);
  }
}
