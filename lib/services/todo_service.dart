import 'package:hive/hive.dart';
import 'package:to_do/models/todo.dart';

class TodoService {
  late Box<Todo> box;

  Future<void> init() async {
    Hive.registerAdapter(TodoAdapter());
    box = await Hive.openBox<Todo>("todos");
    // box = Hive.box<Todo>("todos");
  }

  Future<List<Todo>> getTodos() async {
    var todos = await Future.value(List<Todo>.from(box.values));
    return todos;
  }

  Future<void> addTodo(Todo todo) async {
    await box.put(todo.id, todo);
    // await box.add(todo);
  }

  Future<void> deleteTodo(Todo todo) async {
    await box.delete(todo.id);
  }

  Future<void> deleteAllTodos() async {
    await box.clear();
  }

  Future<void> updateTodo(Todo todo) async {
    await box.put(todo.id, todo);
  }
}
