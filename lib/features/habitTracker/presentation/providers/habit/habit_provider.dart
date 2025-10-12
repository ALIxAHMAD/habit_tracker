import 'package:habit_tracker/features/habitTracker/data/repositories/repo.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/habit.dart';
import 'package:habit_tracker/features/habitTracker/domain/repositories/repository.dart';
import 'package:habit_tracker/features/habitTracker/domain/usecases/delete_habit.dart';
import 'package:habit_tracker/features/habitTracker/domain/usecases/get_habit.dart';
import 'package:habit_tracker/features/habitTracker/domain/usecases/get_month_summary.dart';
import 'package:habit_tracker/features/habitTracker/domain/usecases/update_habit.dart';
import 'package:habit_tracker/features/habitTracker/presentation/providers/habit/habit_state.dart';
import 'package:hooks_riverpod/legacy.dart';

final habitProvider = StateNotifierProvider<HabitNotifier, HabitState>(
  (ref) => HabitNotifier(
    repository: ref.watch(habitRepositoryProvider),
  ),
);

class HabitNotifier extends StateNotifier<HabitState> {
  final GetHabitUseCase _getHabitUseCase;
  final GetMonthSummaryUseCase _getMonthSummaryUseCase;
  final UpdateHabitUseCase _updateHabitUseCase;
  final DeleteHabitUseCase _deleteHabitUseCase;

  HabitNotifier({required HabitRepository repository})
    : _getHabitUseCase = GetHabitUseCase(repository),
      _deleteHabitUseCase = DeleteHabitUseCase(repository),
      _getMonthSummaryUseCase = GetMonthSummaryUseCase(repository),
      _updateHabitUseCase = UpdateHabitUseCase(repository),
      super(HabitState.initial());

  Future<void> init(String id) async {
    final result = await _getHabitUseCase(id);
    result.fold(
      (l) {
        state = state.copyWith(habitDeleted: true);
      },
      (r) {
        state = state.copyWith(habit: r, habitDeleted: false);
        getMonthSummary();
      },
    );
  }

  Future<void> getMonthSummary() async {
    final today = DateTime.now();
    final result = await _getMonthSummaryUseCase(state.habit.id, today);
    result.fold(
      (l) {
        state = state.copyWith(errorMessage: l.message);
      },
      (r) {
        state = state.copyWith(summary: r);
      },
    );
  }

  Future<void> deleteHabit() async {
    final result = await _deleteHabitUseCase(state.habit.id);
    result.fold(
      (l) {
        state = state.copyWith(errorMessage: l.message);
      },
      (r) {
        state = state.copyWith(habitDeleted: true);
      },
    );
  }

  Future<void> updateHabit(String title) async {
    final result = await _updateHabitUseCase(state.habit.id, title);
    result.fold(
      (l) {
        state = state.copyWith(errorMessage: l.message);
      },
      (r) {
        state = state.copyWith(
          habit: Habit(title: title, id: state.habit.id),
        );
      },
    );
  }

  void clearError() async {
    state = state.copyWith(errorMessage: "");
  }

  void flush() {
    state = HabitState.initial();
  }
}
