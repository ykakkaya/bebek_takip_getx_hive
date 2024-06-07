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
  var vaccineSchedule = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vaccineSchedule = controller.getVaccineSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: vaccineSchedule.length,
      itemBuilder: (context, index) {
        final schedule = vaccineSchedule[index];
        return Obx(() => Card(
              color: controller.checkedList[index] ? Colors.red.shade100 : null,
              child: ListTile(
                leading: schedule['age'] == '' ? null : Icon(Icons.vaccines),
                title: Text(
                  schedule['vaccine']!,
                  style: TextStyle(
                    decoration: controller.checkedList[index] ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: schedule['age'] == ''
                    ? Text(
                        schedule['age']!,
                      )
                    : Text(
                        "Aşı Tarihi: ${schedule['age']!}",
                        style: TextStyle(
                          decoration: controller.checkedList[index] ? TextDecoration.lineThrough : null,
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
    ));
  }
}
