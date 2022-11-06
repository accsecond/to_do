import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/models/todo.dart';
import 'package:to_do/utils/utils.dart';

// class TodoDBService  {
class TodoDBService extends ChangeNotifier {
  // late Box<Todo> box;

  // Future<void> init() async {
  //   // Hive.registerAdapter(TodoAdapter());
  //   // box = await Hive.openBox<Todo>("todos");
  //   // box = Hive.box<Todo>("todos");
  //   box = Hive.box<Todo>("test");
  // }

  // TodoDBService() {
  //   box = Hive.box<Todo>("test");
  // }

  ValueNotifier<List<Todo>> allTodosNotifier = ValueNotifier([]);
  ValueNotifier<List<Todo>> todayTodosNotifier = ValueNotifier([]);
  ValueNotifier<List<Todo>> upcomingTodosNotifier = ValueNotifier([]);

  // Future<List<Todo>> getTodos() async {
  Future<void> getTodos() async {
    // final box = Hive.box<Todo>("todos");
    final box = Hive.box<Todo>("test");
    var todos = await Future.value(List<Todo>.from(box.values));

    allTodosNotifier.value.clear();
    todayTodosNotifier.value.clear();
    // upcomingTodosNotifier.value.clear();

    allTodosNotifier.value = List<Todo>.from(todos);

    final now = DateTime.now();
    for (var todo in todos) {
      final dueTime = todo.dueTime!;
      if (DateTime(now.year, now.month, now.day) ==
          DateTime(dueTime.year, dueTime.month, dueTime.day)) {
        todayTodosNotifier.value.add(todo);
      }
    }

    sortTodosByDatetime(allTodosNotifier.value);
    sortTodosByDatetime(todayTodosNotifier.value);
    // sortTodosByDatetime(upcomingTodosNotifier.value);

    allTodosNotifier.notifyListeners();
    todayTodosNotifier.notifyListeners();
    upcomingTodosNotifier.notifyListeners();

    // return todos;
  }

  Future<void> addTodo(Todo todo) async {
    // final box = Hive.box<Todo>("todos");
    final box = Hive.box<Todo>("test");
    // await box.put(todo.id, todo);
    // await box.add(todo);
    int id = await box.add(todo);
    await box.put(id.toString(), todo);

    print("$id $todo");

    getTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    // final box = Hive.box<Todo>("todos");
    final box = Hive.box<Todo>("test");
    await box.delete(todo.id);

    getTodos();
  }

  Future<void> deleteAllTodos() async {
    // final box = Hive.box<Todo>("todos");
    final box = Hive.box<Todo>("test");
    await box.clear();

    getTodos();
    // await box.deleteFromDisk();
  }

  Future<void> updateTodo(Todo todo) async {
    // final box = Hive.box<Todo>("todos");
    final box = Hive.box<Todo>("test");
    await box.put(todo.id, todo);

    getTodos();
  }
}
