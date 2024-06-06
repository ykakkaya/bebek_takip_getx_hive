// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bebek_takip/controllers/baby_datetime.dart';
import 'package:bebek_takip/project_settings/project_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppbar extends StatefulWidget {
  String title;
  MyAppbar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<MyAppbar> createState() => _MyAppbarState();
}

class _MyAppbarState extends State<MyAppbar> {
  BabyDateTimeController dateController = Get.put(BabyDateTimeController());
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: TextStyle(color: ProjectColors.appBarTextColor),
      ),
      centerTitle: true,
      backgroundColor: ProjectColors.appbarColor,
      actions: [
        IconButton(
            color: Colors.white,
            onPressed: () async {
              var time = await dateController.readDateTime();
              print("**********" + time.toString());
              dateController.deleteDateTime();
              var deletime = await dateController.readDateTime();
              print("******************");
              print("**********" + deletime.toString());
            },
            icon: Icon(Icons.menu_outlined))
      ],
    );
  }
}
