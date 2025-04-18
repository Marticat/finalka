import 'package:flutter/material.dart';

import 'constants.dart';
import 'home.dart';
import 'models/workout_manager.dart';
import 'models/plan_manager.dart';

void main() {
  runApp(const GymFit());
}

class GymFit extends StatefulWidget {
  const GymFit({super.key});

  @override
  State<GymFit> createState() => _GymFitState();
}

class _GymFitState extends State<GymFit> {
  ThemeMode themeMode = ThemeMode.light;
  ColorSelection colorSelected = ColorSelection.red;

  /// Manage user's shopping cart for the items they order.
  final CartManager _cartManager = CartManager();

  /// Manage user's orders submitted
  final PlanManager _orderManager = PlanManager();

  void changeThemeMode(bool useLightMode) {
    setState(() {
      themeMode = useLightMode
          ? ThemeMode.light //
          : ThemeMode.dark;
    });
  }

  void changeColor(int value) {
    setState(() {
      colorSelected = ColorSelection.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'GymFit';

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false, // Uncomment to remove Debug banner
      themeMode: themeMode,
      theme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: Home(
        appTitle: appTitle,
        workoutManager: _cartManager,
        planManager: _orderManager,
        changeTheme: changeThemeMode,
        changeColor: changeColor,
        colorSelected: colorSelected,
      ),
    );
  }
}