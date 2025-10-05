import 'package:habit_tracker/features/habitTracker/data/datasources/drift/db/app_database.dart';
import 'package:habit_tracker/features/habitTracker/data/models/task.dart';

extension HabitRowMapper on Habit {
  TaskDataModel toModel({bool isDone = false}) {
    return TaskDataModel(
      id: id,
      title: title,
      isDone: isDone,
    );
  }
}
