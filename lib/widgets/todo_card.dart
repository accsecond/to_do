import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/todo.dart';
import '../utils/utils.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  final Todo _todo;
  final Function(Todo) onTap;
  final Function(Todo) onDelete;
  final Function(Todo) onEdit;

  const TodoCard(
      {Key? key,
      required Todo todo,
      required this.onTap,
      required this.onDelete,
      required this.onEdit})
      : _todo = todo,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    const notCompletedIconColor = Color(0xFF4ED9D6);
    final completedIconColor = notCompletedIconColor.withAlpha(100);
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        dismissible: DismissiblePane(
          key: UniqueKey(),
          onDismissed: () {
            onDelete(_todo);
          },
          closeOnCancel: true,
          // confirmDismiss: () async {
          //   // var isConfirmed = await _showConfirmationDialog(context, "delete") ?? false;
          //   var isConfirmed =
          //       await showConfirmationDialog(context, "delete") ?? false;
          //   return isConfirmed;
          // },
        ),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) async {
              // bool isConfirmed = await _showConfirmationDialog(context, "delete") ?? false;
              bool isConfirmed =
                  await showConfirmationDialog(context, "delete") ?? false;
              print(isConfirmed);
              if (isConfirmed == true) {
                onDelete(_todo);
              }
            },
            backgroundColor: const Color(0xFFFE4A69),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Delete",
            borderRadius: BorderRadius.circular(15),
            // borderRadius: ,
          ),
        ],
      ),
      child: Container(
        // padding: const EdgeInsets.all(0.0),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2,
          child: ListTile(
            // tileColor: Colors.amber,
            title: Text(
              _todo.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                decoration: _todo.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: _todo.isCompleted ? Colors.grey : Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              _todo.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                decoration: _todo.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: _todo.isCompleted ? Colors.grey : Colors.black,
              ),
            ),
            leading: IconButton(
              icon: _todo.isCompleted
                  ? Icon(
                      Icons.check_circle,
                      color: completedIconColor,
                    )
                  : const Icon(
                      Icons.circle_outlined,
                      color: notCompletedIconColor,
                    ),
              onPressed: () {
                onTap(_todo);
              },
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.yMMMEd().format(_todo.dueTime!),
                  // maxLines: 2,
                  // "Sun, Nov 7 2022",
                  style: TextStyle(
                    decoration: _todo.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontStyle: FontStyle.italic,
                    fontSize: 13,
                  ),
                ),
                Text(
                  DateFormat.Hm().format(_todo.dueTime!),
                  // maxLines: 2,
                  // "Sun, Nov 7 2022",
                  style: TextStyle(
                    decoration: _todo.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontStyle: FontStyle.italic,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            onTap: () {
              onEdit(_todo);
            },
          ),
        ),
      ),
      // ),
    );
  }

  // Future<bool?> _showConfirmationDialog(BuildContext context, String action) {
  //   return showDialog<bool>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Do you want to $action this?'),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context, true);
  //               },
  //               child: const Text('Yes')),
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context, false);
  //               },
  //               child: const Text('No'))
  //         ],
  //       );
  //     },
  //   );
  // }
}
