import 'package:hive/hive.dart';

part 'person.g.dart'; //generated

@HiveType(typeId: 0)
class Person {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  Person({
    required this.name,
    required this.age,
  });
}
