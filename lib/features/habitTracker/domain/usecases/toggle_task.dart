import 'package:dartz/dartz.dart';
import 'package:habit_tracker/core/util/result/failure.dart';
import 'package:habit_tracker/core/util/result/success.dart';
import 'package:habit_tracker/features/habitTracker/domain/repositories/repository.dart';

class ToggleTaskUseCase {
  final HabitRepository repository;

  ToggleTaskUseCase(this.repository);

  Future<Either<Failure, Success>> call(String id) {
    return repository.toggleTask(id);
  }
}
