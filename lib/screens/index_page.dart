import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:bebek_takip/project_settings/project_color.dart';
import 'package:bebek_takip/project_settings/project_text.dart';
import 'package:bebek_takip/screens/add_baby.dart';
import 'package:bebek_takip/screens/analiz_page.dart';
import 'package:bebek_takip/screens/grafik_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  var _selectedIndex = 1;
  Widget _selectedPage = const AnalizPage();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedPage,
      bottomNavigationBar: AnimatedBottomNavigationBar(
          gapLocation: GapLocation.center,
          backgroundColor: ProjectColors.bottomNavigatorColor,
          activeColor: ProjectColors.bottomActiveColor,
          inactiveColor: ProjectColors.bottomInactiveColor,
          icons: const [Icons.auto_graph_outlined, Icons.file_present_outlined],
          activeIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _selectedIndex == 0
                  ? (_selectedPage = const GrafikPage())
                  : (_selectedPage = const AnalizPage());
            });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.off(() => const AddBaby());
        },
        shape: const CircleBorder(),
        backgroundColor: ProjectColors.fabButtonColor,
        child: Icon(
          Icons.add,
          color: ProjectColors.fabIconColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
