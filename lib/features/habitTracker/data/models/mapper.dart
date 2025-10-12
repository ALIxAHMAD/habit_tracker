import 'package:habit_tracker/features/habitTracker/data/datasources/drift/db/app_database.dart';
import 'package:habit_tracker/features/habitTracker/data/models/habit.dart';
import 'package:habit_tracker/features/habitTracker/data/models/task.dart';

extension HabitRowMapper on Habit {
  TaskDataModel toTaskModel({bool isDone = false}) {
    return TaskDataModel(
      id: id,
      title: title,
      isDone: isDone,
    );
  }

  HabitModel toModel() {
    return HabitModel(
      id: id,
      title: title,
    );
  }
}
