import 'package:flutter/material.dart';
import 'screens/profile_page.dart';

import 'components/color_button.dart';
import 'components/theme_button.dart';
import 'constants.dart';
import 'models/workout_manager.dart';
import 'models/plan_manager.dart';
import 'screens/explore_page.dart';
import 'screens/myorders_page.dart';
import 'screens/food_search_screen.dart';
import 'screens/meal_plan_screen.dart';



class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.workoutManager,
    required this.planManager,
    required this.changeTheme,
    required this.changeColor,
    required this.colorSelected,
    required this.appTitle,
  });

  final CartManager workoutManager;
  final PlanManager planManager;
  final ColorSelection colorSelected;
  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final String appTitle;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tab = 0;
  List<NavigationDestination> appBarDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
      selectedIcon: Icon(Icons.home),
    ),
    NavigationDestination(
      icon: Icon(Icons.list_outlined),
      label: 'Trainings',
      selectedIcon: Icon(Icons.list),
    ),
    NavigationDestination(
      icon: Icon(Icons.restaurant_outlined),
      label: 'Food',
      selectedIcon: Icon(Icons.restaurant),
    ),
    NavigationDestination(
      icon: Icon(Icons.person_2_outlined),
      label: 'Account',
      selectedIcon: Icon(Icons.person),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      ExplorePage(
        workoutManager: widget.workoutManager,
        planManager: widget.planManager,
      ),
      MyOrdersPage(planManager: widget.planManager),
      FoodSearchScreen(),
      const ProfilePage(), // ← this is new
    ];


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
        elevation: 4.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          ThemeButton(
            changeThemeMode: widget.changeTheme,
          ),
          ColorButton(
            changeColor: widget.changeColor,
            colorSelected: widget.colorSelected,
          ),
        ],
      ),
      body: IndexedStack(
        index: tab,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (index) {
          setState(() {
            tab = index;
          });
        },
        destinations: appBarDestinations,
      ),
    );
  }
}