import 'package:flutter/material.dart';
import '../models/exercise.dart';

class ExerciseDetailPage extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailPage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExerciseImage(),
            const SizedBox(height: 16),
            Text(
              exercise.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            _buildExerciseMeta(),
            const SizedBox(height: 16),
            _buildSectionTitle('Description'),
            Text(exercise.description),
            const SizedBox(height: 16),
            _buildSectionTitle('Instructions'),
            _buildInstructionsList(),
            const SizedBox(height: 16),
            _buildSectionTitle('Target Muscles'),
            _buildMuscleChips(),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseImage() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage(exercise.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildExerciseMeta() {
    return Row(
      children: [
        _buildMetaItem(Icons.fitness_center, '${exercise.difficulty}'),
        const SizedBox(width: 16),
        _buildMetaItem(Icons.timer, '${exercise.duration} mins'),
        const SizedBox(width: 16),
        _buildMetaItem(Icons.local_fire_department, '${exercise.calories} cal'),
      ],
    );
  }

  Widget _buildMetaItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildInstructionsList() {
    return Column(
      children: exercise.instructions
          .asMap()
          .entries
          .map((entry) => ListTile(
        leading: CircleAvatar(
          child: Text('${entry.key + 1}'),
        ),
        title: Text(entry.value),
      ))
          .toList(),
    );
  }


  Widget _buildMuscleChips() {
    return Wrap(
      spacing: 8,
      children: exercise.targetMuscles
          .map((muscle) => Chip(label: Text(muscle)))
          .toList(),
    );
  }
}

