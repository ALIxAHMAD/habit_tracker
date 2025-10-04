import 'package:dartz/dartz.dart';
import 'package:habit_tracker/core/util/result/failure.dart';
import 'package:habit_tracker/core/util/result/success.dart';
import 'package:habit_tracker/features/habitTracker/domain/repositories/repository.dart';

class DeleteHabitUseCase {
  final HabitRepository repository;

  DeleteHabitUseCase(this.repository);

  Future<Either<Failure, Success>> call(String id) {
    return repository.deleteHabit(id);
  }
}
