import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BabyDateTimeController extends GetxController {
  final box = GetStorage();
  var time = DateTime.now().obs;

  Future<DateTime?> readDateTime() async {
    var birthdayString = await box.read('date');
    if (birthdayString != null) {
      return DateTime.parse(birthdayString);
    }
    return null;
  }

  Future<void> writeDateTime(DateTime time) async {
    await box.write('date', time.toIso8601String());
  }

  Future<void> deleteDateTime() async {
    await box.remove('date');
  }
}
