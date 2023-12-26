import 'package:bebek_takip/models/baby_models.dart';
import 'package:bebek_takip/screens/index_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();
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
