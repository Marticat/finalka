import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:finalka/services/auth_screen.dart';
import 'package:finalka/services/auth_service.dart';
import 'home.dart';
import 'models/workout_manager.dart';
import 'models/plan_manager.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const GymFit());
}

class GymFit extends StatefulWidget {
  const GymFit({super.key});

  @override
  State<GymFit> createState() => _GymFitState();
}

class _GymFitState extends State<GymFit> {
  final AuthService _auth = AuthService();
  ThemeMode themeMode = ThemeMode.light;
  ColorSelection colorSelected = ColorSelection.red;
  final CartManager _cartManager = CartManager();
  final PlanManager _orderManager = PlanManager();

  void changeThemeMode(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
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
      debugShowCheckedModeBanner: false,
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
      home: StreamBuilder<User?>(
        stream: _auth.user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasData) {
            return Home(
              appTitle: appTitle,
              workoutManager: _cartManager,
              planManager: _orderManager,
              changeTheme: changeThemeMode,
              changeColor: changeColor,
              colorSelected: colorSelected,
              auth: _auth,
            );
          }

          return AuthScreen();
        },
      ),
    );
  }
}