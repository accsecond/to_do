import 'package:flutter/material.dart';
import 'package:to_do/models/todo.dart';
import 'package:to_do/services/todo_db_service.dart';

void sortTodosByDatetime(List<Todo> todos) {
  todos.sort((a, b) => a.dueTime!.compareTo(b.dueTime!));
}

Future<bool?> showConfirmationDialog(BuildContext context, String action) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Do you want to $action this?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Yes')),
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'))
        ],
      );
    },
  );
}

showAddTodoForm(BuildContext context) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var todoDBService = TodoDBService();

  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builderContext) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              10,
              10,
              10,
              MediaQuery.of(context).viewInsets.bottom,
              // 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 30,
                  child: Text(
                    "New Todo",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        validator: (value) {
                          // value!.trim().isEmpty
                          return value!.isEmpty ? "Title is required" : null;
                        },
                        onFieldSubmitted: (_) {
                          formKey.currentState!.validate();
                        },
                        decoration: InputDecoration(
                          hintText: "Enter title",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.blueAccent,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: descriptionController,
                        validator: (value) {
                          // value!.trim().isEmpty
                          return value!.isEmpty
                              ? "Description is required"
                              : null;
                        },
                        onFieldSubmitted: (_) {
                          formKey.currentState!.validate();
                        },
                        decoration: InputDecoration(
                          hintText: "Enter description",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.blueAccent,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            // var task = Todo(
                            // date: selectedDate,
                            // title: _controller.text,
                            // category: selectedCategory ?? "Do Soon",
                            // );
                            // var todo = Todo(title: title, description: description, isCompleted: isCompleted,);
                            var todo = Todo(
                              title: titleController.text,
                              description: descriptionController.text,
                              isCompleted: false,
                              dueTime: DateTime.now().add(
                                const Duration(days: 1),
                              ),
                            );

                            await todoDBService.addTodo(todo);
                            // print(todo);

                            // addTask(task);
                            Navigator.pop(builderContext);
                          }
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            // color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Row(
                //   children: [
                //     Expanded(
                //         child: GestureDetector(
                //       child: Container(
                //         height: 50,
                //         margin: const EdgeInsets.all(10),
                //         decoration: BoxDecoration(
                //           color: Colors.blue,
                //           borderRadius:
                //               const BorderRadius.all(Radius.circular(10)),
                //           boxShadow: [
                //             BoxShadow(
                //               blurRadius: 2,
                //               color: Colors.grey.shade500,
                //             )
                //           ],
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             Text(
                //               DateFormat('dd-MM-yyyy').format(selectedDate),
                //               style: const TextStyle(
                //                 color: backgroundColor,
                //                 fontSize: 16,
                //               ),
                //             ),
                //             const Icon(
                //               Icons.calendar_month_outlined,
                //               color: backgroundColor,
                //               size: 30,
                //             ),
                //           ],
                //         ),
                //       ),
                //       onTap: () async {
                //         DateTime? newDate = await showDatePicker(
                //           context: context,
                //           initialDate: DateTime.now(),
                //           firstDate: DateTime.now(),
                //           lastDate: DateTime(2100),
                //         );
                //         if (newDate == null) {
                //           return;
                //         } else {
                //           setState(() {
                //             selectedDate = newDate;
                //           });
                //         }
                //       },
                //     )),
                //   ],
                // ),
                // const SizedBox(height: 30),

                // ElevatedButton(
                //   onPressed: () {
                //     if (formKey.currentState!.validate()) {
                //       // var task = Todo(
                //       // date: selectedDate,
                //       // title: _controller.text,
                //       // category: selectedCategory ?? "Do Soon",
                //       // );
                //       // var todo = Todo(title: title, description: description, isCompleted: isCompleted,);
                //       var todo = Todo(
                //         title: titleController.text,
                //         description: descriptionController.text,
                //         isCompleted: false,
                //       );

                //       // addTask(task);
                //       Navigator.pop(builderContext);
                //     }
                //   },
                //   child: const Text(
                //     "Save",
                //     style: TextStyle(
                //       // color: Colors.blue,
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        });
      });
}
