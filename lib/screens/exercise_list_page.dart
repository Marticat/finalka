import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../screens/exercise_detail_page.dart';

class ExerciseListPage extends StatelessWidget {
  final String category;

  const ExerciseListPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final categoryExercises = exercises
        .where((exercise) => exercise.category == category)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Exercises'),
      ),
      body: ListView.builder(
        itemCount: categoryExercises.length,
        itemBuilder: (context, index) {
          final exercise = categoryExercises[index];
          return ListTile(
            leading: Image.network(
              exercise.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            title: Text(exercise.name),
            subtitle: Text(exercise.difficulty),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseDetailPage(exercise: exercise),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
