import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskRepository {
  static const _storageKey = 'tasks_v1';

  final SharedPreferences pref;
  TaskRepository(this.pref);

  Future<List<Task>> loadTasks() async {
    final raw = pref.getString(_storageKey);
    if (raw == null || raw.isEmpty) return [];
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return list.map(Task.fromJson).toList();
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final list = tasks.map((t) => t.toJson()).toList();
    await pref.setString(_storageKey, jsonEncode(list));
  }
}
