import 'package:equatable/equatable.dart';

class Habit extends Equatable {
  final String title;
  final String id;

  const Habit({
    required this.title,
    required this.id,
  });

  Habit copyWith({
    String? title,
    String? id,
  }) {
    return Habit(
      title: title ?? this.title,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [title, id];
}
