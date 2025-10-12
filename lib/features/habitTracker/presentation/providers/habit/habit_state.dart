import 'package:equatable/equatable.dart';

import 'package:habit_tracker/features/habitTracker/domain/entities/habit.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/task_month_summary.dart';

class HabitState extends Equatable {
  final Habit habit;
  final HabitMonthSummary summary;
  final bool habitDeleted;
  final String errorMessage;

  const HabitState({
    required this.habit,
    required this.summary,
    required this.habitDeleted,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [habit, summary, habitDeleted, errorMessage];

  factory HabitState.initial() {
    return HabitState(
      habitDeleted: false,
      habit: Habit(title: "", id: ""),
      summary: HabitMonthSummary(doneDays: []),
      errorMessage: "",
    );
  }

  HabitState copyWith({
    Habit? habit,
    HabitMonthSummary? summary,
    bool? habitDeleted,
    String? errorMessage,
  }) {
    return HabitState(
      habit: habit ?? this.habit,
      summary: summary ?? this.summary,
      habitDeleted: habitDeleted ?? this.habitDeleted,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
