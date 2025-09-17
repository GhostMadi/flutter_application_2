import 'package:flutter/material.dart';
import 'package:flutter_application_2/provider/task_provider.dart';
import 'package:provider/provider.dart';

import '../../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: task.isDone,
      onChanged: (_) => context.read<TaskProvider>().toggle(task.id),
      title: Text(
        task.title,
        style: task.isDone
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      secondary: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () => context.read<TaskProvider>().remove(task.id),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
