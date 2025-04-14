import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 24),
            _buildProgressSection(context),
            const SizedBox(height: 24),
            _buildCardSection(
              title: "Achievements",
              children: const [
                ListTile(title: Text("🏅 Completed 30-day push-up challenge")),
                ListTile(title: Text("🏋️‍♂️ New PR: 120kg deadlift")),
                ListTile(title: Text("🔥 Logged workouts 10 days in a row")),
              ],
            ),
            const SizedBox(height: 24),
            _buildCardSection(
              title: "Workout Stats",
              children: const [
                ListTile(title: Text("Total Workouts: 85")),
                ListTile(title: Text("Calories Burned: 23,000 kcal")),
                ListTile(title: Text("Hours Trained: 110 hrs")),
              ],
            ),
            const SizedBox(height: 24),
            _buildFriendsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/profile_pics/person_cesare.jpeg'),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("John Doe", style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            Text("Fitness Enthusiast", style: textTheme.bodyMedium),
          ],
        )
      ],
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Progress", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: 0.7,
                minHeight: 10,
                backgroundColor: color.surfaceVariant,
                valueColor: AlwaysStoppedAnimation(color.primary),
              ),
            ),
            const SizedBox(height: 8),
            Text("70% towards muscle mass goal", style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildCardSection({required String title, required List<Widget> children}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildFriendsSection() {
    return _buildCardSection(
      title: "Friends",
      children: const [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/profile_pics/friend_anna.jpg'),
          ),
          title: Text("Anna Smith"),
          subtitle: Text("🏃‍♀️ 5K run today"),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/profile_pics/friend_bob.jpg'),
          ),
          title: Text("Bob Johnson"),
          subtitle: Text("💪 Just hit a new PR!"),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/profile_pics/friend_emma.jpg'),
          ),
          title: Text("Emma Davis"),
          subtitle: Text("🔥 7 days workout streak"),
        ),
      ],
    );
  }
}
