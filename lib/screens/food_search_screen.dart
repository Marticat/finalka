import 'package:flutter/material.dart';
import '../services/food_service.dart';

class FoodSearchScreen extends StatefulWidget {
  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  final FoodService _foodService = FoodService();
  final TextEditingController _controller = TextEditingController();
  List<dynamic> results = [];
  bool _isLoading = false;

  void search() async {
    if (_controller.text.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final data = await _foodService.searchFoods(_controller.text);
      setState(() => results = data);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Search failed: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }


  void _showRecipeDetails(int recipeId) async {
    try {
      final recipe = await _foodService.getRecipeInformation(recipeId);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(recipe['title']),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (recipe['image'] != null)
                  Image.network(recipe['image'], height: 150, fit: BoxFit.cover),
                SizedBox(height: 12),
                Text('Ready in ${recipe['readyInMinutes']} minutes'),
                Text('Servings: ${recipe['servings']}'),
                SizedBox(height: 12),
                Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...(recipe['extendedIngredients'] as List).map((ingredient) =>
                    Text('- ${ingredient['original']}')).toList(),
                SizedBox(height: 12),
                Text('Nutrition:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...(recipe['nutrition']['nutrients'] as List).take(5).map((nutrient) =>
                    Text('${nutrient['name']}: ${nutrient['amount']}${nutrient['unit']}')).toList(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load recipe details: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Search')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search food products',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: search,
                ),
              ),
              onSubmitted: (_) => search(),
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                return ListTile(
                  leading: item['image'] != null
                      ? Image.network(
                    item['image'],
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  )
                      : Icon(Icons.fastfood),
                  title: Text(item['title'] ?? item['name'] ?? 'Unknown'),
                  subtitle: Text(item['brand'] ?? ''),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}