class HomeModel {
  final User user;
  final List<HeroBanner> heroBanners;
  final ActiveCourse activeCourse;
  final List<PopularCategory> popularCourses;
  final LiveSession liveSession;
  final Community community;
  final List<Testimonial> testimonials;
  final Support support;

  HomeModel({
    required this.user,
    required this.heroBanners,
    required this.activeCourse,
    required this.popularCourses,
    required this.liveSession,
    required this.community,
    required this.testimonials,
    required this.support,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      user: User.fromJson(json['user']),
      heroBanners: (json['hero_banners'] as List? ?? [])
          .map((e) => HeroBanner.fromJson(e))
          .toList(),
      activeCourse: ActiveCourse.fromJson(json['active_course']),
      popularCourses: (json['popular_courses'] as List? ?? [])
          .map((e) => PopularCategory.fromJson(e))
          .toList(),
      liveSession: LiveSession.fromJson(json['live_session']),
      community: Community.fromJson(json['community']),
      testimonials: (json['testimonials'] as List? ?? [])
          .map((e) => Testimonial.fromJson(e))
          .toList(),
      support: Support.fromJson(json['support']),
    );
  }
}

/* ---------------- USER ---------------- */

class User {
  final String name;
  final String greeting;
  final int streakDays;

  User({
    required this.name,
    required this.greeting,
    required this.streakDays,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      greeting: json['greeting'] ?? '',
      streakDays: json['streak']?['days'] ?? 0,
    );
  }
}



class HeroBanner {
  final int id;
  final String title;
  final String image;
  final bool isActive;

  HeroBanner({
    required this.id,
    required this.title,
    required this.image,
    required this.isActive,
  });

  factory HeroBanner.fromJson(Map<String, dynamic> json) {
    return HeroBanner(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }
}


class ActiveCourse {
  final String title;
  final int progress;
  final int testsCompleted;
  final int totalTests;

  ActiveCourse({
    required this.title,
    required this.progress,
    required this.testsCompleted,
    required this.totalTests,
  });

  factory ActiveCourse.fromJson(Map<String, dynamic> json) {
    return ActiveCourse(
      title: json['title'] ?? '',
      progress: json['progress'] ?? 0,
      testsCompleted: json['tests_completed'] ?? 0,
      totalTests: json['total_tests'] ?? 0,
    );
  }
}



class PopularCategory {
  final String name;
  final List<Course> courses;

  PopularCategory({
    required this.name,
    required this.courses,
  });

  factory PopularCategory.fromJson(Map<String, dynamic> json) {
    return PopularCategory(
      name: json['name'] ?? '',
      courses: (json['courses'] as List? ?? [])
          .map((e) => Course.fromJson(e))
          .toList(),
    );
  }
}

class Course {
  final String title;
  final String image;
  final String action;

  Course({
    required this.title,
    required this.image,
    required this.action,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      action: json['action'] ?? '',
    );
  }
}

/* ---------------- LIVE SESSION ---------------- */

class LiveSession {
  final String title;
  final String instructor;
  final String date;
  final String time;
  final String action;
  final bool isLive;

  LiveSession({
    required this.title,
    required this.instructor,
    required this.date,
    required this.time,
    required this.action,
    required this.isLive,
  });

  factory LiveSession.fromJson(Map<String, dynamic> json) {
    return LiveSession(
      title: json['title'] ?? '',
      instructor: json['instructor']?['name'] ?? '',
      date: json['session_details']?['date'] ?? '',
      time: json['session_details']?['time'] ?? '',
      action: json['action'] ?? '',
      isLive: json['is_live'] ?? false,
    );
  }
}



class Community {
  final String name;
  final int activeMembers;
  final String description;

  Community({
    required this.name,
    required this.activeMembers,
    required this.description,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      name: json['name'] ?? '',
      activeMembers: json['active_members'] ?? 0,
      description: json['description'] ?? '',
    );
  }
}



class Testimonial {
  final String learnerName;
  final String avatar;
  final String review;

  Testimonial({
    required this.learnerName,
    required this.avatar,
    required this.review,
  });

  factory Testimonial.fromJson(Map<String, dynamic> json) {
    return Testimonial(
      learnerName: json['learner']?['name'] ?? '',
      avatar: json['learner']?['avatar'] ?? '',
      review: json['review'] ?? '',
    );
  }
}



class Support {
  final String title;
  final String description;
  final String exampleQuestion;

  Support({
    required this.title,
    required this.description,
    required this.exampleQuestion,
  });

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      exampleQuestion: json['example_question'] ?? '',
    );
  }
}
