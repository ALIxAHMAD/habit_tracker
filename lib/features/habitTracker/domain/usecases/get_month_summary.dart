import 'package:dartz/dartz.dart';
import 'package:habit_tracker/core/util/result/failure.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/task_month_summary.dart';
import 'package:habit_tracker/features/habitTracker/domain/repositories/repository.dart';

class GetMonthSummaryUseCase {
  final HabitRepository repository;

  GetMonthSummaryUseCase(this.repository);

  Future<Either<Failure, HabitMonthSummary>> call(
    String id,
    DateTime date,
  ) {
    return repository.getMonthSummary(id, date);
  }
}
