class UserModel {
  final String username;
  final List<String> categories;
  final List<Course> popularCourses;
  final Course activeCourse;
  final int streak;
  final List<LiveClass> liveClasses;
  final List<Community> community;
  final List<Testimonial> testimonials;
  final String? contact;

  UserModel({
    required this.username,
    required this.categories,
    required this.popularCourses,
    required this.activeCourse,
    required this.streak,
    required this.liveClasses,
    required this.community,
    required this.testimonials,
    this.contact,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? 'User',
      categories: List<String>.from(json['categories'] ?? []),
      popularCourses: List<Course>.from(
          (json['popular_courses'] ?? []).map((x) => Course.fromJson(x))),
      activeCourse: Course.fromJson(json['active_course'] ?? {}),
      streak: json['streak'] ?? 0,
      liveClasses: List<LiveClass>.from(
          (json['live_classes'] ?? []).map((x) => LiveClass.fromJson(x))),
      community: List<Community>.from(
          (json['community'] ?? []).map((x) => Community.fromJson(x))),
      testimonials: List<Testimonial>.from(
          (json['testimonials'] ?? []).map((x) => Testimonial.fromJson(x))),
      contact: json['contact'],
    );
  }
}

class Course {
  final String title;
  final String? image;
  final double progress;

  Course({required this.title, this.image, this.progress = 0});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'] ?? '',
      image: json['image'],
      progress: (json['progress'] ?? 0).toDouble(),
    );
  }
}

class LiveClass {
  final String title;
  LiveClass({required this.title});
  factory LiveClass.fromJson(Map<String, dynamic> json) {
    return LiveClass(title: json['title'] ?? '');
  }
}

class Community {
  final String title;
  final String description;
  Community({required this.title, required this.description});
  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Testimonial {
  final String name;
  final String feedback;
  Testimonial({required this.name, required this.feedback});
  factory Testimonial.fromJson(Map<String, dynamic> json) {
    return Testimonial(
      name: json['name'] ?? '',
      feedback: json['feedback'] ?? '',
    );
  }
}
