class Exercise {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String difficulty;
  final int duration;
  final int calories;
  final List<String> instructions;
  final List<String> targetMuscles;
  final String category;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.difficulty,
    required this.duration,
    required this.calories,
    required this.instructions,
    required this.targetMuscles,
    required this.category,
  });
}

List<Exercise> exercises = [
  Exercise(
    id: '1',
    name: 'Deadlift',
    description: 'A compound exercise that works multiple muscle groups including the hamstrings, glutes, lower and upper back.',
    imageUrl: 'https://images.unsplash.com/photo-1605296867304-46d5465a13f1',
    difficulty: 'Advanced',
    duration: 10,
    calories: 200,
    instructions: [
      'Stand with feet shoulder-width apart',
      'Bend at hips and knees to grip barbell',
      'Keep back straight and lift with legs',
      'Stand up straight, then lower back down'
    ],
    targetMuscles: ['Hamstrings', 'Glutes', 'Lower Back', 'Upper Back'],
    category: 'Strength',
  ),
  Exercise(
    id: '2',
    name: 'Push-ups',
    description: 'A fundamental bodyweight exercise that strengthens the chest, shoulders, and triceps.',
    imageUrl: 'https://images.unsplash.com/photo-1604130523536-cf372d5f9746',
    difficulty: 'Beginner',
    duration: 5,
    calories: 100,
    instructions: [
      'Start in plank position',
      'Lower body until chest nearly touches floor',
      'Push back up to starting position',
      'Keep core engaged throughout'
    ],
    targetMuscles: ['Chest', 'Shoulders', 'Triceps', 'Core'],
    category: 'Bodyweight',
  ),
];
