import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_application_2/data/task_repository.dart';
import 'package:flutter_application_2/models/task.dart';

enum TaskFilter { all, completed, active }

class TaskProvider extends ChangeNotifier {
  final TaskRepository _repo;
  TaskProvider(this._repo);

  List<Task> _tasks = [];
  TaskFilter _filter = TaskFilter.all;
  bool _isLoading = true;

  // Getters
  List<Task> get tasks => _tasks;
  TaskFilter get filter => _filter;
  bool get isLoading => _isLoading;

  List<Task> get visibleTasks {
    switch (_filter) {
      case TaskFilter.completed:
        return _tasks.where((t) => t.isDone).toList();
      case TaskFilter.active:
        return _tasks.where((t) => !t.isDone).toList();
      case TaskFilter.all:
        return _tasks;
    }
  }

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();
    _tasks = await _repo.loadTasks();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    final text = title.trim();
    if (text.isEmpty) return;
    _tasks = List<Task>.from(_tasks)..add(Task.create(text));
    notifyListeners();
    await _repo.saveTasks(_tasks);
  }

  Future<void> toggle(String id) async {
    _tasks = _tasks
        .map((t) => t.id == id ? t.copyWith(isDone: !t.isDone) : t)
        .toList();
    notifyListeners();
    await _repo.saveTasks(_tasks);
  }

  Future<void> remove(String id) async {
    _tasks = _tasks.where((t) => t.id != id).toList();
    notifyListeners();
    await _repo.saveTasks(_tasks);
  }

  void setFilter(TaskFilter filter) {
    log(filter.name);
    _filter = filter;
    notifyListeners();
  }
}
