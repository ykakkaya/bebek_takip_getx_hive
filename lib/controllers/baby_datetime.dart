import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BabyDateTimeController extends GetxController {
  final box = GetStorage();
  var time = DateTime.now().obs;
 Future<DateTime?> readDateTime() async {
    var birthday = await box.read('date');
    return birthday;
  }

  Future<void> writeDateTime(DateTime time) async {
    await box.write('date', time);
  }

  Future<void> deleteDateTime() async {
    await box.remove('date');
  }
}
