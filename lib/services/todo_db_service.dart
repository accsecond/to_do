import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/models/todo.dart';
import 'package:to_do/utils/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

// class TodoDBService  {
// class TodoDBService extends ChangeNotifier {
//   // late Box<Todo> box;

//   // Future<void> init() async {
//   //   // Hive.registerAdapter(TodoAdapter());
//   //   // box = await Hive.openBox<Todo>("todos");
//   //   // box = Hive.box<Todo>("todos");
//   //   box = Hive.box<Todo>("test");
//   // }

//   // TodoDBService() {
//   //   box = Hive.box<Todo>("test");
//   // }

ValueNotifier<List<Todo>> allTodosNotifier = ValueNotifier([]);
ValueNotifier<List<Todo>> todayTodosNotifier = ValueNotifier([]);
ValueNotifier<List<Todo>> upcomingTodosNotifier = ValueNotifier([]);
// ValueNotifier<String?> search = ValueNotifier("");

// Future<List<Todo>> getTodos() async {
Future<void> getTodos() async {
  // final box = Hive.box<Todo>("todos");
  final box = Hive.box<Todo>("testt");
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

  // filterTodosBySearch(allTodosNotifier.value, search.value);

  sortTodosByDatetime(allTodosNotifier.value);
  sortTodosByDatetime(todayTodosNotifier.value);
  // sortTodosByDatetime(upcomingTodosNotifier.value);

  allTodosNotifier.notifyListeners();
  todayTodosNotifier.notifyListeners();
  upcomingTodosNotifier.notifyListeners();

  // return todos;
}

Todo getTodo(String? id) {
  var todo = allTodosNotifier.value.firstWhere((element) => element.id == id);
  return todo;
}

Future<void> addTodo(Todo todo) async {
  // final box = Hive.box<Todo>("todos");
  final box = Hive.box<Todo>("testt");
  // await box.put(todo.id, todo);
  // await box.add(todo);
  // int id = await box.add(todo);
  // todo.id = id.toString();
  await box.put(
    todo.id,
    todo,
  );

  print("$todo.id $todo");

  await getTodos();
}

Future<void> deleteTodo(Todo todo) async {
  // final box = Hive.box<Todo>("todos");
  final box = Hive.box<Todo>("testt");
  await box.delete(todo.id);

  await getTodos();
}

Future<void> deleteAllTodos() async {
  // final box = Hive.box<Todo>("todos");
  final box = Hive.box<Todo>("testt");
  await box.clear();

  await getTodos();
  // await box.deleteFromDisk();
}

Future<void> updateTodo(Todo todo) async {
  // final box = Hive.box<Todo>("todos");
  final box = Hive.box<Todo>("testt");
  // await deleteTodo(todo);

  // await box.put(
  //   todo.id,
  //   todo,
  // );
  await box.put(
    todo.id,
    todo,
  );

  await getTodos();
}
// }
