import 'package:flutter/material.dart';
import 'package:hive_3d/data/hiveboxes.dart';
import 'package:hive_3d/models/person.dart';
import 'package:hive_3d/screens/home.dart';
import 'package:hive_3d/screens/personHome.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  personBox = await Hive.openBox<Person>('personBox');
  runApp(HiveApp());
}

class HiveApp extends StatelessWidget {
  const HiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PersonHomeScreen(),
    );
  }
}
