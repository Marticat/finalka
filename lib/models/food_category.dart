class FoodCategory {
  String name;
  int numberOfRestaurants;
  String imageUrl;

  FoodCategory(this.name, this.numberOfRestaurants, this.imageUrl);
}

List<FoodCategory> categories = [
  FoodCategory('Cardio', 16, 'assets/categories/cardio.png'),
  FoodCategory('Strength', 20, 'assets/categories/strength.png'),
  FoodCategory('HIIT', 21, 'assets/categories/hiit.png'),
  FoodCategory('Yoga', 16, 'assets/categories/yoga.png'),
  FoodCategory('Pilates', 18, 'assets/categories/pilates.png'),
  FoodCategory('CrossFit', 15, 'assets/categories/crossfit.png'),
  FoodCategory('Calisthenics', 14, 'assets/categories/calisthenics.png'),
  FoodCategory('Mobility', 19, 'assets/categories/mobility.png'),
  FoodCategory('Stretching', 15, 'assets/categories/stretching.png'),
  FoodCategory('Functional', 22, 'assets/categories/functional.png'),
  FoodCategory('Core Training', 23, 'assets/categories/core_training.png'),
  FoodCategory('Weightlifting', 18, 'assets/categories/weightlifting.png'),
];
