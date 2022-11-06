import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/screens/todo_screen.dart';
import 'package:to_do/services/todo_db_service.dart';

import '../models/todo.dart';
import '../utils/utils.dart';
import '../widgets/todo_card.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // late Box<Todo> box;
  // late List<Todo> todos;
  // var service = TodoService();

  // @override
  // void initState() async {
  //   box = Hive.box<Todo>("test");
  //   todos = await service.getTodos();
  //   print(todos);
  //   super.initState();
  // }
  int tabIndex = 0;

  @override
  void dispose() {
    Hive.close();
    // Hive.box<Todo>("todos").close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusManager.instance.primaryFocus?.unfocus();
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
          elevation: 0.0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const TodoScreen(),
            //   ),
            // );
            showAddTodoForm(context);
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(bottom: 10),
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
                  onChanged: (text) {},
                ),
              ),
              DefaultTabController(
                length: 3,
                child: TabBar(
                  onTap: (index) {
                    setState(() {
                      tabIndex = index;
                    });
                  },
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  tabs: const [
                    Tab(
                      text: "All",
                    ),
                    Tab(
                      text: "Today",
                    ),
                    Tab(
                      text: "Upcoming",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return TodoCard(
                      todo: Todo(
                        id: "1",
                        title: "titlee",
                        description: "description",
                        isCompleted: index % 2 == 0,
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
      ),
    );
  }
}
