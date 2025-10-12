import 'package:dartz/dartz.dart';
import 'package:habit_tracker/core/util/result/failure.dart';
import 'package:habit_tracker/core/util/result/success.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/habit.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/task.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/task_month_summary.dart';

abstract class HabitRepository {
  Future<Either<Failure, String>> addHabit(String title);
  Future<Either<Failure, Success>> deleteHabit(String id);
  Future<Either<Failure, Habit>> getHabit(String id);
  Future<Either<Failure, Success>> updateHabit(String id, String title);
  Future<Either<Failure, HabitMonthSummary>> getMonthSummary(
    String id,
    DateTime date,
  );
  Future<Either<Failure, TasksList>> getTasks(DateTime date);
  Future<Either<Failure, Success>> toggleTask(String id, DateTime date);
}
