import 'package:flutter/material.dart';
import 'package:habit_tracker/features/habitTracker/presentation/providers/habit/habit_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthSummaryView extends HookConsumerWidget {
  const MonthSummaryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    final state = ref.watch(habitProvider);

    return SizedBox(
      width: 280,
      child: TableCalendar(
        firstDay: firstDayOfMonth,
        lastDay: lastDayOfMonth,
        focusedDay: now,
        calendarFormat: CalendarFormat.month,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronVisible: false,
          rightChevronVisible: false,
        ),
        pageJumpingEnabled: false,
        pageAnimationEnabled: false,
        rowHeight: 28,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            if (state.summary.doneDays.any((date) => date.day == day.day)) {
              return DoneDay(day: day);
            } else {
              return NotDoneDay(day: day);
            }
          },
          todayBuilder: (context, day, focusedDay) {
            return Today(day: day);
          },
        ),
      ),
    );
  }
}

class NotDoneDay extends StatelessWidget {
  const NotDoneDay({
    super.key,
    required this.day,
  });
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return SizedBox(
      height: 32,
      width: 32,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.surfaceContainer,
        ),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class DoneDay extends StatelessWidget {
  const DoneDay({
    super.key,
    required this.day,
  });
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return SizedBox(
      height: 32,
      width: 32,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.primary,
        ),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class Today extends StatelessWidget {
  const Today({
    super.key,
    required this.day,
  });
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return SizedBox(
      height: 32,
      width: 32,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: BoxBorder.all(
            width: 2,
            color: colorScheme.secondary,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: TextStyle(
            color: colorScheme.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
