import 'package:equatable/equatable.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/task.dart';

class TaskDataModel extends Equatable {
  final String id;
  final String title;
  final bool isDone;

  const TaskDataModel({
    required this.id,
    required this.title,
    required this.isDone,
  });

  Task toEntity() => Task(
    id: id,
    title: title,
    isDone: isDone,
  );

  @override
  List<Object?> get props => [id, title, isDone];
}

class TasksListModel extends Equatable {
  final List<TaskDataModel> tasks;

  const TasksListModel({required this.tasks});

  TasksList toEntity() => TasksList(
    tasks: tasks.map((e) => e.toEntity()).toList(),
  );

  @override
  List<Object?> get props => [tasks];
}
