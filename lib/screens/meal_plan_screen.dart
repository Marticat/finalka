import 'package:flutter/material.dart';
import '../services/food_service.dart';

class MealPlanScreen extends StatefulWidget {
  @override
  _MealPlanScreenState createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  final FoodService _foodService = FoodService();
  List meals = [];

  @override
  void initState() {
    super.initState();
    loadMealPlan();
  }

  void loadMealPlan() async {
    final data = await _foodService.getDailyMealPlan();
    setState(() {
      meals = data['meals'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daily Meal Plan')),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return ListTile(
            title: Text(meal['title']),
            subtitle: Text('${meal['readyInMinutes']} min • ${meal['servings']} servings'),
            trailing: Icon(Icons.fastfood),
          );
        },
      ),
    );
  }
}
