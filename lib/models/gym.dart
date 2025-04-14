class ExerciseItem {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  ExerciseItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class Gym {
  String id;
  String name;
  String address;
  String attributes;
  String imageUrl;
  String imageCredits;
  double distance;
  double rating;
  List<ExerciseItem> items;

  Gym(
    this.id,
    this.name,
    this.address,
    this.attributes,
    this.imageUrl,
    this.imageCredits,
    this.distance,
    this.rating,
    this.items,
  );

  String getRatingAndDistance() {
    return '''Rating: ${rating.toStringAsFixed(1)} ★ | Distance: ${distance.toStringAsFixed(1)} km''';
  }
}

List<Gym> gyms = [
  Gym(
    '0',
    'Iron Gym',
    '123 Muscle Ave, Los Angeles, CA 90001',
    'Strength Training, Powerlifting, CrossFit',
    'assets/gyms/iron_gym.png',
    'https://images.unsplash.com/photo-1604010115910-568fb53f858b?auto=format&fit=crop&w=1548&q=80',
    3.0,
    4.8,
    [
      ExerciseItem(
        name: 'Deadlift',
        description:
        '''A full-body strength exercise that targets your back, hips, and legs using a barbell.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://images.unsplash.com/photo-1605296867304-46d5465a13f1?auto=format&fit=crop&w=1160&q=80',
      ),
      ExerciseItem(
        name: 'Squats',
        description:
        '''Great compound exercise for building lower body strength, targeting quads, hamstrings, and glutes.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://www.tonal.com/wp-content/uploads/2023/03/Bodyweight-Squat.jpg?resize=576%2C576',
      ),
      ExerciseItem(
        name: 'Pull-Ups',
        description:
        '''Upper body strength exercise focusing on back and biceps using body weight.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://barbend.com/wp-content/uploads/2024/05/never-start-back-workouts-with-pull-ups-1713758245.jpg',
      ),
      ExerciseItem(
        name: 'Push-Ups',
        description:
        '''Classic bodyweight exercise for building upper body strength, particularly chest and triceps.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://www.endomondo.com/wp-content/uploads/2024/08/Benefits-of-Push-Ups.jpg',
      ),
    ],
  ),
  Gym(
    '1',
    'Powerhouse Gym',
    '456 Strength Blvd, Miami, FL 33101',
    'Powerlifting, Strongman, Olympic Lifting',
    'assets/gyms/powerhouse_gym.jpeg',
    'https://images.unsplash.com/photo-1583454110550-7a453fa337f5?auto=format&fit=crop&w=1470&q=80',
    2.5,
    4.7,
    [
      ExerciseItem(
        name: 'Bench Press',
        description:
        '''A key exercise for building chest strength, using a barbell for pressing movements.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://www.anytimefitness.com/wp-content/uploads/2024/01/AF-HERO_BenchPress-1024x683.jpg',
      ),
      ExerciseItem(
        name: 'Yoke Walk',
        description:
        '''Strongman event that works your entire body with a heavy weight carried on your shoulders.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://www.frontiersin.org/files/Articles/670297/fspor-03-670297-HTML/image_m/fspor-03-670297-g001.jpg',
      ),
      ExerciseItem(
        name: 'Overhead Press',
        description:
        '''Build upper body strength and shoulder stability with this compound movement.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://images.squarespace-cdn.com/content/v1/5d53668c6636c10001f5d9b3/1729025101429-OUGFDILFME73SBVYMP8L/pexels-ketut-subiyanto-4720789.jpg?format=1000w',
      ),
      ExerciseItem(
        name: 'Farmers Walk',
        description:
        '''Another strongman training movement focusing on grip strength and full body conditioning.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://hips.hearstapps.com/hmg-prod/images/farmers-walk-1601465939.jpg',
      ),
    ],
  ),
  Gym(
    '2',
    'FitLab Gym',
    '789 Athlete St, San Francisco, CA 94105',
    'CrossFit, HIIT, Mobility Training',
    'assets/gyms/fitlab_gym.jpeg',
    'https://images.unsplash.com/photo-1591277463315-58d8e4e84d4d?auto=format&fit=crop&w=1470&q=80',
    1.8,
    4.9,
    [
      ExerciseItem(
        name: 'Burpees',
        description:
        '''A high-intensity bodyweight exercise that works your full body, improving cardiovascular endurance.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://i0.wp.com/www.muscleandfitness.com/wp-content/uploads/2017/04/burpee-1109.jpg?w=1300&h=731&crop=1&quality=86&strip=all',
      ),
      ExerciseItem(
        name: 'Kettlebell Swings',
        description:
        '''A powerful hip movement using a kettlebell, great for posterior chain development and conditioning.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://images.squarespace-cdn.com/content/v1/5a039e7332601eca495b1fe4/b1d1946e-69d3-44cf-8b71-3613652bc0eb/KBA+Deadstop+Swing.jpg',
      ),
      ExerciseItem(
        name: 'Box Jumps',
        description:
        '''An explosive movement to improve lower body power and agility by jumping onto a raised platform.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://hips.hearstapps.com/hmg-prod/images/box-jump-1585302208.jpeg',
      ),
      ExerciseItem(
        name: 'Double-Unders',
        description:
        '''A jump rope skill focusing on endurance and agility, performed with the rope passing under the feet twice.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://i.ytimg.com/vi/82jNjDS19lg/maxresdefault.jpg',
      ),
    ],
  ),
];
