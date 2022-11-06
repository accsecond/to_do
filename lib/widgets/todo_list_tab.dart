import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/todo.dart';

import '../widgets/todo_card.dart';

class TodoListTab extends StatelessWidget {
  final ValueListenable<List<Todo>> valueListenable;

  const TodoListTab({
    Key? key,
    required this.valueListenable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: valueListenable,
        builder: (BuildContext builderContext, List<Todo> todos, _) {
          return todos.isNotEmpty
              ? ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return TodoCard(
                      todo: todos[index],
                      // Todo(
                      //   id: "1",
                      //   title: "titlee",
                      //   description: "description",
                      //   isCompleted: index % 2 == 0,
                      // ),
                      onTap: (todo) {
                        // todo.isCompleted = !todo.isCompleted;
                        // context.read<TodosProvider>().update(todo);
                      },
                      onDelete: (todo) {
                        // context.read<TodosProvider>().removeTodo(todo);
                      },
                      onEdit: (todo) {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     fullscreenDialog: true,
                        //     builder: (_) {
                        //       return ChangeNotifierProvider<TodosProvider>.value(
                        //         value: context.read<TodosProvider>(),
                        //         child: TodosFormScreen(
                        //           todo: todo,
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // );
                      },
                    );
                  },
                )
              : Container(
                  margin: const EdgeInsets.only(top: 30),
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
