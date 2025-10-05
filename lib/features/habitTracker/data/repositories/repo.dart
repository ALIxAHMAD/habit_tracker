import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/core/util/result/failure.dart';
import 'package:habit_tracker/core/util/result/success.dart';
import 'package:habit_tracker/features/habitTracker/data/datasources/data_source.dart';
import 'package:habit_tracker/features/habitTracker/data/datasources/drift/drift_data_source.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/task.dart';
import 'package:habit_tracker/features/habitTracker/domain/repositories/repository.dart';

final habitRepositoryProvider = Provider<HabitRepository>(
  (ref) => HabitRepositoryImplementation(
    dataSource: ref.watch(dataSourceProvider),
  ),
);

class HabitRepositoryImplementation implements HabitRepository {
  final HabitDataSource dataSource;

  HabitRepositoryImplementation({required this.dataSource});
  @override
  Future<Either<Failure, String>> addHabit(String title) async {
    try {
      final result = await dataSource.addHabit(title);
      return Right(result);
    } catch (e) {
      return Left(LocalDataSourceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteHabit(String id) async {
    try {
      await dataSource.deleteHabit(id);
      return Right(Success());
    } catch (e) {
      return Left(LocalDataSourceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TasksList>> getTasks(DateTime date) async {
    try {
      final result = await dataSource.getTasks(date);
      return Right(result.toEntity());
    } catch (e) {
      return Left(LocalDataSourceFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> toggleTask(String id, DateTime date) async {
    try {
      await dataSource.toggleTask(id, date);
      return Right(Success());
    } catch (e) {
      return Left(LocalDataSourceFailure(e.toString()));
    }
  }
}
