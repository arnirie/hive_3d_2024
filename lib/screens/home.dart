import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> todoList = [];

  var itemController = TextEditingController();

  Future<void> addTodo() async {
    var todo = await Hive.openBox('todos');
    todoList.add(itemController.text);
    todo.put('todoList', todoList);
    // todo.add(itemController.text);
    setState(() {});
  }

  Future<void> fetchTodos() async {
    var todo = await Hive.openBox('todos');
    // print(todo.length);
    // todoList.clear();
    // for (int i = 0; i < todo.length; i++) {
    //   todoList.add(todo.getAt(i));
    // }
    // print(todoList.length);
    if (todo.get('todoList') != null) {
      todoList = (todo.get('todoList') as List)
          .map((item) => item.toString())
          .toList();
    }
    print(todo.get('todoList'));
  }

  Future<void> delete(int index) async {
    todoList.removeAt(index);
    var todo = await Hive.openBox('todos');
    todo.put('todoList', todoList);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodos().then((value) {
      setState(() {});
    });
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
              const Text('TODO:'),
              TextField(
                controller: itemController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: addTodo,
                  child: const Text('Add'),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(todoList[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => delete(index),
                    ),
                  );
                },
                itemCount: todoList.length,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
