class ExerciseCategory {
  String name;
  int numberOfRestaurants;
  String imageUrl;

  ExerciseCategory(this.name, this.numberOfRestaurants, this.imageUrl);
}

List<ExerciseCategory> categories = [
  ExerciseCategory('Cardio', 16, 'assets/categories/cardio.png'),
  ExerciseCategory('Strength', 20, 'assets/categories/strength.png'),
  ExerciseCategory('HIIT', 21, 'assets/categories/hiit.png'),
  ExerciseCategory('Yoga', 16, 'assets/categories/yoga.png'),
  ExerciseCategory('Pilates', 18, 'assets/categories/pilates.png'),
  ExerciseCategory('CrossFit', 15, 'assets/categories/crossfit.png'),
  ExerciseCategory('Calisthenics', 14, 'assets/categories/calisthenics.png'),
  ExerciseCategory('Mobility', 19, 'assets/categories/mobility.png'),
  ExerciseCategory('Stretching', 15, 'assets/categories/stretching.png'),
  ExerciseCategory('Functional', 22, 'assets/categories/functional.png'),
  ExerciseCategory('Core Training', 23, 'assets/categories/core_training.png'),
  ExerciseCategory('Weightlifting', 18, 'assets/categories/weightlifting.png'),
];
