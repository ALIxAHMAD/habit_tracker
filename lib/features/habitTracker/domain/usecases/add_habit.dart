import 'package:dartz/dartz.dart';
import 'package:habit_tracker/core/util/result/failure.dart';
import 'package:habit_tracker/features/habitTracker/domain/repositories/repository.dart';

class AddHabitUseCase {
  final HabitRepository repository;

  AddHabitUseCase(this.repository);

  Future<Either<Failure, String>> call(String id) {
    return repository.addHabit(id);
  }
}
