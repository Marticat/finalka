import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:finalka/services/auth_screen.dart';
import 'package:finalka/services/auth_service.dart';
import 'home.dart';
import 'models/workout_manager.dart';
import 'models/plan_manager.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:finalka/l10n/l10n.dart';

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

class _GymFitState extends State<GymFit> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final AuthService _auth = AuthService();
  ThemeMode themeMode = ThemeMode.light;
  ColorSelection colorSelected = ColorSelection.red;
  final WorkoutManager _workoutManager = WorkoutManager();
  final PlanManager _orderManager = PlanManager();
  Locale _locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void changeThemeMode(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void changeColor(int value) {
    setState(() {
      colorSelected = ColorSelection.values[value];
      _animationController.forward(from: 0);
    });
  }

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'GymFit',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      locale: _locale,


      theme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.light,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.dark,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: StreamBuilder<User?>(
        stream: _auth.user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                  child: const CircularProgressIndicator(),
                ),
              ),
            );
          }

          if (snapshot.hasData) {
            return Home(
              appTitle: Localizations.of<AppLocalizations>(context, AppLocalizations)?.appTitle ?? 'GymFit',

              workoutManager: _workoutManager,
              planManager: _orderManager,
              changeTheme: changeThemeMode,
              changeColor: changeColor,
              colorSelected: colorSelected,
              auth: _auth,
              changeLanguage: changeLanguage,
            );
          }

          return const AuthScreen();
        },
      ),
    );
  }
}