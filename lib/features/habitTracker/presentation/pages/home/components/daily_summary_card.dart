import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:habit_tracker/core/router/app_router.gr.dart';
import 'package:habit_tracker/features/habitTracker/domain/entities/task.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';

import 'package:habit_tracker/features/habitTracker/presentation/providers/home/task_provider.dart';

class DailySummaryCard extends ConsumerWidget {
  const DailySummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskProvider);
    final completedTasksCount = state.done.length;
    final totalTasksCount = state.tasks.tasks.length;
    final colorScheme = ColorScheme.of(context);

    return Card(
      elevation: 8,
      shadowColor: colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [colorScheme.primary, colorScheme.secondary],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Header(),
              SizedBox(height: 16),
              ProgressIndicator(
                completedTasksCount: completedTasksCount,
                totalTasksCount: totalTasksCount,
              ),
              SizedBox(height: 16),
              CompletedTasksList(
                completedTasks: state.done,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressIndicator extends HookConsumerWidget {
  const ProgressIndicator({
    super.key,
    required this.completedTasksCount,
    required this.totalTasksCount,
  });
  final int completedTasksCount;
  final int totalTasksCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ColorScheme.of(context);
    final newValue = totalTasksCount > 0
        ? completedTasksCount / totalTasksCount
        : 0.0;
    final preValue = useRef(newValue);
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.list_sharp,
              color: colorScheme.onPrimary,
              size: 20,
            ),
            SizedBox(width: 4),
            Text(
              "$completedTasksCount/$totalTasksCount",
              style: TextStyle(color: colorScheme.onPrimary),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: preValue.value,
              end: newValue,
            ),
            duration: Duration(milliseconds: 220),
            builder: (context, value, _) => LinearProgressIndicator(
              value: value,
              color: colorScheme.onPrimary,
              minHeight: 8,
              backgroundColor: colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}

class Header extends HookConsumerWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ColorScheme.of(context);
    final date = ref.watch(taskProvider.select((state) => state.currentDate));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Daily Summary",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 450),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1.5),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Text(
            key: ValueKey(date),
            "${date.day}/${date.month}/${date.year}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class CompletedTasksList extends StatelessWidget {
  const CompletedTasksList({
    super.key,
    required this.completedTasks,
  });

  final List<Task> completedTasks;

  @override
  Widget build(BuildContext context) {
    return ImplicitlyAnimatedList<Task>(
      shrinkWrap: true,
      itemData: completedTasks,
      deleteDuration: Duration(milliseconds: 220),
      insertDuration: Duration(milliseconds: 220),
      itemEquality: (a, b) => a.id == b.id,
      itemBuilder: (context, task) {
        return DoneListTile(task: task);
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

class DoneListTile extends HookConsumerWidget {
  const DoneListTile({
    super.key,

    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ColorScheme.of(context);

    return InkWell(
      onLongPress: () => AutoRouter.of(
        context,
      ).replaceAll([HabitRoute(habitId: task.id)]),
      onTap: () => ref.read(taskProvider.notifier).toggleTask(task.id),
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
              onChanged: (bool? newValue) {
                ref.read(taskProvider.notifier).toggleTask(task.id);
              },
            ),
          ),
          Expanded(
            child: Hero(
              tag: "${task.id}${task.title}",
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
          ),
        ],
      ),
    );
  }
}
