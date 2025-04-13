import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildProgressSection(),
            const SizedBox(height: 20),
            _buildAchievementsSection(),
            const SizedBox(height: 20),
            _buildWorkoutStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/profile_pics/person_cesare.jpeg'), // Make sure this asset exists
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("John Doe", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Fitness Enthusiast"),
          ],
        )
      ],
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        LinearProgressIndicator(value: 0.7),
        SizedBox(height: 5),
        Text("70% towards muscle mass goal"),
      ],
    );
  }

  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Achievements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text("🏅 Completed 30-day push-up challenge"),
        Text("🏋️‍♂️ New PR: 120kg deadlift"),
        Text("🔥 Logged workouts 10 days in a row"),
      ],
    );
  }

  Widget _buildWorkoutStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Workout Stats", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text("Total Workouts: 85"),
        Text("Calories Burned: 23,000 kcal"),
        Text("Hours Trained: 110 hrs"),
      ],
    );
  }
}
