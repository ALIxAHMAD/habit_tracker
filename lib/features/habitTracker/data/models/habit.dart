import 'package:equatable/equatable.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/habit.dart';

class HabitModel extends Equatable {
  final String title;
  final String id;

  const HabitModel({
    required this.title,
    required this.id,
  });

  Habit toEntity() {
    return Habit(
      title: title,
      id: id,
    );
  }

  @override
  List<Object?> get props => [title, id];
}
