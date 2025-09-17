import 'package:flutter/material.dart';
import 'package:flutter_application_2/presentation/widgets/filter_bar.dart';
import 'package:flutter_application_2/presentation/widgets/task_item.dart';
import 'package:flutter_application_2/provider/task_provider.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _add(BuildContext context) {
    final text = _controller.text.trim();
    context.read<TaskProvider>().addTask(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: false, title: const Text('Заметки')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Новая задача...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _add(context),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: () => _add(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Добавить'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const FilterBar(),
              const Divider(height: 24),
              Expanded(
                child: Consumer<TaskProvider>(
                  builder: (context, state, _) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final items = state.visibleTasks;
                    if (items.isEmpty) {
                      return const Center(child: Text('Пока нет задач'));
                    }
                    return ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, i) => TaskItem(task: items[i]),
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
