import 'package:flutter/material.dart';

class TitleContainer extends StatelessWidget {
  const TitleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 15),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 72, 89, 102),
                Color.fromARGB(255, 47, 38, 48)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  icon:const  Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  )),
             const  SizedBox(
                width: 20,
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 10, color: Colors.white),
              borderRadius: BorderRadius.circular(60)),
          child: const CircleAvatar(
            backgroundImage:
                AssetImage('lib/assets/a69edb28c7ff8521a3fb8825b56a995c.jpg'),
            maxRadius: 48,
          ),
        ),
      )
    ]);
  }
}
