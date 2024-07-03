import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final ImageProvider<Object>? backgroundImage;
  final String title;
  final String subtitle;
  
  const CustomListView(
      {super.key,
      required this.backgroundImage,
      required this.title,
      required this.subtitle,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: backgroundImage,
            maxRadius: 30,
          ),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
