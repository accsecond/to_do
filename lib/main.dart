// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do/models/todo.dart';
import 'package:to_do/screens/todo_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // var path = Directory.current.path;
  // Hive.init(path);

  // Hive..initFlutter();
  // ..init((await getTemporaryDirectory()).path)
  // ..init((await getApplicationSupportDirectory()).path)
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());

  // Hive
  // ..init((await getApplicationDocumentsDirectory()).path)
  // ..registerAdapter(TodoAdapter());
  // var box = await Hive.openBox<Todo>('todos');
  // await Hive.openBox<Todo>("todos");
  var box = await Hive.openBox<Todo>("test");
  // box.clear();
  // box.deleteFromDisk();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // backgroundColor: Colors.grey,
        // primaryColor: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: TodoListScreen(),
    );
  }
}
