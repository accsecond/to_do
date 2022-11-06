import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do/screens/todo_screen.dart';
import 'package:to_do/services/todo_db_service.dart';
import 'package:to_do/utils/utils.dart';

import '../models/todo.dart';

import '../widgets/todo_card.dart';

class TodoListTab extends StatelessWidget {
  final ValueListenable<List<Todo>> valueListenable;
  final String? search;

  const TodoListTab({
    Key? key,
    required this.valueListenable,
    this.search,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: valueListenable,
        builder: (BuildContext builderContext, List<Todo> todos, _) {
          var filteredTodos = filterTodosBySearch(todos, search);
          // return todos.isNotEmpty
          return filteredTodos.isNotEmpty
              ? ListView.builder(
                  // itemCount: todos.length,
                  itemCount: filteredTodos.length,
                  itemBuilder: (context, index) {
                    return TodoCard(
                      todo: filteredTodos[index],
                      onTap: (todo) async {
                        final tempTodo = getTodo(todo.id);
                        tempTodo.isCompleted = !tempTodo.isCompleted;

                        await updateTodo(tempTodo);
                      },
                      onDelete: (todo) async {
                        await deleteTodo(todo);
                      },
                      onEdit: (todo) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => TodoScreen(todo: todo),
                          ),
                        );
                      },
                    );
                  },
                )
              : Container(
                  margin: const EdgeInsets.only(top: 10),
                  alignment: Alignment.topCenter,
                  child: const Text(
                    "There is currently no todo!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                );
        });
  }
}
