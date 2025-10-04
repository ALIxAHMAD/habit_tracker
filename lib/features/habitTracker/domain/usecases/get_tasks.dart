import 'package:dartz/dartz.dart';
import 'package:habit_tracker/core/util/result/failure.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/task.dart';
import 'package:habit_tracker/features/habitTracker/domain/repositories/repository.dart';

class GetTasksUseCase {
  final HabitRepository repository;

  GetTasksUseCase(this.repository);

  Future<Either<Failure, TasksList>> call(DateTime date) {
    return repository.getTasks(date);
  }
}
