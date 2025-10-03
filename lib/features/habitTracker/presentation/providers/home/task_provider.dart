import 'package:flutter_riverpod/legacy.dart';
import 'package:habit_tracker/features/habitTracker/presentation/providers/home/mock_data.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier()
    : super([
        Task(id: "1", title: "Go to gym", isDone: false),
        Task(id: "2", title: "Read 20 pages", isDone: false),
        Task(id: "3", title: "Meditate", isDone: false),
      ]);

  void toggleTask(Task task) {
    state = [
      for (final t in state)
        if (t.id == task.id) t.copyWith(isDone: !t.isDone) else t,
    ];
  }

  List<Task> get done => state.where((t) => t.isDone).toList();
  List<Task> get todo => state.where((t) => !t.isDone).toList();
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>(
  (ref) => TaskNotifier(),
);
