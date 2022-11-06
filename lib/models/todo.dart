import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  DateTime? dueTime;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.dueTime,
  });

  @override
  String toString() =>
      "{id:$id, title:$title, description:$description, complete:$isCompleted}";
}
