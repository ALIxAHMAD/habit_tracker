import 'package:equatable/equatable.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/task_month_summary.dart';

class HabitMonthSummaryModel extends Equatable {
  final List<DateTime> doneDays;

  const HabitMonthSummaryModel({required this.doneDays});

  @override
  List<Object?> get props => [doneDays];

  HabitMonthSummary toEntity() {
    return HabitMonthSummary(doneDays: doneDays);
  }
}
