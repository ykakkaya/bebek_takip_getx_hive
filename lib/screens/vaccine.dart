import 'package:bebek_takip/controllers/baby_datetime.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bebek_takip/controllers/vaccine_controller.dart';

class Vaccine extends StatefulWidget {
  @override
  State<Vaccine> createState() => _VaccineState();
}

class _VaccineState extends State<Vaccine> {
  final VaccineController controller = Get.put(VaccineController());
  BabyDateTimeController dateController = Get.put(BabyDateTimeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
            body: ListView.builder(
          itemCount: controller.vaccineSchedule.length,
          itemBuilder: (context, index) {
            var schedule = controller.vaccineSchedule[index];

            return Obx(() => Card(
                  color: controller.checkedList[index]
                      ? Colors.red.shade100
                      : null,
                  child: ListTile(
                    leading:
                        schedule['age'] == '' ? null : Icon(Icons.vaccines),
                    title: Text(
                      schedule['vaccine']!,
                      style: TextStyle(
                        decoration: controller.checkedList[index]
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: schedule['age'] == ''
                        ? Text(
                            schedule['age']!,
                          )
                        : Text(
                            "Aşı Tarihi: ${schedule['age']!}",
                            style: TextStyle(
                              decoration: controller.checkedList[index]
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                    trailing: schedule['age'] == ''
                        ? null
                        : Checkbox(
                            value: controller.checkedList[index],
                            onChanged: (bool? value) {
                              controller.toggleCheck(index);
                            },
                          ),
                  ),
                ));
          },
        )));
  }
}
