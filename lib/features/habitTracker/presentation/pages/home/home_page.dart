import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:habit_tracker/features/habitTracker/presentation/pages/home/components/add_habit_dialog.dart';
import 'package:habit_tracker/features/habitTracker/presentation/pages/home/components/daily_summary_card.dart';
import 'package:habit_tracker/features/habitTracker/presentation/pages/home/components/time_line_view.dart';
import 'package:habit_tracker/features/habitTracker/presentation/pages/home/components/todo_list.dart';
import 'package:habit_tracker/features/habitTracker/presentation/providers/home/task_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(taskProvider.notifier);
    final state = ref.watch(taskProvider);
    final colorScheme = ColorScheme.of(context);

    useEffect(() {
      provider.fetchTasksForCurrentDay();
      return null;
    }, const []);

    useEffect(() {
      if (state.errorMessage.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 3),
              backgroundColor: colorScheme.error,
              content: Text(
                state.errorMessage,
                style: TextStyle(
                  color: colorScheme.onError,
                ),
              ),
            ),
          );
          provider.clearError();
        });
      }

      return null;
    }, [state.errorMessage]);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Habit Tracker"),
      ),
      floatingActionButton: Material(
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            showAddHabitDialog(context, (title) {
              provider.addHabit(title);
            });
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
