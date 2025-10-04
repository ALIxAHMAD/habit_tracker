import 'package:equatable/equatable.dart';

import 'package:habit_tracker/features/habitTracker/domain/entities/task.dart';

class TaskState extends Equatable {
  final TasksList tasks;
  final String errorMessage;
  final DateTime currentDate;
  const TaskState({
    required this.tasks,
    required this.errorMessage,
    required this.currentDate,
  });

  TaskState copyWith({
    TasksList? tasks,
    String? errorMessage,
    DateTime? currentDate,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage ?? this.errorMessage,
      currentDate: currentDate ?? this.currentDate,
    );
  }

  factory TaskState.initial() {
    return TaskState(
      currentDate: DateTime.now(),
      errorMessage: "",
      tasks: TasksList([]),
    );
  }

  List<Task> get done => tasks.tasks.where((t) => t.isDone).toList();
  List<Task> get todo => tasks.tasks.where((t) => !t.isDone).toList();
  @override
  List<Object?> get props => [tasks, errorMessage];
}
