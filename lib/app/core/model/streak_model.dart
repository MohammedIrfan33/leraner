class StreakModel {
  final int currentDay;
  final int totalDays;
  final List<StreakDay> days;

  StreakModel({
    required this.currentDay,
    required this.totalDays,
    required this.days,
  });

  factory StreakModel.fromJson(Map<String, dynamic> json) {
    return StreakModel(
      currentDay: json['current_day'],
      totalDays: json['total_days'],
      days: List<StreakDay>.from(
        json['days'].map((x) => StreakDay.fromJson(x)),
      ),
    );
  }
}

class StreakDay {
  final int id;
  final int dayNumber;
  final String label;
  final bool isCompleted;
  final bool isCurrent;
  final Topic topic;

  StreakDay({
    required this.id,
    required this.dayNumber,
    required this.label,
    required this.isCompleted,
    required this.isCurrent,
    required this.topic,
  });

  factory StreakDay.fromJson(Map<String, dynamic> json) {
    return StreakDay(
      id: json['id'],
      dayNumber: json['day_number'],
      label: json['label'],
      isCompleted: json['is_completed'],
      isCurrent: json['is_current'],
      topic: Topic.fromJson(json['topic']),
    );
  }
}

class Topic {
  final String title;
  final List<Module> modules;

  Topic({required this.title, required this.modules});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      title: json['title'],
      modules: List<Module>.from(
        json['modules'].map((x) => Module.fromJson(x)),
      ),
    );
  }
}

class Module {
  final String name;
  final String description;

  Module({required this.name, required this.description});

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      name: json['name'],
      description: json['description'],
    );
  }
}
