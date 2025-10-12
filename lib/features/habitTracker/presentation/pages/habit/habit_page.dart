import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:habit_tracker/core/router/app_router.gr.dart';
import 'package:habit_tracker/features/habitTracker/presentation/pages/habit/components/delete_habit_row.dart';
import 'package:habit_tracker/features/habitTracker/presentation/pages/habit/components/update_title_row.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:habit_tracker/features/habitTracker/presentation/pages/habit/components/month_summary_view.dart';
import 'package:habit_tracker/features/habitTracker/presentation/providers/habit/habit_provider.dart';

@RoutePage()
class HabitPage extends HookConsumerWidget {
  const HabitPage({
    super.key,
    required this.habitId,
  });
  final String habitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(habitProvider.notifier);
    final state = ref.watch(habitProvider);
    final colorScheme = ColorScheme.of(context);
    final title = ref.watch(habitProvider.select((state) => state.habit.title));
    final titleController = useTextEditingController();

    useEffect(() {
      provider.init(habitId);
      titleController.text = title;
      return null;
    }, const []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        titleController.text = title;
      });
      return null;
    }, [title]);

    useEffect(() {
      if (state.habitDeleted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          provider.flush();
          AutoRouter.of(context).replaceAll([HomeRoute()]);
        });
      }
      return null;
    }, [state.habitDeleted]);

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
        title: Hero(
          tag: "${state.habit.id}${state.habit.title}",
          child: Text(state.habit.title),
        ),
        leading: IconButton(
          onPressed: () {
            provider.flush();
            AutoRouter.of(context).replaceAll([HomeRoute()]);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Hero(
                  tag: habitId,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            MonthSummaryView(),
                            SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: UpdateTitleRow(
                                titleController: titleController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DeleteHabitRow(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
