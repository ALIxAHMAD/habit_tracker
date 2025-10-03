import 'package:flutter/material.dart';

Future<void> showAddHabitDialog(
  BuildContext context,
  void Function(String) onConfirm,
) {
  final titleController = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      final colorScheme = Theme.of(context).colorScheme;
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: colorScheme.primary,
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
                  "Add new habit",
                  style:
                      Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: colorScheme.onSurface),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.primary),
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
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          colorScheme.primary,
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (titleController.text.isEmpty) return;
                        onConfirm(titleController.text);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(color: colorScheme.onPrimary),
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
