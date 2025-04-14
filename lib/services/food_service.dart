import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodService {
  final String apiKey = '986cd2dc88574c08b9a9f34ef8cd1a78';

  Future<List<dynamic>> searchFoods(String query) async {
    final url = Uri.parse(
      'https://api.spoonacular.com/food/products/search?query=$query&number=10&apiKey=$apiKey',
    );

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return data['products'];
  }

  Future<Map<String, dynamic>> getDailyMealPlan({int targetCalories = 2000}) async {
    final url = Uri.parse(
      'https://api.spoonacular.com/mealplanner/generate?timeFrame=day&targetCalories=$targetCalories&apiKey=$apiKey',
    );

    final response = await http.get(url);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getNutritionInfo(int recipeId) async {
    final url = Uri.parse(
      'https://api.spoonacular.com/recipes/$recipeId/nutritionWidget.json?apiKey=$apiKey',
    );

    final response = await http.get(url);
    return jsonDecode(response.body);
  }


}
