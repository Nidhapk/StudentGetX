import 'package:flutter/material.dart';
import 'package:studentgetx/views/add_student.dart';
import 'package:studentgetx/views/home_screen.dart';
import 'package:studentgetx/views/search_screen.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: Container(
            color: Colors.black,
            height: 70,
            child: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                  ),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(
                    Icons.search,
                  ),
                  text: 'Search',
                ),
                Tab(
                  icon: Icon(
                    Icons.person_add_alt_1,
                  ),
                  text: 'Add',
                )
              ],
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
            ),
          ),
          body: TabBarView(
              children: [const HomeScreen(),  SearchScreen(), AddStudent()]),
        ));
  }
}
