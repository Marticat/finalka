import 'package:flutter/material.dart';
import '../components/gym_landscape_card.dart';
import '../models/workout_manager.dart';
import '../models/plan_manager.dart';
import '../models/gym.dart';
import '../screens/gym_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GymSection extends StatelessWidget {
  final List<Gym> gyms;
  final WorkoutManager workoutManager;
  final PlanManager planManager;

  const GymSection({
    super.key,
    required this.gyms,
    required this.workoutManager,
    required this.planManager,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              l10n!.gymNearMe,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: gyms.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 300,
                  child: GymLandscapeCard(
                    gym: gyms[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GymPage(
                            gym: gyms[index],
                            workoutManager: workoutManager,
                            planManager: planManager,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}