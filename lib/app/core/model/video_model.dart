class SubjectVideosModel {
  final String title;
  final List<VideoItem> videos;

  SubjectVideosModel({
    required this.title,
    required this.videos,
  });

  factory SubjectVideosModel.fromJson(Map<String, dynamic> json) {
    return SubjectVideosModel(
      title: json['title'] ?? '',
      videos: List<VideoItem>.from(
        (json['videos'] ?? []).map((x) => VideoItem.fromJson(x)),
      ),
    );
  }
}

class VideoItem {
  final int id;
  final String title;
  final String description;
  final String status;
  final String videoUrl;
  final bool hasPlayButton;

  VideoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.videoUrl,
    required this.hasPlayButton,
  });

  bool get isCompleted => status == "completed";
  bool get isLocked => status == "locked";

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      videoUrl: json['video_url'],
      hasPlayButton: json['has_play_button'] ?? false,
    );
  }
}
