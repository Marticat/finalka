class Post {
  String id;
  String profileImageUrl;
  String comment;
  String timestamp;

  Post(
    this.id,
    this.profileImageUrl,
    this.comment,
    this.timestamp,
  );
}
List<Post> posts = [
  Post(
    '1',
    'assets/profile_pics/person_cesare.jpeg',
    'Crushed leg day this morning — squats felt amazing!',
    '10',
  ),
  Post(
    '2',
    'assets/profile_pics/person_stef.jpeg',
    'Tried a new push-pull workout today. Felt the burn 💪',
    '80',
  ),
  Post(
    '3',
    'assets/profile_pics/person_crispy.png',
    'Active recovery today with yoga and core work. Feeling fresh.',
    '20',
  ),
  Post(
    '4',
    'assets/profile_pics/person_joe.jpeg',
    '5AM deadlifts. No excuses. Just discipline.',
    '30',
  ),
  Post(
    '5',
    'assets/profile_pics/person_katz.jpeg',
    '''Fueling up post-workout with a protein smoothie. Gains incoming!''',
    '40',
  ),
  Post(
    '6',
    'assets/profile_pics/person_kevin.jpeg',
    '''Hit chest and triceps hard today. Bench is going up!''',
    '50',
  ),
  Post(
    '7',
    'assets/profile_pics/person_sandra.jpeg',
    '''Started the day with fasted cardio. Let’s gooo!''',
    '50',
  ),
  Post(
    '8',
    'assets/profile_pics/person_manda.png',
    'Thinking of trying calisthenics today. Any tips?',
    '60',
  ),
  Post(
    '9',
    'assets/profile_pics/person_ray.jpeg',
    'New PR on deadlifts this week — progress feels GOOD!',
    '70',
  ),
  Post(
    '10',
    'assets/profile_pics/person_tiffani.jpeg',
    'Meal prepped for the week. Clean eats = clean gains.',
    '90',
  ),
];
