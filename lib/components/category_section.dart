import 'package:flutter/material.dart';
import '../components/category_card.dart';
import '../models/exercise_category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategorySection extends StatelessWidget {
  final List<ExerciseCategory> categories;
  final void Function(ExerciseCategory)? onCategoryTap;

  const CategorySection({
    super.key,
    required this.categories,
    this.onCategoryTap,
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
              l10n!.exerciseTypes,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 275,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return SizedBox(
                  width: 200,
                  child: CategoryCard(
                    category: category,
                    onTap: () {
                      if (onCategoryTap != null) {
                        onCategoryTap!(category);
                      }
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