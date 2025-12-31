import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:leraner/features/subjects/controller/subject_controller.dart';
import 'package:leraner/app/core/model/video_model.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({super.key});

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  final controller = Get.put(SubjectsController());
  VideoPlayerController? _videoController;
  bool _isInitializing = false;
  int _currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load first unlocked video when data is available
    once(controller.subjectData, (data) {
      if (data != null && data.videos.isNotEmpty) {
        final firstUnlockedIndex = data.videos.indexWhere((v) => !v.isLocked);
        if (firstUnlockedIndex != -1) {
          _initializeVideo(firstUnlockedIndex);
        }
      }
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  /// Initialize video by index
  Future<void> _initializeVideo(int index) async {
    final data = controller.subjectData.value;
    if (data == null || data.videos.isEmpty) return;

    final video = data.videos[index];
    if (video.videoUrl.isEmpty) return;

    setState(() {
      _isInitializing = true;
      _currentVideoIndex = index;
    });

    await _videoController?.dispose();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(video.videoUrl));

    try {
      await _videoController!.initialize();
      setState(() {
        _isInitializing = false;
      });
      _videoController!.play();

      // Listen for video end to mark completed and unlock next
      _videoController!.addListener(() {
        if (_videoController!.value.position >= _videoController!.value.duration &&
            !_videoController!.value.isPlaying) {
          controller.markVideoCompleted(index);
        }
      });
    } catch (e) {
      setState(() {
        _isInitializing = false;
      });
      Get.snackbar("Video Error", "Could not load video player",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Subjects/Videos"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.retry,
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        final data = controller.subjectData.value;
        if (data == null || data.videos.isEmpty) {
          return const Center(child: Text("No videos available"));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- VIDEO PLAYER ---
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.black,
              child: _isInitializing
                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                  : (_videoController != null && _videoController!.value.isInitialized)
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: _videoController!.value.aspectRatio,
                              child: VideoPlayer(_videoController!),
                            ),
                            // Overlay Play Icon when paused
                            GestureDetector(
                              onTap: () {
                                if (_videoController!.value.isPlaying) {
                                  _videoController!.pause();
                                } else {
                                  _videoController!.play();
                                }
                                setState(() {});
                              },
                              child: Icon(
                                _videoController!.value.isPlaying
                                    ? null
                                    : Icons.play_arrow,
                                size: 50,
                                color: Colors.white70,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: VideoProgressIndicator(
                                _videoController!,
                                allowScrubbing: true,
                                colors: const VideoProgressColors(playedColor: Colors.red),
                              ),
                            ),
                          ],
                        )
                      : const Center(
                          child: Icon(Icons.error_outline, color: Colors.white, size: 40),
                        ),
            ),

            // --- PLAY / PAUSE BUTTON ---
            if (_videoController != null && _videoController!.value.isInitialized)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_videoController!.value.isPlaying) {
                          _videoController!.pause();
                        } else {
                          _videoController!.play();
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        _videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                      label: Text(_videoController!.value.isPlaying ? "Pause" : "Play"),
                    ),
                  ],
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                data.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // --- VIDEO LIST ---
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: data.videos.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final video = data.videos[index];
                  return _videoListTile(video, index);
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _videoListTile(VideoItem video, int index) {
    bool isLocked = video.isLocked;

    return InkWell(
      onTap: isLocked ? null : () => _initializeVideo(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: isLocked ? Colors.grey[200] : Colors.blue[50],
                  child: Icon(
                    isLocked ? Icons.lock : Icons.play_arrow,
                    color: isLocked ? Colors.grey : Colors.blue,
                  ),
                ),
                if (video.isCompleted)
                  const Positioned(
                    right: 0,
                    bottom: 0,
                    child: Icon(Icons.check_circle, color: Colors.green, size: 16),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isLocked ? Colors.grey : Colors.black,
                    ),
                  ),
                  Text(
                    video.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
