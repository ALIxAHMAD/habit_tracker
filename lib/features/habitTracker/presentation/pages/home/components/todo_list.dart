import 'package:flutter/material.dart';
import 'package:habit_tracker/features/habitTracker/presentation/pages/home/components/delete_habit_dialog.dart';
import 'package:habit_tracker/features/habitTracker/presentation/providers/home/mock_data.dart';
import 'package:habit_tracker/features/habitTracker/presentation/providers/home/task_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoTasks = ref.watch(taskProvider).where((t) => !t.isDone).toList();

    return ImplicitlyAnimatedList<Task>(
      shrinkWrap: true,
      itemData: todoTasks,
      deleteDuration: Duration(milliseconds: 220),
      insertDuration: Duration(milliseconds: 220),
      itemEquality: (a, b) => a.id == b.id,
      itemBuilder: (context, task) {
        return TodoListTile(task: task);
      },
      insertAnimation: (context, child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: child,
        );
      },
      deleteAnimation: (context, child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: child,
        );
      },
    );
  }
}

class TodoListTile extends HookConsumerWidget {
  const TodoListTile({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Card(
        shadowColor: colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6,
        child: InkWell(
          onLongPress: () => showDeleteHabitDialog(context, () {}, task.title),
          onTap: () => ref.read(taskProvider.notifier).toggleTask(task),
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.secondary],
              ),
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: colorScheme.onPrimary,
                  width: 2,
                ),
                vertical: BorderSide(
                  color: colorScheme.onPrimary,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    activeColor: colorScheme.onPrimary,
                    checkColor: colorScheme.primary,
                    side: BorderSide(
                      color: colorScheme.onPrimary,
                      width: 2,
                    ),
                    tristate: true,
                    value: task.isDone,
                    onChanged: (_) {
                      ref.read(taskProvider.notifier).toggleTask(task);
                    },
                  ),
                ),
                Expanded(
                  child: Text(
                    task.title,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
