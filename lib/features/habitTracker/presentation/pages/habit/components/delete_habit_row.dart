import 'package:flutter/material.dart';
import 'package:habit_tracker/features/habitTracker/presentation/pages/habit/components/delete_habit_dialog.dart';
import 'package:habit_tracker/features/habitTracker/presentation/providers/habit/habit_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeleteHabitRow extends HookConsumerWidget {
  const DeleteHabitRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ColorScheme.of(context);
    final title = ref.watch(habitProvider.select((state) => state.habit.title));
    final provider = ref.read(habitProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              colorScheme.error,
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
            ),
          ),
          onPressed: () {
            showDeleteHabitDialog(
              context,
              () {
                provider.deleteHabit();
              },
              title,
            );
          },
          child: Text(
            "Delete",
            style: TextStyle(
              color: colorScheme.onError,
            ),
          ),
        ),
      ],
    );
  }
}
