// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bebek_takip/controllers/baby_controller.dart';
import 'package:bebek_takip/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:bebek_takip/models/baby_models.dart';
import 'package:bebek_takip/project_settings/project_color.dart';
import 'package:bebek_takip/project_settings/project_text.dart';

// ignore: must_be_immutable
class UpdateBaby extends StatefulWidget {
  Baby baby;
  UpdateBaby({
    super.key,
    required this.baby,
  });

  @override
  State<UpdateBaby> createState() => _UpdateBabyState();
}

class _UpdateBabyState extends State<UpdateBaby> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController headController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  BabyController controller = Get.find();
  @override
  void initState() {
    heightController.text = widget.baby.height.toString() ?? '0';
    weightController.text = widget.baby.weight.toString() ?? '0';
    headController.text = widget.baby.head.toString() ?? '0';
    noteController.text = widget.baby.note.toString() ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ProjectText.updateTitle,
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
              SizedBox(
                  height: Get.size.height * 0.30,
                  child: Image.asset("assets/images/updatePage.png")),
              SizedBox(
                height: Get.size.height * 0.02,
              ),
              SizedBox(
                height: Get.height * 0.05,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade100),
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      minTime: DateTime(2021, 01, 01, 01, 01),
                      locale: LocaleType.tr,
                      onConfirm: (time) {
                        widget.baby.time = time;
                        setState(() {});
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.date_range_outlined),
                      Text(
                          "${ProjectText.addDateButtonText} : ${widget.baby.time.day}/${widget.baby.time.month}/${widget.baby.time.year}"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.size.height * 0.02,
              ),
              inputTextField(ProjectText.addHeight, heightController),
              SizedBox(
                height: Get.size.height * 0.02,
              ),
              inputTextField(ProjectText.addWeight, weightController),
              SizedBox(
                height: Get.size.height * 0.02,
              ),
              inputTextField(ProjectText.addHead, headController),
              SizedBox(
                height: Get.size.height * 0.02,
              ),
              TextField(
                maxLines: 3,
                controller: noteController,
                textInputAction: TextInputAction.done,
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
                  controller.updateBaby(
                      widget.baby,
                      weightController.text,
                      heightController.text,
                      headController.text,
                      noteController.text,
                      widget.baby.time);

                  Get.back();
                },
                child: Text(
                  ProjectText.updateButtonText,
                ),
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
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          label: Text(text),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
