import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  final String id;
  final String title;
  final bool isDone;

  const Task({required this.id, required this.title, this.isDone = false});

  factory Task.create(String title) =>
      Task(id: const Uuid().v4(), title: title, isDone: false);

  Task copyWith({String? id, String? title, bool? isDone}) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    isDone: isDone ?? this.isDone,
  );

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  List<Object?> get props => [id, title, isDone];
}
