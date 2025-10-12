import 'package:habit_tracker/core/util/helper/uuid.dart';
import 'package:habit_tracker/features/habitTracker/data/datasources/data_source.dart';
import 'package:habit_tracker/features/habitTracker/data/datasources/drift/db/app_database.dart';
import 'package:habit_tracker/features/habitTracker/data/models/habit.dart';
import 'package:habit_tracker/features/habitTracker/data/models/habit_month_summary.dart';
import 'package:habit_tracker/features/habitTracker/data/models/mapper.dart';
import 'package:habit_tracker/features/habitTracker/data/models/task.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:drift/drift.dart';

final dataSourceProvider = Provider<HabitDataSource>(
  (ref) => DriftDataSource(db: ref.watch(appDatabaseProvider)),
);

class DriftDataSource implements HabitDataSource {
  final AppDatabase db;

  DriftDataSource({required this.db});

  @override
  Future<String> addHabit(String title) async {
    final id = generateId();
    await db
        .into(db.habits)
        .insert(
          HabitsCompanion.insert(
            id: id,
            title: title,
          ),
        );
    return id;
  }

  @override
  Future<void> deleteHabit(String id) async {
    await (db.delete(db.habits)..where((t) => t.id.equals(id))).go();
    await (db.delete(
      db.completedTasks,
    )..where((t) => t.habitId.equals(id))).go();
  }

  @override
  Future<TasksListModel> getTasks(DateTime date) async {
    final day = DateTime(date.year, date.month, date.day);

    final habits = await db.select(db.habits).get();

    final completed = await (db.select(
      db.completedTasks,
    )..where((c) => c.date.equals(day))).get();

    final completedIds = completed.map((c) => c.habitId).toSet();

    final tasks = habits
        .map(
          (t) => t.toTaskModel(
            isDone: completedIds.contains(t.id),
          ),
        )
        .toList();
    return TasksListModel(tasks: tasks);
  }

  @override
  Future<void> toggleTask(String id, DateTime date) async {
    final day = DateTime(date.year, date.month, date.day);
    final existing =
        await (db.select(
              db.completedTasks,
            )..where(
              (t) => (t.habitId.equals(id) & t.date.equals(day)),
            ))
            .getSingleOrNull();
    if (existing == null) {
      await db
          .into(db.completedTasks)
          .insert(
            CompletedTasksCompanion.insert(
              date: day,
              habitId: id,
            ),
          );
    } else {
      await (db.delete(
        db.completedTasks,
      )..where((c) => (c.date.equals(day) & c.habitId.equals(id)))).go();
    }
  }

  @override
  Future<HabitMonthSummaryModel> getMonthSummary(
    String id,
    DateTime date,
  ) async {
    final completed =
        await (db.select(
              db.completedTasks,
            )..where(
              (t) =>
                  (t.date.year.equals(date.year) &
                  t.date.month.equals(date.month) &
                  t.habitId.equals(id)),
            ))
            .get();
    final dates = completed.map((t) => t.date).toList();
    return HabitMonthSummaryModel(doneDays: dates);
  }

  @override
  Future<HabitModel> getHabit(String id) async {
    final habit = await (db.select(
      db.habits,
    )..where((h) => h.id.equals(id))).getSingle();
    return habit.toModel();
  }

  @override
  Future<void> updateHabit(String id, String title) async {
    final entry = Habit(id: id, title: title);
    await db.update(db.habits).replace(entry);
  }
}
