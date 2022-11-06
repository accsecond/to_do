import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/models/todo.dart';
import 'package:to_do/services/todo_db_service.dart';

void sortTodosByDatetime(List<Todo> todos) {
  todos.sort((a, b) => a.dueTime!.compareTo(b.dueTime!));
}

List<Todo> filterTodosBySearch(List<Todo> todos, String? search) {
  if (search == null || search.isEmpty || search.trim().isEmpty) {
    return List<Todo>.from(todos);
  } else {
    return todos
        .where(
          (element) =>
              element.title.toLowerCase().contains(search) ||
              element.description.toLowerCase().contains(search),
        )
        .toList();
  }
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
  // var todoDBService = TodoDBService();
  DateTime? date = DateTime.now();
  TimeOfDay? time;
  String? timeString;
  // var now = DateTime.now();

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
                SizedBox(
                  height: 10,
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
                          labelText: "Title",
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
                        maxLines: 4,
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
                          labelText: "Description",
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
                      GestureDetector(
                        child: Container(
                          height: 50,
                          // margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat.yMMMEd().format(
                                  date ?? DateTime.now(),
                                ),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );

                          setState(() {
                            date = newDate ?? DateTime.now();
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        child: Container(
                          height: 50,
                          // margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                timeString ?? "Select a time",
                                // time != null
                                //     ? "${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}"
                                //     : "${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              const Icon(
                                Icons.schedule,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          TimeOfDay? newTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          setState(() {
                            // time = newTime ??
                            //     TimeOfDay.fromDateTime();

                            if (newTime == null) {
                              if (DateTime.now()
                                      .add(
                                        const Duration(minutes: 30),
                                      )
                                      .day >
                                  DateTime.now().day) {
                                date = date != null
                                    ? date!.add(
                                        const Duration(days: 1),
                                      )
                                    : DateTime.now().add(
                                        const Duration(days: 1),
                                      );
                                time = TimeOfDay.fromDateTime(
                                  DateTime.now().add(
                                    const Duration(minutes: 30),
                                  ),
                                );
                              } else {
                                time = TimeOfDay.fromDateTime(
                                  DateTime.now().add(
                                    const Duration(minutes: 30),
                                  ),
                                );
                              }

                              timeString = time!.format(context);
                            }
                            time = newTime;
                            timeString = time!.format(context);
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            // print(time != null
                            //     ? time!.format(context)
                            //     : "not choose");

                            // print(
                            //   DateFormat.yMMMEd().format(
                            //     date ?? DateTime.now(),
                            //   ),
                            // );
                            var todo = Todo(
                              id: DateTime.now().toIso8601String(),
                              title: titleController.text,
                              description: descriptionController.text,
                              isCompleted: false,
                              dueTime: (date == null || time == null)
                                  ? DateTime.now().add(
                                      const Duration(minutes: 30),
                                    )
                                  : DateTime(
                                      date!.year,
                                      date!.month,
                                      date!.day,
                                      time!.hour,
                                      time!.minute,
                                    ),
                            );

                            // await todoDBService.addTodo(todo);
                            addTodo(todo).then(
                              (value) => Navigator.pop(builderContext),
                            );

                            // addTask(task);

                          }
                        },
                        child: const Text(
                          "Add todo",
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
              ],
            ),
          );
        });
      });
}
