import 'package:dartz/dartz.dart';
import 'package:habit_tracker/core/util/result/failure.dart';
import 'package:habit_tracker/core/util/result/success.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/task.dart';

abstract class HabitRepository {
  Future<Either<Failure, String>> addHabit(String title);
  Future<Either<Failure, Success>> deleteHabit(String id);
  Future<Either<Failure, TasksList>> getTasks(DateTime date);
  Future<Either<Failure, Success>> toggleTask(String id);
}
