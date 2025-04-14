class Item {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class Restaurant {
  String id;
  String name;
  String address;
  String attributes;
  String imageUrl;
  String imageCredits;
  double distance;
  double rating;
  List<Item> items;

  Restaurant(
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

List<Restaurant> restaurants = [
  Restaurant(
    '0',
    'Iron Gym',
    '123 Muscle Ave, Los Angeles, CA 90001',
    'Strength Training, Powerlifting, CrossFit',
    'assets/gyms/iron_gym.webp',
    'https://images.unsplash.com/photo-1604010115910-568fb53f858b?auto=format&fit=crop&w=1548&q=80',
    3.0,
    4.8,
    [
      Item(
        name: 'Deadlift',
        description:
        '''A full-body strength exercise that targets your back, hips, and legs using a barbell.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://images.unsplash.com/photo-1605296867304-46d5465a13f1?auto=format&fit=crop&w=1160&q=80',
      ),
      Item(
        name: 'Squats',
        description:
        '''Great compound exercise for building lower body strength, targeting quads, hamstrings, and glutes.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://images.unsplash.com/photo-1603489491897-d93b1fcbf92f?auto=format&fit=crop&w=774&q=80',
      ),
      Item(
        name: 'Pull-Ups',
        description:
        '''Upper body strength exercise focusing on back and biceps using body weight.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://barbend.com/wp-content/uploads/2024/05/never-start-back-workouts-with-pull-ups-1713758245.jpg',
      ),
      Item(
        name: 'Push-Ups',
        description:
        '''Classic bodyweight exercise for building upper body strength, particularly chest and triceps.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://images.unsplash.com/photo-1604130523536-cf372d5f9746?auto=format&fit=crop&w=1470&q=80',
      ),
    ],
  ),
  Restaurant(
    '1',
    'Powerhouse Gym',
    '456 Strength Blvd, Miami, FL 33101',
    'Powerlifting, Strongman, Olympic Lifting',
    'assets/gyms/powerhouse_gym.webp',
    'https://images.unsplash.com/photo-1583454110550-7a453fa337f5?auto=format&fit=crop&w=1470&q=80',
    2.5,
    4.7,
    [
      Item(
        name: 'Bench Press',
        description:
        '''A key exercise for building chest strength, using a barbell for pressing movements.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://images.unsplash.com/photo-1614093973082-ec44b3168f89?auto=format&fit=crop&w=930&q=80',
      ),
      Item(
        name: 'Yoke Walk',
        description:
        '''Strongman event that works your entire body with a heavy weight carried on your shoulders.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://images.unsplash.com/photo-1583454045992-01a0f04c3c4c?auto=format&fit=crop&w=930&q=80',
      ),
      Item(
        name: 'Overhead Press',
        description:
        '''Build upper body strength and shoulder stability with this compound movement.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://images.unsplash.com/photo-1587614102660-61649f7c39c8?auto=format&fit=crop&w=1470&q=80',
      ),
      Item(
        name: 'Farmers Walk',
        description:
        '''Another strongman training movement focusing on grip strength and full body conditioning.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://images.unsplash.com/photo-1575282506070-4c6025b67471?auto=format&fit=crop&w=930&q=80',
      ),
    ],
  ),
  Restaurant(
    '2',
    'FitLab Gym',
    '789 Athlete St, San Francisco, CA 94105',
    'CrossFit, HIIT, Mobility Training',
    'assets/gyms/fitlab_gym.webp',
    'https://images.unsplash.com/photo-1591277463315-58d8e4e84d4d?auto=format&fit=crop&w=1470&q=80',
    1.8,
    4.9,
    [
      Item(
        name: 'Burpees',
        description:
        '''A high-intensity bodyweight exercise that works your full body, improving cardiovascular endurance.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://images.unsplash.com/photo-1600488994736-596af9009a4e?auto=format&fit=crop&w=930&q=80',
      ),
      Item(
        name: 'Kettlebell Swings',
        description:
        '''A powerful hip movement using a kettlebell, great for posterior chain development and conditioning.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://images.unsplash.com/photo-1583454045992-01a0f04c3c4c?auto=format&fit=crop&w=930&q=80',
      ),
      Item(
        name: 'Box Jumps',
        description:
        '''An explosive movement to improve lower body power and agility by jumping onto a raised platform.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://images.unsplash.com/photo-1588618904795-058d879d1c27?auto=format&fit=crop&w=930&q=80',
      ),
      Item(
        name: 'Double-Unders',
        description:
        '''A jump rope skill focusing on endurance and agility, performed with the rope passing under the feet twice.''',
        price: 0.0, // бесплатное упражнение
        imageUrl:
        'https://images.unsplash.com/photo-1603204443134-ec07e40061f1?auto=format&fit=crop&w=930&q=80',
      ),
    ],
  ),
];
