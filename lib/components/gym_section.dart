import 'package:flutter/material.dart';

import '../components/gym_landscape_card.dart';
import '../models/workout_manager.dart';
import '../models/plan_manager.dart';
import '../models/gym.dart';
import '../screens/gym_page.dart';

class GymSection extends StatelessWidget {
  final List<Gym> gyms;
  final CartManager workoutManager;
  final PlanManager planManager;

  const GymSection({
    super.key,
    required this.gyms,
    required this.workoutManager,
    required this.planManager,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              'Gym near me',
              style: TextStyle(
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
                          builder: (context) => RestaurantPage(
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