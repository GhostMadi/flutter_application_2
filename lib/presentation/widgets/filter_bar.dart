import 'package:flutter/material.dart';
import 'package:flutter_application_2/provider/task_provider.dart';
import 'package:provider/provider.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  String _label(TaskFilter f) => switch (f) {
    TaskFilter.all => 'Все',
    TaskFilter.active => 'Невыполненные',
    TaskFilter.completed => 'Выполненные',
  };

  @override
  Widget build(BuildContext context) {
    return Selector<TaskProvider, TaskFilter>(
      selector: (_, p) => p.filter,
      builder: (context, filter, _) {
        return Wrap(
          spacing: 8,
          children: TaskFilter.values.map((f) {
            final selected = filter == f;
            return ChoiceChip(
              label: Text(_label(f)),
              selected: selected,
              onSelected: (_) => context.read<TaskProvider>().setFilter(f),
            );
          }).toList(),
        );
      },
    );
  }
}
