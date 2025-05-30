import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../services/food_service.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  _MealPlanScreenState createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  final FoodService _foodService = FoodService();
  List<dynamic> meals = [];
  bool _isLoading = false;
  int _targetCalories = 2000;
  String _dietType = 'balanced';
  bool _showNutritionDetails = false;

  final List<String> dietTypes = [
    'balanced',
    'high-protein',
    'low-carb',
    'low-fat',
    'vegetarian',
    'vegan',
    'keto',
    'mediterranean'
  ];

  @override
  void initState() {
    super.initState();
    _loadMealPlan();
  }

  Future<void> _loadMealPlan() async {
    setState(() => _isLoading = true);
    try {
      final url = Uri.parse(
        '${_foodService.baseUrl}/mealplanner/generate?timeFrame=day&targetCalories=$_targetCalories&diet=$_dietType&apiKey=${_foodService.apiKey}',
      );
      final response = await _foodService.client.get(url);

      if (response.statusCode == 200) {
        final plan = jsonDecode(response.body);
        setState(() {
          meals = plan['meals'] ?? [];
        });
      } else {
        throw Exception('Failed to load meal plan: ${response.statusCode}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildMealCard(Map<String, dynamic> meal, BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showMealDetails(meal['id']),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: meal['image'] != null
                        ? Image.network(
                      meal['image'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[200],
                      child: const Icon(Icons.fastfood, size: 40),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal['title'] ?? 'Unknown meal',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ready in ${meal['readyInMinutes']} min • ${meal['servings']} servings',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_showNutritionDetails) ...[
                const SizedBox(height: 8),
                const Divider(),
                FutureBuilder<Map<String, dynamic>>(
                  future: _foodService.getRecipeInformation(meal['id']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError || !snapshot.hasData) {
                      return const Text('Error loading nutrition');
                    }

                    final nutrients = snapshot.data!['nutrition']['nutrients'];
                    return Column(
                      children: [
                        _buildNutritionRow('Protein', nutrients[8]['amount'], 'g'),
                        _buildNutritionRow('Fat', nutrients[1]['amount'], 'g'),
                        _buildNutritionRow('Carbs', nutrients[3]['amount'], 'g'),
                      ],
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionRow(String label, dynamic value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text('$value$unit'),
        ],
      ),
    );
  }

  Future<void> _showMealDetails(int mealId) async {
    try {
      final recipe = await _foodService.getRecipeInformation(mealId);
      if (!mounted) return;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          builder: (_, controller) => SingleChildScrollView(
            controller: controller,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 60,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  if (recipe['image'] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        recipe['image'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    recipe['title'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.timer, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        'Ready in ${recipe['readyInMinutes']} min',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.people, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${recipe['servings']} servings',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...(recipe['extendedIngredients'] as List).map((ingredient) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text('- ${ingredient['original']}'),
                      ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Instructions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(recipe['instructions'] ?? 'No instructions available'),
                ],
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Widget _buildDietTypeChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: dietTypes.map((type) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(
                type.replaceAll('-', ' '),
                style: TextStyle(
                  color: _dietType == type ? Colors.white : null,
                ),
              ),
              selected: _dietType == type,
              onSelected: (selected) {
                setState(() => _dietType = selected ? type : 'balanced');
                _loadMealPlan();
              },
              selectedColor: Theme.of(context).primaryColor,
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Plan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadMealPlan,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      'Daily Nutrition',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildDietTypeChips(),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Target: $_targetCalories kcal',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                          onPressed: _showCalorieDialog,
                          child: const Text('Change'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Show nutrition details'),
            value: _showNutritionDetails,
            onChanged: (value) => setState(() => _showNutritionDetails = value),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : meals.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.fastfood, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No meals planned yet',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
                : ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                return _buildMealCard(meals[index], context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCalorieDialog() async {
    final TextEditingController controller = TextEditingController(
      text: _targetCalories.toString(),
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Target Calories'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter target calories',
                suffixText: 'kcal',
              ),
            ),
            const SizedBox(height: 16),
            Slider(
              value: _targetCalories.toDouble(),
              min: 1200,
              max: 4000,
              divisions: 28,
              label: '$_targetCalories kcal',
              onChanged: (value) {
                setState(() {
                  _targetCalories = value.round();
                  controller.text = _targetCalories.toString();
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _targetCalories = int.tryParse(controller.text) ?? 2000;
              Navigator.pop(context);
              _loadMealPlan();
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}