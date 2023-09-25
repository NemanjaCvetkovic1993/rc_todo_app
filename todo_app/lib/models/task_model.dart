class TaskModel {
  final String title;
  final String description;
  final DateTime time;
  final bool isCompleted;
  final List<String> sharedWith;

  TaskModel({
    required this.title,
    required this.description,
    required this.time,
    required this.isCompleted,
    required this.sharedWith,
  });
}
