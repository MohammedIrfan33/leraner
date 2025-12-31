import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leraner/app/core/model/streak_model.dart';
import 'package:leraner/features/streak/controller/streak_controller.dart';

class StreakPage extends StatefulWidget {
  const StreakPage({super.key});

  @override
  State<StreakPage> createState() => _StreakPageState();
}

class _StreakPageState extends State<StreakPage> {
  final StreakController controller = Get.put(StreakController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday();
    });
  }

  void _scrollToToday() {
    final data = controller.streakData.value;
    if (data == null) return;

    final currentIndex =
        data.days.indexWhere((element) => element.isCurrent);
    if (currentIndex == -1) return;

    final uiIndex = data.days.length - 1 - currentIndex;
    final targetOffset = _dayOffsets[uiIndex].dy - 250;

    scrollController.animateTo(
      targetOffset.clamp(
        0,
        scrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffB8F3FF),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
      
        final data = controller.streakData.value;
        if (data == null) return const SizedBox();
      
        final today =
            data.days.firstWhere((e) => e.isCurrent, orElse: () => data.days.first);
      
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0Xff7DF0FC),
              Color(0xffB2F8FF),
      
      
            ])
          ),
          child: Column(
            children: [

              SizedBox(height: 50.h,),
              
              Padding(
                padding: const EdgeInsets.all(16),
                child: _TodayTopicBubble(
                  title: today.topic.title,
                  modules: today.topic.modules,
                ),
              ),
          
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: SizedBox(
                    height: 1150,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _StreakPathPainter(),
                          ),
                        ),
          
                        ...List.generate(data.days.length, (i) {
                          final uiIndex = data.days.length - 1 - i;
                          final day = data.days[uiIndex];
                          final offset = _dayOffsets[i];
          
                          return Positioned(
                            left: offset.dx,
                            top: offset.dy,
                            child: _DayBubble(day: day),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

/// --------------------------------------------------
/// DAY BUBBLE
/// --------------------------------------------------
class _DayBubble extends StatelessWidget {
  final StreakDay day;

  const _DayBubble({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: const Color(0xff4AA8B5),
        shape: BoxShape.circle,
        border: day.isCurrent
            ? Border.all(color: Colors.blueAccent, width: 4)
            : null,
        boxShadow: [
          BoxShadow(
            color: day.isCurrent
                ? Colors.blue.withOpacity(.6)
                : Colors.black26,
            blurRadius: day.isCurrent ? 14 : 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Center(
        child: Text(
          'Day\n${day.dayNumber}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// --------------------------------------------------
/// TODAY TOPIC (TOP SIDE PANEL)
/// --------------------------------------------------
class _TodayTopicBubble extends StatelessWidget {
  final String title;
  final List<Module> modules;

  const _TodayTopicBubble({
    required this.title,
    required this.modules,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff4AA8B5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Topic",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(color: Colors.white54),
          ...modules.map(
            (m) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                "• ${m.name}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// --------------------------------------------------
/// CURVED DOTTED PATH
/// --------------------------------------------------
class _StreakPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(220, 60);
    path.cubicTo(40, 220, 340, 340, 200, 520);
    path.cubicTo(40, 700, 340, 860, 200, 1040);

    const dashWidth = 10;
    const dashSpace = 10;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final extract =
            metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extract, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

/// --------------------------------------------------
/// FIXED OFFSETS
/// --------------------------------------------------
final List<Offset> _dayOffsets = [
  Offset(200, 60),
  Offset(80, 190),
  Offset(210, 300),
  Offset(260, 430),
  Offset(120, 560),
  Offset(220, 720),
  Offset(270, 880),
  Offset(180, 1020),
];
