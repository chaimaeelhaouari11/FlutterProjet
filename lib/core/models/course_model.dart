class LessonModel {
  final String id;
  final String title;
  final String description;
  final int duration; // durée en minutes

  LessonModel({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
  });

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      duration: map['duration'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'duration': duration,
    };
  }
}
