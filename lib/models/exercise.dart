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
  // Strength
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

  // Calisthenics
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
    category: 'Calisthenics',
  ),

  // Cardio
  Exercise(
    id: '3',
    name: 'Running',
    description: 'A high-intensity aerobic exercise that improves cardiovascular health and burns calories.',
    imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b',
    difficulty: 'Intermediate',
    duration: 30,
    calories: 300,
    instructions: [
      'Warm up with a light jog',
      'Maintain steady pace',
      'Breathe rhythmically',
      'Cool down after run'
    ],
    targetMuscles: ['Legs', 'Heart', 'Lungs'],
    category: 'Cardio',
  ),

  // HIIT
  Exercise(
    id: '4',
    name: 'Burpees',
    description: 'A full-body, high-intensity exercise that burns fat and boosts endurance.',
    imageUrl: 'https://images.unsplash.com/photo-1584466977776-01f7b3b9f783',
    difficulty: 'Advanced',
    duration: 5,
    calories: 150,
    instructions: [
      'Start standing, drop into squat',
      'Kick feet back into plank',
      'Do push-up and jump feet forward',
      'Leap into air with arms overhead'
    ],
    targetMuscles: ['Chest', 'Legs', 'Core', 'Shoulders'],
    category: 'HIIT',
  ),

  // Yoga
  Exercise(
    id: '5',
    name: 'Downward Dog',
    description: 'A foundational yoga pose that stretches the hamstrings, calves, and spine.',
    imageUrl: 'https://images.unsplash.com/photo-1599058917212-d750089bc407',
    difficulty: 'Beginner',
    duration: 3,
    calories: 30,
    instructions: [
      'Start on all fours',
      'Lift hips towards the ceiling',
      'Keep legs straight and heels toward floor',
      'Hold and breathe deeply'
    ],
    targetMuscles: ['Hamstrings', 'Calves', 'Back'],
    category: 'Yoga',
  ),

  // Crossfit
  Exercise(
    id: '6',
    name: 'Kettlebell Swing',
    description: 'A Crossfit staple that builds explosive hip power and strengthens the posterior chain.',
    imageUrl: 'https://images.unsplash.com/photo-1605296866985-34c6ceebd294',
    difficulty: 'Intermediate',
    duration: 7,
    calories: 180,
    instructions: [
      'Stand with feet shoulder-width apart',
      'Grip kettlebell and swing between legs',
      'Thrust hips forward to swing kettlebell to shoulder height',
      'Repeat in fluid motion'
    ],
    targetMuscles: ['Glutes', 'Hamstrings', 'Back', 'Shoulders'],
    category: 'Crossfit',
  ),

  // Mobility
  Exercise(
    id: '7',
    name: 'Hip Flexor Stretch',
    description: 'Improves hip mobility and relieves tightness from prolonged sitting.',
    imageUrl: 'https://images.unsplash.com/photo-1609981325073-4c62f8017d71',
    difficulty: 'Beginner',
    duration: 4,
    calories: 20,
    instructions: [
      'Kneel on one knee, front foot forward',
      'Push hips gently forward',
      'Keep chest upright',
      'Hold for 30 seconds, switch sides'
    ],
    targetMuscles: ['Hip Flexors', 'Quads', 'Lower Back'],
    category: 'Mobility',
  ),
];
