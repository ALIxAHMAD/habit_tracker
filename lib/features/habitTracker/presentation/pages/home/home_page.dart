import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/features/habitTracker/presentation/pages/home/components/add_habit_dialog.dart';
import 'package:habit_tracker/features/habitTracker/presentation/pages/home/components/daily_summary_card.dart';
import 'package:habit_tracker/features/habitTracker/presentation/pages/home/components/time_line_view.dart';
import 'package:habit_tracker/features/habitTracker/presentation/pages/home/components/todo_list.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Habit racker"),
      ),
      floatingActionButton: Material(
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            showAddHabitDialog(context, (title) {});
          },
          child: Ink(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: colorScheme.onPrimary, width: 3),
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary,
                  colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Icon(
              Icons.add,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimeLineView(),
                SizedBox(height: 16),
                DailySummaryCard(),
                SizedBox(height: 16),
                TodoList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
