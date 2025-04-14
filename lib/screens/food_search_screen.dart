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

  void search() async {
    final data = await _foodService.searchFoods(_controller.text);
    setState(() => results = data);
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
                labelText: 'Search food',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: search,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                return ListTile(
                  leading: item['image'] != null
                      ? Image.network(item['image'], width: 40, height: 40, fit: BoxFit.cover)
                      : Icon(Icons.fastfood),
                  title: Text(item['title']),
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
