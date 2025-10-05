import 'package:flutter_riverpod/legacy.dart';
import 'package:habit_tracker/features/habitTracker/data/repositories/repo.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/task.dart';
import 'package:habit_tracker/features/habitTracker/domain/repositories/repository.dart';
import 'package:habit_tracker/features/habitTracker/domain/usecases/add_habit.dart';
import 'package:habit_tracker/features/habitTracker/domain/usecases/delete_habit.dart';
import 'package:habit_tracker/features/habitTracker/domain/usecases/get_tasks.dart';
import 'package:habit_tracker/features/habitTracker/domain/usecases/toggle_task.dart';
import 'package:habit_tracker/features/habitTracker/presentation/providers/home/task_state.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>(
  (ref) => TaskNotifier(
    repository: ref.watch(habitRepositoryProvider),
  ),
);

class TaskNotifier extends StateNotifier<TaskState> {
  final AddHabitUseCase _addHabitUseCase;
  final DeleteHabitUseCase _deleteHabitUseCase;
  final GetTasksUseCase _getTasksUseCase;
  final ToggleTaskUseCase _toggleTaskUseCase;
  TaskNotifier({required HabitRepository repository})
    : _addHabitUseCase = AddHabitUseCase(repository),
      _deleteHabitUseCase = DeleteHabitUseCase(repository),
      _getTasksUseCase = GetTasksUseCase(repository),
      _toggleTaskUseCase = ToggleTaskUseCase(repository),
      super(TaskState.initial());

  Future<void> toggleTask(String id) async {
    final result = await _toggleTaskUseCase(id, state.currentDate);
    result.fold(
      (l) {
        state = state.copyWith(errorMessage: l.message);
      },
      (r) {
        state = state.copyWith(
          tasks: TasksList(
            tasks: [
              for (final t in state.tasks.tasks)
                if (t.id == id) t.copyWith(isDone: !t.isDone) else t,
            ],
          ),
        );
      },
    );
  }

  Future<void> deleteHabit(String id) async {
    final result = await _deleteHabitUseCase(id);
    result.fold(
      (l) {
        state = state.copyWith(errorMessage: l.message);
      },
      (r) {
        state = state.copyWith(
          tasks: TasksList(
            tasks: [
              for (final t in state.tasks.tasks)
                if (t.id != id) t,
            ],
          ),
        );
      },
    );
  }

  Future<void> changeDate(DateTime newDate) async {
    state = state.copyWith(currentDate: newDate);
    await fetchTasksForCurrentDay();
  }

  Future<void> fetchTasksForCurrentDay() async {
    final result = await _getTasksUseCase(state.currentDate);
    result.fold(
      (l) {
        state = state.copyWith(errorMessage: l.message);
      },
      (r) {
        state = state.copyWith(tasks: r);
      },
    );
  }

  Future<void> addHabit(String title) async {
    final result = await _addHabitUseCase(title);
    result.fold(
      (l) {
        state = state.copyWith(errorMessage: l.message);
      },
      (r) {
        state = state.copyWith(
          tasks: TasksList(
            tasks: [
              ...state.tasks.tasks,
              Task(id: r, title: title, isDone: false),
            ],
          ),
        );
      },
    );
  }

  void clearError() async {
    state = state.copyWith(errorMessage: "");
  }
}
