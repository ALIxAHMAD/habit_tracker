import 'package:dartz/dartz.dart';
import 'package:habit_tracker/core/util/result/failure.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/habit.dart';
import 'package:habit_tracker/features/habitTracker/domain/repositories/repository.dart';

class GetHabitUseCase {
  final HabitRepository repository;

  GetHabitUseCase(this.repository);

  Future<Either<Failure, Habit>> call(String id) {
    return repository.getHabit(id);
  }
}
