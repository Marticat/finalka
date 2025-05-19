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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'difficulty': difficulty,
      'duration': duration,
      'calories': calories,
      'category': category,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      difficulty: map['difficulty'],
      duration: map['duration'],
      calories: map['calories'],
      instructions: [],
      targetMuscles: [],
      category: map['category'],
    );
  }
}
List<Exercise> exercises = [
  // Strength
  Exercise(
    id: '1',
    name: 'Deadlift',
    description: 'A compound exercise that works multiple muscle groups including the hamstrings, glutes, lower and upper back.',
    imageUrl: 'https://kinxlearning.com/cdn/shop/files/exercise-10_1000x.jpg?v=1613154681',
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
    imageUrl: 'https://training.fit/wp-content/uploads/2020/02/liegestuetze.png',
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
    imageUrl: 'https://post.healthline.com/wp-content/uploads/2020/01/Runner-training-on-running-track-1296x728-header-1296x728.jpg',
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
    imageUrl: 'https://cdn.shopify.com/s/files/1/0252/3155/6686/files/What_Muscles_do_Burpees_Work.jpg?v=1714495190',
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
    imageUrl: 'https://yogawithsapna.com/wp-content/uploads/2016/06/downward-facing-dog-anatomy.png',
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
    imageUrl: 'https://weighttraining.guide/wp-content/uploads/2017/03/Kettlebell-Swing-resized.png',
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
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb-r_n79NveJz2Q872kKl7rrOHkBJ_CxaLCg&s',
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
