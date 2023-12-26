// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'package:bebek_takip/data/local_storage.dart';
import 'package:bebek_takip/models/baby_models.dart';

class HiveLocalStorage extends LocalStorage {
  static late Box<Baby> babyBox;
  HiveLocalStorage() {
    getBox();
  }

  getBox() async {
    babyBox = Hive.box<Baby>('babyBox');
  }

  @override
  Future<void> addBaby({required Baby baby}) async {
    await babyBox.put(baby.time.toString(), baby);
  }

  @override
  Future<void> deleteBaby({required Baby baby}) async {
    await baby.delete();
  }

  @override
  Future<List<Baby>> getAllBaby() async {
    List<Baby> babyList = [];
    babyList = babyBox.values.toList();
    if (babyList.isNotEmpty) {
      babyList.sort((a, b) => a.time.compareTo(b.time));
    }
    return babyList;
  }

  @override
  Future<void> updateBaby({required Baby baby}) async {
    await baby.save();
  }
}
