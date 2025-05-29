import 'dart:convert';
import 'package:http/http.dart' as http;


class FoodService {
  final String apiKey = '986cd2dc88574c08b9a9f34ef8cd1a78';
  final String baseUrl = 'https://api.spoonacular.com';

  Future<List<dynamic>> searchFoods(String query) async {
    final url = Uri.parse(
      '$baseUrl/food/products/search?query=$query&number=10&apiKey=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['products'] ?? [];
    } else {
      throw Exception('Failed to load food search results');
    }
  }

  Future<Map<String, dynamic>> getDailyMealPlan({int targetCalories = 2000}) async {
    final url = Uri.parse(
      '$baseUrl/mealplanner/generate?timeFrame=day&targetCalories=$targetCalories&apiKey=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load meal plan');
    }
  }

  Future<List<dynamic>> searchRecipes(String query, {int number = 10}) async {
    final url = Uri.parse(
      '$baseUrl/recipes/complexSearch?query=$query&number=$number&apiKey=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'] ?? [];
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<Map<String, dynamic>> getRecipeInformation(int id) async {
    final url = Uri.parse(
      '$baseUrl/recipes/$id/information?includeNutrition=true&apiKey=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load recipe information');
    }
  }

  Future<List<dynamic>> getSimilarRecipes(int id, {int number = 5}) async {
    final url = Uri.parse(
      '$baseUrl/recipes/$id/similar?number=$number&apiKey=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load similar recipes');
    }
  }

  Future<Map<String, dynamic>> getNutritionInfo(int recipeId) async {
    final url = Uri.parse(
      '$baseUrl/recipes/$recipeId/nutritionWidget.json?apiKey=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load nutrition info');
    }
  }
}