import 'package:flutter/material.dart';
import 'package:hive_3d/data/hiveboxes.dart';
import 'package:hive_3d/models/person.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PersonHomeScreen extends StatefulWidget {
  PersonHomeScreen({super.key});

  @override
  State<PersonHomeScreen> createState() => _PersonHomeScreenState();
}

class _PersonHomeScreenState extends State<PersonHomeScreen> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();

  void add() async {
    personBox.add(
        Person(name: nameController.text, age: int.parse(ageController.text)));
    setState(() {});
  }

  void delete(int index) async {
    personBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
              ),
              TextField(
                controller: ageController,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: add,
                  child: const Text('Add'),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (_, index) {
                  var person = personBox.getAt(index) as Person;
                  return ListTile(
                    title: Text(person.name),
                    subtitle: Text(person.age.toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => delete(index),
                    ),
                  );
                },
                itemCount: personBox.length,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
