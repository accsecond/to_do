// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/services/local_notification_service.dart';
// import 'package:path_provider/path_provider.dart';
import './models/todo.dart';
import 'package:to_do/screens/todo_list_screen.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalNotificationService().initNotification();

  // var path = Directory.current.path;
  // Hive.init(path);

  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());

  // Hive
  // ..init((await getApplicationDocumentsDirectory()).path)
  // ..registerAdapter(TodoAdapter());

  await Hive.openBox<Todo>("todos");
  // var box = await Hive.openBox<Todo>("todos");
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
        primarySwatch: Colors.blueGrey,
        // backgroundColor: Colors.grey,
        // primaryColor: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: TodoListScreen(),
    );
  }
}
