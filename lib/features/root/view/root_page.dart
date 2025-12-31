import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leraner/features/home/view/home_page.dart';
import 'package:leraner/features/root/controller/root_controller.dart';
import 'package:leraner/features/subjects/view/subject_page.dart';


class RootPage extends StatelessWidget {
  RootPage({super.key});

  final controller = Get.put(RootController());

  final pages = [
     HomePage(),
     SubjectsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: pages[controller.currentIndex.value],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          selectedItemColor: const Color(0xff4AA8B5),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_circle),
              label: 'Pages',
            ),
          ],
        ),
      );
    });
  }
}
