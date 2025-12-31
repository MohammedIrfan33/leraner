import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../../../app/routes/app_routes.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
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
                Text(controller.errorMessage.value, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.retry,
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        final user = controller.userData.value;
        if (user == null) return const Center(child: Text("No data available"));

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Greeting
              Text("Hi, ${user.username} 👋", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Active Course Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Active Course", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 8),
                      Text(user.activeCourse.title, style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: user.activeCourse.progress,
                        minHeight: 6,
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Streak Button
              ElevatedButton.icon(
                onPressed: () => Get.toNamed(AppRoutes.streak),
                icon: const Icon(Icons.local_fire_department),
                label: Text("Day ${user.streak} 🔥"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),

              const SizedBox(height: 16),

              // Categories Chips
              Wrap(
                spacing: 8,
                children: user.categories.map((c) => Chip(label: Text(c), backgroundColor: Colors.blue.shade100)).toList(),
              ),

              const SizedBox(height: 24),

              // Popular Courses Horizontal List
              const Text("Popular Courses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: user.popularCourses.length,
                  itemBuilder: (context, index) {
                    final course = user.popularCourses[index];
                    return Container(
                      width: 140,
                      margin: const EdgeInsets.only(right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              color: Colors.grey.shade300,
                              child: course.image != null
                                  ? Image.network(course.image!, fit: BoxFit.cover)
                                  : const Center(child: Icon(Icons.image)),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(course.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Live Classes
              if (user.liveClasses.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Live Classes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: user.liveClasses.length,
                        itemBuilder: (context, index) {
                          final live = user.liveClasses[index];
                          return Container(
                            width: 140,
                            margin: const EdgeInsets.only(right: 12),
                            color: Colors.orange.shade100,
                            child: Center(child: Text(live.title)),
                          );
                        },
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 24),

              // Community
              if (user.community.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Community", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ...user.community.map((c) => Card(
                      child: ListTile(
                        title: Text(c.title),
                        subtitle: Text(c.description),
                      ),
                    )),
                  ],
                ),

              const SizedBox(height: 24),

              // Testimonials
              if (user.testimonials.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Testimonials", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ...user.testimonials.map((t) => Card(
                      child: ListTile(
                        title: Text(t.name),
                        subtitle: Text(t.feedback),
                      ),
                    )),
                  ],
                ),

              const SizedBox(height: 24),

              // Contact (optional)
              if (user.contact != null)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text("Contact"),
                    subtitle: Text(user.contact!),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
