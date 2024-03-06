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

  updateBaby(
      Baby baby, String weight, String height, String? note, DateTime? time) {
    int w = parseValue(weight) ?? baby.weight;
    int h = parseValue(height) ?? baby.height;
    baby.height = h;
    baby.weight = w;
    baby.note = note ?? baby.note;
    baby.time = time ?? baby.time;
    hiveController.updateBaby(baby: baby);

    getAllList();
  }

  parseValue(String value) {
    return int.tryParse(value);
  }
}
