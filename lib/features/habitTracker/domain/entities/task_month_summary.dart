import 'package:equatable/equatable.dart';

class HabitMonthSummary extends Equatable {
  final List<DateTime> doneDays;

  const HabitMonthSummary({required this.doneDays});

  @override
  List<Object?> get props => [doneDays];
}
