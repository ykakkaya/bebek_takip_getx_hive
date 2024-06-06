import 'package:bebek_takip/controllers/baby_controller.dart';
import 'package:bebek_takip/models/baby_models.dart';
import 'package:bebek_takip/project_settings/project_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GrafikPage extends StatefulWidget {
  const GrafikPage({super.key});

  @override
  State<GrafikPage> createState() => _GrafikPageState();
}

class _GrafikPageState extends State<GrafikPage> {
  BabyController controller = Get.put(BabyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              title: ChartTitle(text: ProjectText.weightChartTitle),
              primaryXAxis: const CategoryAxis(),
              series: <LineSeries<Baby, String>>[
                LineSeries(
                  dataSource: controller.babyList,
                  xValueMapper: (Baby baby, _) =>
                      "${baby.time.day}/${baby.time.month}",
                  yValueMapper: (Baby baby, _) => baby.weight,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                )
              ],
            ),
            SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              title: ChartTitle(text: ProjectText.heightChartTitle),
              primaryXAxis: const CategoryAxis(),
              series: <LineSeries<Baby, String>>[
                LineSeries(
                  dataSource: controller.babyList,
                  xValueMapper: (Baby baby, _) =>
                      "${baby.time.day}/${baby.time.month}",
                  yValueMapper: (Baby baby, _) => baby.height,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                )
              ],
            ),
            SizedBox(
              height: Get.size.height * 0.05,
            )
          ],
        ),
      ),
    );
  }
}
