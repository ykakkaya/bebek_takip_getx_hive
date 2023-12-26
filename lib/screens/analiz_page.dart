import 'package:bebek_takip/controllers/baby_controller.dart';
import 'package:bebek_takip/project_settings/project_color.dart';
import 'package:bebek_takip/project_settings/project_text.dart';
import 'package:bebek_takip/screens/update_baby.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnalizPage extends StatefulWidget {
  const AnalizPage({super.key});

  @override
  State<AnalizPage> createState() => _AnalizPageState();
}

class _AnalizPageState extends State<AnalizPage> {
  @override
  void initState() {
    controller.getAllList();
    super.initState();
  }

  BabyController controller = Get.put(BabyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ProjectText.analizAppbarText,
          style: TextStyle(color: ProjectColors.appBarTextColor),
        ),
        centerTitle: true,
        backgroundColor: ProjectColors.appbarColor,
      ),
      body: Obx(
        () => controller.babyList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ProjectText.emptyWelcome,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Image.asset("assets/images/anne.png"),
                    Text(
                      ProjectText.emptyPageString,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Icon(
                      Icons.arrow_circle_down,
                      size: 30,
                      color: ProjectColors.iconColor,
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: controller.babyList.length ?? 0,
                itemBuilder: (context, index) {
                  var item = controller.babyList[index];

                  return GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                          title: ProjectText.showDialogTitle,
                          content: Row(
                            children: [
                              SizedBox(
                                  width: Get.size.width * 0.30,
                                  child: Image.asset("assets/images/show.png")),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${ProjectText.date}:  ${item.time.day}/${item.time.month}/${item.time.year}"),
                                    Text(
                                        "${ProjectText.height}:  ${item.height} - ${ProjectText.weight}:  ${item.weight}"),
                                    Text(
                                      "${ProjectText.description}:"
                                              "${item.note}" ??
                                          '',
                                      maxLines: 15,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ));
                    },
                    child: SizedBox(
                      height: Get.size.height * 0.15,
                      child: Card(
                        child: Center(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: Get.size.height * 0.035,
                              child: Column(
                                children: [
                                  Text("${item.time.day}/${item.time.month}"),
                                  Text(item.time.year.toString())
                                ],
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("${ProjectText.height}: ${item.height}"),
                                Text("${ProjectText.weight}: ${item.weight}")
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.to(() => UpdateBaby(
                                            baby: item,
                                          ));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: ProjectColors.listTileUpdate,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      Get.snackbar("Uyarı",
                                          "Veriyi Silmek İstiyor musunuz?",
                                          dismissDirection:
                                              DismissDirection.startToEnd,
                                          duration: const Duration(seconds: 2),
                                          mainButton: TextButton(
                                              onPressed: () {
                                                controller.removeBabyList(item);
                                              },
                                              child: const Text("Evet")));
                                    },
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: ProjectColors.listTileDelete,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                  return null;
                }),
      ),
    );
  }
}
