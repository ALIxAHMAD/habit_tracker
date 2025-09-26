import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:habit_tracker/features/habitTracker/presentation/pages/home/components/time_line_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = useState(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Habit racker"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TimeLineView(
                selectedDate: selectedDate.value,
                onSelectedDateChanged: (date) => selectedDate.value = date,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
