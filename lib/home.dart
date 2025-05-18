// home.dart
import 'package:flutter/material.dart';
import 'package:finalka/screens/explore_page.dart';
import 'package:finalka/screens/community_page.dart';
import 'package:finalka/screens/myorders_page.dart';
import 'package:finalka/screens/food_search_screen.dart';
import 'package:finalka/screens/map_screen.dart';
import 'package:finalka/screens/profile_page.dart';
import 'package:finalka/models/workout_manager.dart';
import 'package:finalka/models/plan_manager.dart';
import 'package:finalka/constants.dart';
import 'package:finalka/services/auth_service.dart';
import 'package:finalka/components/theme_button.dart';
import 'package:finalka/components/color_button.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.workoutManager,
    required this.planManager,
    required this.changeTheme,
    required this.changeColor,
    required this.colorSelected,
    required this.appTitle,
    required this.auth,
  });

  final WorkoutManager workoutManager;
  final PlanManager planManager;
  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final ColorSelection colorSelected;
  final String appTitle;
  final AuthService auth;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _selectedTab = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Widget> _pages = [
    const Placeholder(),
    const CommunityPage(),
    const Placeholder(),
    FoodSearchScreen(),
    const MapScreen(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    // Initialize pages with proper dependencies
    _pages[0] = ExplorePage(
      workoutManager: widget.workoutManager,
      planManager: widget.planManager,
    );
    _pages[2] = MyOrdersPage(planManager: widget.planManager);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
        actions: [
          ThemeButton(changeThemeMode: widget.changeTheme),
          ColorButton(
            changeColor: widget.changeColor,
            colorSelected: widget.colorSelected,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await widget.auth.signOut();
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: IndexedStack(
          index: _selectedTab,
          children: _pages,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) {
          setState(() {
            _selectedTab = index;
            _animationController.reset();
            _animationController.forward();
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outlined),
            label: 'Community',
            selectedIcon: Icon(Icons.people),
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
            icon: Icon(Icons.map_outlined),
            label: 'Map',
            selectedIcon: Icon(Icons.map),
          ),
          NavigationDestination(
            icon: Icon(Icons.person_2_outlined),
            label: 'Account',
            selectedIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}