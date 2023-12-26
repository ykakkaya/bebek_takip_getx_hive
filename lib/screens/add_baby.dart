import 'package:bebek_takip/controllers/baby_controller.dart';
import 'package:bebek_takip/models/baby_models.dart';
import 'package:bebek_takip/project_settings/project_color.dart';
import 'package:bebek_takip/project_settings/project_text.dart';
import 'package:bebek_takip/screens/analiz_page.dart';
import 'package:bebek_takip/screens/index_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';

class AddBaby extends StatefulWidget {
  const AddBaby({super.key});

  @override
  State<AddBaby> createState() => _AddBabyState();
}

class _AddBabyState extends State<AddBaby> {
  BabyController controller = Get.find();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  var _time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ProjectText.addTitle,
          style: TextStyle(color: ProjectColors.appBarTextColor),
        ),
        backgroundColor: ProjectColors.appbarColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: ProjectColors.fabIconColor,
          ),
          onPressed: () {
            Get.off(() => const IndexPage());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/images/add_page.png"),
              inputTextField(ProjectText.addHeight, heightController),
              SizedBox(
                height: Get.size.height * 0.02,
              ),
              inputTextField(ProjectText.addWeight, weightController),
              SizedBox(
                height: Get.size.height * 0.02,
              ),
              TextField(
                maxLines: 3,
                controller: noteController,
                decoration: InputDecoration(
                    label: Text(ProjectText.addNote),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: Get.size.height * 0.02,
              ),
              ElevatedButton(
                onPressed: () {
                  DatePicker.showDatePicker(
                    context,
                    minTime: DateTime(2021, 01, 01, 01, 01),
                    locale: LocaleType.tr,
                    onConfirm: (time) {
                      _time = time;
                      setState(() {});
                    },
                  );
                },
                child: Text(
                    "${ProjectText.addDateButtonText} : ${_time.day}/${_time.month}/${_time.year}"),
              ),
              ElevatedButton(
                onPressed: () {
                  int weight = int.tryParse(weightController.text) ?? 0;
                  int height = int.tryParse(heightController.text) ?? 0;
                  String note = noteController.text ?? '';
                  Baby baby = Baby(
                      time: _time, weight: weight, height: height, note: note);
                  controller.addBabyList(baby);
                  Get.off(() => const IndexPage());
                },
                child: Text(ProjectText.addButtonText),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget inputTextField(
    String text,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          label: Text(text),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
