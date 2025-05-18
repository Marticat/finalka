import 'package:flutter/material.dart';

import '../api/mock_yummy_service.dart';
import '../components/category_section.dart';
import '../components/gym_section.dart';
import '../models/workout_manager.dart';
import '../models/plan_manager.dart';

import '../screens/exercise_list_page.dart';

class ExplorePage extends StatelessWidget {
  final mockService = MockYummyService();
  final WorkoutManager workoutManager;
  final PlanManager planManager;

  ExplorePage({
    super.key,
    required this.workoutManager,
    required this.planManager,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: FutureBuilder(
        future: mockService.getExploreData(),
        builder: (context, AsyncSnapshot<ExploreData> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final gyms = snapshot.data?.gyms ?? [];
            final categories = snapshot.data?.categories ?? [];
            final posts = snapshot.data?.friendPosts ?? [];

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              children: [
                SectionHeader(title: 'Challenge yourself'),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: GymSection(
                      gyms: gyms,
                      workoutManager: workoutManager,
                      planManager: planManager,
                    ),
                  ),
                ),
                SectionHeader(title: 'Try something new!'),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: CategorySection(
                      categories: categories,
                      onCategoryTap: (category) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseListPage(category: category.name),
                          ),
                        );
                      },
                    ),
                  ),
                ),

              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}
