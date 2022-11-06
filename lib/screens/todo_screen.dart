import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/models/todo.dart';
import 'package:to_do/services/todo_db_service.dart';

class TodoScreen extends StatefulWidget {
  final Todo todo;
  // const TodoScreen({super.key});
  const TodoScreen({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? date;
  TimeOfDay? time;
  String? timeString;

  @override
  void initState() {
    titleController.text = widget.todo.title;
    descriptionController.text = widget.todo.description;
    date = widget.todo.dueTime;
    time = TimeOfDay.fromDateTime(date!);
    // timeString = time != null ? time!.format(context) : "Select a time";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        // FocusScopeNode currentFocus = FocusScope.of(context);
        // if (!currentFocus.hasPrimaryFocus) {
        //   currentFocus.unfocus();
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update Todo"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: titleController,
                      // initialValue: _title,
                      // initialValue: widget.todo.title,
                      validator: (value) =>
                          value!.isEmpty ? 'Title is required' : null,
                      // onChanged: (val) => _title = val,
                      onFieldSubmitted: (value) {
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
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      // initialValue: _description,
                      // initialValue: widget.todo.description,
                      validator: (value) => (value?.isEmpty ?? true)
                          ? 'Description is required'
                          : null,
                      maxLines: 4,
                      // onChanged: (val) => _description = val,
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
                      height: 15,
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
                                widget.todo.dueTime ?? DateTime.now(),
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
                          initialDate: widget.todo.dueTime ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        setState(() {
                          date = newDate ?? DateTime.now();
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
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
                              // timeString ?? "Select a time",
                              time != null
                                  ? time!.format(context)
                                  : "Select a time",
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

                            // timeString = time!.format(context);
                          }
                          time = newTime;
                          // timeString = time!.format(context);
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var dueTime = (date == null || time == null)
                                ? DateTime.now().add(
                                    const Duration(minutes: 30),
                                  )
                                : DateTime(
                                    date!.year,
                                    date!.month,
                                    date!.day,
                                    time!.hour,
                                    time!.minute,
                                  );

                            var todo = Todo(
                              id: widget.todo.id,
                              title: titleController.text,
                              description: descriptionController.text,
                              isCompleted: widget.todo.isCompleted,
                              dueTime: dueTime,
                              // widget.todo.dueTime ??
                              //     DateTime.now().add(
                              //       const Duration(days: 1),
                              //     ),
                            );

                            // await todoDBService.addTodo(todo);
                            updateTodo(todo).then(
                              (value) => Navigator.of(context).pop(),
                            );

                            // addTask(task);

                          }
                        },
                        // onPressed: () async => _save(context),
                        child: Text("Update"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
