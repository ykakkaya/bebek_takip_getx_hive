import 'package:bebek_takip/controllers/baby_datetime.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class VaccineController extends GetxController {
  BabyDateTimeController dateController = Get.put(BabyDateTimeController());
  var t = DateTime.now().obs;
  var vaccineSchedule = <Map<String, String>>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getDate();
    vaccineSchedule.assignAll(await getVaccineSchedule());
  
  }

  getDate() async {
    t.value = await dateController.readDateTime() ?? DateTime(2021);
 
  }

  updateList() async {
    await getDate();
    vaccineSchedule.assignAll(await getVaccineSchedule());
    
  }

  RxList<Map<String, String>> getVaccineSchedule() {
   
    return [
      {
        'age':
            "Doğunca :${t.value.day.toString()}/${t.value.month.toString()}/${t.value.year.toString()}",
        'vaccine': 'Hepatit B (1. doz)'
      },
      {
        'age':
            "${t.value.add(Duration(days: 30)).day.toString()}/${t.value.add(Duration(days: 30)).month.toString()}/${t.value.add(Duration(days: 30)).year.toString()}",
        'vaccine': 'Hepatit B (2. doz)'
      },
      {
        'age':
            "${t.value.add(Duration(days: 60)).day.toString()}/${t.value.add(Duration(days: 60)).month.toString()}/${t.value.add(Duration(days: 60)).year.toString()}",
        'vaccine': 'BCG, DaBT-IPA-Hib, KPA'
      },
      {
        'age':
            "${t.value.add(Duration(days: 120)).day.toString()}/${t.value.add(Duration(days: 120)).month.toString()}/${t.value.add(Duration(days: 120)).year.toString()}",
        'vaccine': 'DaBT-IPA-Hib, KPA'
      },
      {
        'age':
            "${t.value.add(Duration(days: 180)).day.toString()}/${t.value.add(Duration(days: 180)).month.toString()}/${t.value.add(Duration(days: 180)).year.toString()}",
        'vaccine': 'Hepatit B (3. doz), DaBT-IPA-Hib, KPA'
      },
      {
        'age':
            "${t.value.add(Duration(days: 365)).day.toString()}/${t.value.add(Duration(days: 365)).month.toString()}/${t.value.add(Duration(days: 365)).year.toString()}",
        'vaccine': 'KPA, KKK, Suçiçeği'
      },
      {
        'age':
            "${t.value.add(Duration(days: 540)).day.toString()}/${t.value.add(Duration(days: 540)).month.toString()}/${t.value.add(Duration(days: 540)).year.toString()}",
        'vaccine': 'DaBT-IPA-Hib, KKK (2. doz)'
      },
      {
        'age':
            "${t.value.add(Duration(days: 730)).day.toString()}/${t.value.add(Duration(days: 730)).month.toString()}/${t.value.add(Duration(days: 730)).year.toString()}",
        'vaccine': 'Hepatit A (1. doz)'
      },
      {
        'age':
            "${t.value.add(Duration(days: 900)).day.toString()}/${t.value.add(Duration(days: 900)).month.toString()}/${t.value.add(Duration(days: 900)).year.toString()}",
        'vaccine': 'Hepatit A (2. doz)'
      },
      {
        'age':
            "${t.value.add(Duration(days: 1440)).day.toString()}/${t.value.add(Duration(days: 1440)).month.toString()}/${t.value.add(Duration(days: 1440)).year.toString()}",
        'vaccine': 'DaBT-IPA'
      },
      {'age': "", 'vaccine': ''},
    ].obs;
  }

  var checkedList = List<bool>.filled(11, false).obs;

  void toggleCheck(int index) {
    checkedList[index] = !checkedList[index];
  }
}
