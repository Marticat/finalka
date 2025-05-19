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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    required this.changeLanguage,
  });

  final WorkoutManager workoutManager;
  final PlanManager planManager;
  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final ColorSelection colorSelected;
  final String appTitle;
  final AuthService auth;
  final void Function(Locale locale) changeLanguage;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _selectedTab = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late final List<Widget> _pages;

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

    _pages = [
      ExplorePage(
        workoutManager: widget.workoutManager,
        planManager: widget.planManager,
      ),
      const CommunityPage(),
      MyOrdersPage(
        planManager: widget.planManager,
      ),
      FoodSearchScreen(),
      MapScreen(),
      ProfilePage(),
    ];


    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _changeLanguage(Locale locale) {
    widget.changeLanguage(locale);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: _changeLanguage,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: Locale('en'),
                child: Text('English'),
              ),
              const PopupMenuItem(
                value: Locale('ru'),
                child: Text('Русский'),
              ),
              const PopupMenuItem(
                value: Locale('kk'),
                child: Text('Қазақша'),
              ),
            ],
          ),
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
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            label: l10n!.home,
            selectedIcon: const Icon(Icons.home),
          ),
          NavigationDestination(
            icon: const Icon(Icons.people_outlined),
            label: l10n.community,
            selectedIcon: const Icon(Icons.people),
          ),
          NavigationDestination(
            icon: const Icon(Icons.list_outlined),
            label: l10n.trainings,
            selectedIcon: const Icon(Icons.list),
          ),
          NavigationDestination(
            icon: const Icon(Icons.restaurant_outlined),
            label: l10n.food,
            selectedIcon: const Icon(Icons.restaurant),
          ),
          NavigationDestination(
            icon: const Icon(Icons.map_outlined),
            label: l10n.map,
            selectedIcon: const Icon(Icons.map),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_2_outlined),
            label: l10n.account,
            selectedIcon: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
