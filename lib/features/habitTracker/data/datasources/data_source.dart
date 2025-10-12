import 'package:habit_tracker/features/habitTracker/data/models/habit.dart';
import 'package:habit_tracker/features/habitTracker/data/models/habit_month_summary.dart';
import 'package:habit_tracker/features/habitTracker/data/models/task.dart';

abstract class HabitDataSource {
  Future<String> addHabit(String title);
  Future<void> deleteHabit(String id);
  Future<void> toggleTask(String id, DateTime date);
  Future<TasksListModel> getTasks(DateTime date);
  Future<HabitMonthSummaryModel> getMonthSummary(String id, DateTime date);
  Future<HabitModel> getHabit(String id);
  Future<void> updateHabit(String id, String title);
}
