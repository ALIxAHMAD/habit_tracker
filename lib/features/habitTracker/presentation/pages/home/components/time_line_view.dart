// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/features/habitTracker/presentation/providers/home/task_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimeLineView extends HookConsumerWidget {
  const TimeLineView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDate = ref.watch(
      taskProvider.select((state) => state.currentDate),
    );
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: EasyDateTimeLine(
        initialDate: currentDate,
        onDateChange: (date) =>
            ref.read(taskProvider.notifier).changeDate(date),
        headerProps: const EasyHeaderProps(showHeader: false),
        dayProps: _buildDayProps(colorScheme),
      ),
    );
  }

  EasyDayProps _buildDayProps(ColorScheme colorScheme) {
    final todayStyle = _buildTodayStyle(colorScheme);
    final inactiveDayStyle = _buildInactiveDayStyle(colorScheme);
    final activeDayStyle = _buildActiveDayStyle(colorScheme);
    return EasyDayProps(
      todayStyle: todayStyle,
      inactiveDayStyle: inactiveDayStyle,
      activeDayStyle: activeDayStyle,
    );
  }

  DayStyle _buildTodayStyle(ColorScheme colorScheme) {
    return DayStyle(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.primary,
          width: 2,
        ),
      ),
      monthStrStyle: TextStyle(color: colorScheme.primary),
      dayStrStyle: TextStyle(
        color: colorScheme.primary,
        fontSize: 16,
      ),
      dayNumStyle: TextStyle(
        color: colorScheme.primary,
        fontSize: 16,
      ),
    );
  }

  DayStyle _buildInactiveDayStyle(ColorScheme colorScheme) {
    return DayStyle(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.onSurface,
          width: 1,
        ),
      ),
      monthStrStyle: TextStyle(color: colorScheme.onSurface),
      dayStrStyle: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 16,
      ),
      dayNumStyle: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 16,
      ),
    );
  }

  DayStyle _buildActiveDayStyle(ColorScheme colorScheme) {
    return DayStyle(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.secondary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      monthStrStyle: TextStyle(color: colorScheme.onPrimary),
      dayStrStyle: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      dayNumStyle: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
