import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 5,
      child: SizedBox(
        height: 50,
      ),
    );
  }
}
