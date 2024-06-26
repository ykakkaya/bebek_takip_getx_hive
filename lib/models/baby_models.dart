import 'package:hive/hive.dart';

part 'baby_models.g.dart';

@HiveType(typeId: 1)
class Baby extends HiveObject {
  @HiveField(0)
  DateTime time;
  @HiveField(1)
  String? note;
  @HiveField(2)
  double weight;
  @HiveField(3)
  double height;
  @HiveField(4)
  double head;

  Baby({
    required this.time,
    this.note,
    required this.weight,
    required this.height,
    required this.head,
  });
}
