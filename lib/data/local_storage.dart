import 'package:bebek_takip/models/baby_models.dart';

abstract class LocalStorage {
  Future<void> addBaby({required Baby baby});

  Future<List<Baby>> getAllBaby();
  Future<void> deleteBaby({required Baby baby});
  Future<void> updateBaby({required Baby baby});
}
