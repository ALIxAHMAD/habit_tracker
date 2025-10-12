import 'package:flutter/material.dart';

Future<void> showDeleteHabitDialog(
  BuildContext context,
  VoidCallback onConfirm,
  String title,
) {
  return showDialog(
    context: context,
    builder: (context) {
      final colorScheme = Theme.of(context).colorScheme;

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: colorScheme.error,
            width: 2,
          ),
        ),
        backgroundColor: colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Delete Habit",
                  style:
                      Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style:
                      Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          colorScheme.error,
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      onPressed: () {
                        onConfirm();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: colorScheme.onError),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
