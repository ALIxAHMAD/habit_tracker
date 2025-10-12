// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:habit_tracker/features/habitTracker/presentation/pages/habit/habit_page.dart'
    as _i1;
import 'package:habit_tracker/features/habitTracker/presentation/pages/home/home_page.dart'
    as _i2;

/// generated route for
/// [_i1.HabitPage]
class HabitRoute extends _i3.PageRouteInfo<HabitRouteArgs> {
  HabitRoute({
    _i4.Key? key,
    required String habitId,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         HabitRoute.name,
         args: HabitRouteArgs(key: key, habitId: habitId),
         initialChildren: children,
       );

  static const String name = 'HabitRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HabitRouteArgs>();
      return _i1.HabitPage(key: args.key, habitId: args.habitId);
    },
  );
}

class HabitRouteArgs {
  const HabitRouteArgs({this.key, required this.habitId});

  final _i4.Key? key;

  final String habitId;

  @override
  String toString() {
    return 'HabitRouteArgs{key: $key, habitId: $habitId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HabitRouteArgs) return false;
    return key == other.key && habitId == other.habitId;
  }

  @override
  int get hashCode => key.hashCode ^ habitId.hashCode;
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}
