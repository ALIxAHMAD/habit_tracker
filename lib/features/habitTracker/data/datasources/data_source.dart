import 'package:habit_tracker/features/habitTracker/data/models/task.dart';

abstract class HabitDataSource {
  Future<String> addHabit(String title);
  Future<void> deleteHabit(String id);
  Future<void> toggleTask(String id, DateTime date);
  Future<TasksListModel> getTasks(DateTime date);
}
