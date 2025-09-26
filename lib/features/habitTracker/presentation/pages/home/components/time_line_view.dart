// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

class TimeLineView extends StatelessWidget {
  const TimeLineView({
    super.key,
    required this.selectedDate,
    this.onSelectedDateChanged,
  });
  final DateTime selectedDate;
  final void Function(DateTime)? onSelectedDateChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: EasyDateTimeLine(
        initialDate: selectedDate,
        onDateChange: onSelectedDateChanged,
        headerProps: EasyHeaderProps(
          showHeader: false,
        ),
        dayProps: EasyDayProps(
          activeDayStyle: DayStyle(
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
            monthStrStyle: TextStyle(
              color: colorScheme.onPrimary,
            ),
          ),
          inactiveDayStyle: DayStyle(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.onSurface,
                width: 1,
              ),
            ),
            dayNumStyle: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 16,
            ),
            dayStrStyle: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 16,
            ),
            monthStrStyle: TextStyle(
              color: colorScheme.onSurface,
            ),
          ),
          todayStyle: DayStyle(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.primary,
                width: 2,
              ),
            ),
            monthStrStyle: TextStyle(
              color: colorScheme.primary,
            ),
            dayStrStyle: TextStyle(
              color: colorScheme.primary,
              fontSize: 16,
            ),
            dayNumStyle: TextStyle(
              color: colorScheme.primary,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
