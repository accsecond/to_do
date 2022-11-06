import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/models/todo.dart';

// class TodoDBService  {
class TodoDBService extends ChangeNotifier {
  // late Box<Todo> box;

  // Future<void> init() async {
  //   // Hive.registerAdapter(TodoAdapter());
  //   // box = await Hive.openBox<Todo>("todos");
  //   // box = Hive.box<Todo>("todos");
  //   box = Hive.box<Todo>("test");
  // }

  ValueNotifier<List<Todo>> allTodosNotifier = ValueNotifier([]);
  ValueNotifier<List<Todo>> todayTodosNotifier = ValueNotifier([]);
  ValueNotifier<List<Todo>> upcomingTodosNotifier = ValueNotifier([]);

  Future<List<Todo>> getTodos() async {
    // final box = Hive.box<Todo>("todos");
    final box = Hive.box<Todo>("test");
    var todos = await Future.value(List<Todo>.from(box.values));
    allTodosNotifier.notifyListeners();
    todayTodosNotifier.notifyListeners();
    upcomingTodosNotifier.notifyListeners();
    return todos;
  }

  Future<void> addTodo(Todo todo) async {
    // final box = Hive.box<Todo>("todos");
    final box = Hive.box<Todo>("test");
    // await box.put(todo.id, todo);
    // await box.add(todo);
    int id = await box.add(todo);
    await box.put(id, todo);
  }

  Future<void> deleteTodo(Todo todo) async {
    // final box = Hive.box<Todo>("todos");
    final box = Hive.box<Todo>("test");
    await box.delete(todo.id);
  }

  Future<void> deleteAllTodos() async {
    // final box = Hive.box<Todo>("todos");
    final box = Hive.box<Todo>("test");
    await box.clear();
  }

  Future<void> updateTodo(Todo todo) async {
    // final box = Hive.box<Todo>("todos");
    final box = Hive.box<Todo>("test");
    await box.put(todo.id, todo);
  }
}
