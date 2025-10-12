import 'package:flutter/material.dart';
import 'package:habit_tracker/features/habitTracker/presentation/providers/habit/habit_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdateTitleRow extends HookConsumerWidget {
  const UpdateTitleRow({
    super.key,
    required this.titleController,
  });

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(habitProvider.notifier);
    final state = ref.watch(habitProvider);
    final colorScheme = ColorScheme.of(context);
    return Row(
      children: [
        Expanded(
          child: TitleField(
            titleController: titleController,
          ),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              colorScheme.primary,
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
            if (titleController.text.isEmpty ||
                titleController.text == state.habit.title) {
              return;
            }
            provider.updateHabit(
              titleController.text,
            );
          },
          child: Text(
            "Update",
            style: TextStyle(
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class TitleField extends StatelessWidget {
  const TitleField({
    super.key,
    required this.titleController,
  });
  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return TextFormField(
      controller: titleController,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: colorScheme.onSurface,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: "Habit title",
      ),
    );
  }
}
