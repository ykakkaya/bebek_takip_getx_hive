import 'package:bebek_takip/data/hive_local_storage.dart';
import 'package:bebek_takip/data/local_storage.dart';
import 'package:bebek_takip/models/baby_models.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class BabyController extends GetxController {
  LocalStorage hiveController = HiveLocalStorage();

  var babyList = <Baby>[].obs;

  @override
  Future<void> onInit() async {
    await getAllList();
    super.onInit();
  }

  getAllList() async {
    babyList.assignAll(await hiveController.getAllBaby());
  }

  addBabyList(Baby b) {
    hiveController.addBaby(baby: b);
    getAllList();
  }

  removeBabyList(Baby b) {
    hiveController.deleteBaby(baby: b);
    getAllList();
  }

  updateBaby(Baby baby, String weight, String height, String head, String? note,
      DateTime? time) {
    double w = double.tryParse(weight) ?? baby.weight;
    double h = double.tryParse(height) ?? baby.height;
    double hd = double.tryParse(head) ?? baby.head;
    baby.height = h;
    baby.weight = w;
    baby.head = hd;
    baby.note = note ?? baby.note;
    baby.time = time ?? baby.time;
    hiveController.updateBaby(baby: baby);

    getAllList();
  }

  parseValue(String value) {
    return int.tryParse(value);
  }
}
