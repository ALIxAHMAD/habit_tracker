class Task {
  final bool isDone;
  final String title;
  final String id;

  Task({
    required this.id,
    required this.isDone,
    required this.title,
  });
  Task copyWith({String? title, bool? isDone}) {
    return Task(
      id: id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
