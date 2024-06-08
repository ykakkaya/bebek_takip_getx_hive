// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bebek_takip/controllers/baby_datetime.dart';
import 'package:bebek_takip/controllers/vaccine_controller.dart';
import 'package:bebek_takip/project_settings/project_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
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
  VaccineController controller = Get.put(VaccineController());
  getDate() async {
    print(await dateController.readDateTime());
  }

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
        PopupMenuButton(
            iconColor: Colors.white,
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  child: FutureBuilder<DateTime?>(
                    future: dateController.readDateTime(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Yükleniyor...");
                      } else if (snapshot.hasError) {
                        return Text("Hata: ${snapshot.error}");
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Text("Doğum Tarihi Bulunamadı");
                      } else {
                        final date = snapshot.data!;
                        final formattedDate =
                            "${date.day}/${date.month}/${date.year}";
                        return Text("Doğum Tarihi: $formattedDate");
                      }
                    },
                  ),
                  value: 0,
                ),
                PopupMenuItem(
                  child: Text("Doğum Tarihi Ekle/Güncelle"),
                  value: 1,
                  onTap: () async {
                    DatePicker.showDatePicker(
                      context,
                      currentTime: await dateController.readDateTime(),
                      minTime: DateTime(2021, 01, 01, 01, 01),
                      locale: LocaleType.tr,
                      onConfirm: (time) async {
                        await dateController.writeDateTime(time);
                        await controller.updateList();
                        Get.snackbar(
                          'Bebek Takip',
                          'Doğum Tarihi Güncellendi',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red.shade100,
                        );
                        setState(() {});
                      },
                    );
                  },
                ),
                PopupMenuItem(
                  child: Text("Doğum Tarihini Sil"),
                  value: 2,
                  onTap: () async {
                    dateController.deleteDateTime();
                    Get.snackbar(
                      'Bebek Takip',
                      'Doğum Tarihi Silindi',
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red.shade100,
                    );
                    setState(() {});
                  },
                ),
              ];
            })
      ],
    );
  }
}
