class Todo {
  final String title;
  final bool isCompleted;

  Todo({
    required this.title,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
      };

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }

  Todo copyWith({
    String? title,
    bool? isCompleted,
  }) {
    return Todo(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
