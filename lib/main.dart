import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:bebek_takip/controllers/baby_datetime.dart';
import 'package:bebek_takip/controllers/home_controller.dart';
import 'package:bebek_takip/models/baby_models.dart';
import 'package:bebek_takip/project_settings/project_color.dart';
import 'package:bebek_takip/project_settings/project_text.dart';
import 'package:bebek_takip/screens/add_baby.dart';
import 'package:bebek_takip/screens/analiz_page.dart';
import 'package:bebek_takip/screens/grafik_page.dart';
import 'package:bebek_takip/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_storage/get_storage.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();
  await GetStorage.init();
  Hive.registerAdapter(BabyAdapter());
  await Hive.openBox<Baby>('babyBox');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bebek takip',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const IndexPage(),
    );
  }
}

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final HomeController controller = Get.put(HomeController());
  final BabyDateTimeController dateController =
      Get.put(BabyDateTimeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Obx(() => MyAppbar(
                title: (controller.currentIndex.value == 0)
                    ? ProjectText.grafikAppbarText
                    : ProjectText.analizAppbarText,
              ))),
      body: SafeArea(child: Obx(() => _getPage(controller.currentIndex.value))),
      bottomNavigationBar: Obx(
        () => AnimatedBottomNavigationBar(
          backgroundColor: ProjectColors.bottomNavigatorColor,
          icons: const [Icons.auto_graph_outlined, Icons.file_present_outlined],
          activeIndex: controller.currentIndex.value,
          activeColor: ProjectColors.bottomActiveColor,
          inactiveColor: ProjectColors.bottomInactiveColor,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index) => controller.changePage(index),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var birthday = await dateController.readDateTime();
          if (birthday != null) {
            Get.off(() => const AddBaby());
          } else {
            Get.defaultDialog(
              title: "Bebeğinizin Doğum Gününü Giriniz.",
              content: SizedBox(
                height: Get.height * 0.05,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade100),
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      minTime: DateTime(2021, 01, 01, 01, 01),
                      locale: LocaleType.tr,
                      onConfirm: (time) async {
                        await dateController.writeDateTime(time);
                        var birth = await dateController.readDateTime();

                        if (birth != null) {
                          Get.back(); // Diyalog kutusunu kapat
                          Get.off(() => const AddBaby());
                        } else {
                          Get.back(); // Diyalog kutusunu kapat
                        }
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.date_range_outlined),
                      Obx(() => Text(
                          "Doğum Tarihi : ${dateController.time.value.day}/${dateController.time.value.month}/${dateController.time.value.year}")),
                    ],
                  ),
                ),
              ),
            );
          }
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

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const GrafikPage();

      case 1:
        return const AnalizPage();
      default:
        return const GrafikPage();
    }
  }
}
