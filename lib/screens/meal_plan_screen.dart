import 'package:flutter/material.dart';
import '../services/food_service.dart';

class MealPlanScreen extends StatefulWidget {
  @override
  _MealPlanScreenState createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  final FoodService _foodService = FoodService();
  List<dynamic> meals = [];
  bool _isLoading = false;
  int _targetCalories = 2000;

  @override
  void initState() {
    super.initState();
    _loadMealPlan();
  }

  Future<void> _loadMealPlan() async {
    setState(() => _isLoading = true);
    try {
      final plan = await _foodService.getDailyMealPlan(targetCalories: _targetCalories);
      setState(() {
        meals = plan['meals'] ?? [];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load meal plan: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildMealItem(Map<String, dynamic> meal) {
    return Card(
      child: ListTile(
        leading: meal['image'] != null
            ? Image.network(meal['image'], width: 50, height: 50, fit: BoxFit.cover)
            : Icon(Icons.fastfood, size: 50),
        title: Text(meal['title'] ?? 'Unknown meal'),
        subtitle: Text('Ready in ${meal['readyInMinutes']} minutes'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Plan'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadMealPlan,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : meals.isEmpty
          ? Center(child: Text('No meals planned yet'))
          : ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return _buildMealItem(meals[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Set Target Calories'),
              content: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter target calories (e.g., 2000)',
                ),
                onChanged: (value) {
                  _targetCalories = int.tryParse(value) ?? 2000;
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _loadMealPlan();
                  },
                  child: Text('Apply'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.settings),
      ),
    );
  }
}
