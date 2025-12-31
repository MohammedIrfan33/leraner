import 'package:get/get.dart';
import 'package:leraner/app/core/model/video_model.dart';
import 'package:leraner/services/api_services.dart';

class SubjectsController extends GetxController {
  final ApiService apiService = ApiService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var subjectData = Rxn<SubjectVideosModel>();

  @override
  void onInit() {
    fetchVideos();
    super.onInit();
  }

  /// Fetch video data from API
  void fetchVideos() async {
    try {
      isLoading(true);
      errorMessage('');
      final data = await apiService.fetchVideoDetails();

      // Optional: Unlock first video
      final videos = data.videos.asMap().entries.map((entry) {
        final index = entry.key;
        final video = entry.value;
        if (index == 0 && video.isLocked) {
          // Unlock first video
          return VideoItem(
            id: video.id,
            title: video.title,
            description: video.description,
            status: "unlocked",
            videoUrl: video.videoUrl,
            hasPlayButton: video.hasPlayButton,
          );
        }
        return video;
      }).toList();

      subjectData.value = SubjectVideosModel(
        title: data.title,
        videos: videos,
      );
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  void retry() {
    fetchVideos();
  }

  /// Mark video as completed and unlock next video
  void markVideoCompleted(int index) {
    final data = subjectData.value;
    if (data == null) return;

    final updatedVideos = data.videos.asMap().entries.map((entry) {
      final i = entry.key;
      final video = entry.value;

      if (i == index && !video.isCompleted) {
      
        return VideoItem(
          id: video.id,
          title: video.title,
          description: video.description,
          status: "completed",
          videoUrl: video.videoUrl,
          hasPlayButton: video.hasPlayButton,
        );
      } else if (i == index + 1 && video.isLocked) {
       
        return VideoItem(
          id: video.id,
          title: video.title,
          description: video.description,
          status: "unlocked",
          videoUrl: video.videoUrl,
          hasPlayButton: video.hasPlayButton,
        );
      }
      return video;
    }).toList();

    subjectData.value = SubjectVideosModel(title: data.title, videos: updatedVideos);
  }
}
