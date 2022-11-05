import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/screens/todo_screen.dart';

import '../models/todo.dart';
import '../widgets/todo_card.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void dispose() {
    Hive.close();
    // Hive.box<Todo>("todos").close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Todo List",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
        ),
        backgroundColor: Colors.transparent,
        // elevation: 1,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const TodoScreen(),
          //   ),
          // );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                // color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 20,
                    minWidth: 25,
                  ),
                  border: InputBorder.none,
                  hintText: "Search todos",
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TodoCard(
                    todo: Todo(
                      id: "1",
                      title: "title",
                      description: "description",
                      isCompleted: false,
                    ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
