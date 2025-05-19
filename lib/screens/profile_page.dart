import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../models/plan_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  final PlanManager? planManager;

  const ProfilePage({super.key, this.planManager});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Exercise> _plannedExercises = [];
  final _formKey = GlobalKey<FormState>();
  final _exerciseNameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _durationController = TextEditingController();
  String _selectedCategory = 'Strength';
  String _selectedDifficulty = 'Beginner';

  @override
  void dispose() {
    _exerciseNameController.dispose();
    _caloriesController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _addExercise() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _plannedExercises.add(Exercise(
          id: DateTime.now().toString(),
          name: _exerciseNameController.text,
          description: 'Planned exercise',
          imageUrl: 'assets/categories/strength.png',
          difficulty: _selectedDifficulty,
          duration: int.parse(_durationController.text),
          calories: int.parse(_caloriesController.text),
          instructions: [],
          targetMuscles: [],
          category: _selectedCategory,
        ));
      });
      _clearForm();
      Navigator.pop(context);
    }
  }

  void _clearForm() {
    _exerciseNameController.clear();
    _caloriesController.clear();
    _durationController.clear();
  }

  void _showAddExerciseDialog() {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n!.addPlannedExercise),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _exerciseNameController,
                  decoration: InputDecoration(labelText: l10n.exerciseName),
                  validator: (value) => value!.isEmpty ? l10n.required : null,
                ),
                TextFormField(
                  controller: _caloriesController,
                  decoration: InputDecoration(labelText: l10n.calories),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? l10n.required : null,
                ),
                TextFormField(
                  controller: _durationController,
                  decoration: InputDecoration(labelText: '${l10n.duration} (mins)'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? l10n.required : null,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: ['Strength', 'Cardio', 'HIIT', 'Yoga', 'Mobility']
                      .map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedCategory = value!),
                  decoration: InputDecoration(labelText: l10n.category),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedDifficulty,
                  items: ['Beginner', 'Intermediate', 'Advanced']
                      .map((level) => DropdownMenuItem(
                    value: level,
                    child: Text(level),
                  ))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedDifficulty = value!),
                  decoration: InputDecoration(labelText: l10n.difficulty),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: _addExercise,
            child: Text(l10n.add),
          ),
        ],
      ),
    );
  }

  void _editExercise(Exercise exercise) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations);
    _exerciseNameController.text = exercise.name;
    _caloriesController.text = exercise.calories.toString();
    _durationController.text = exercise.duration.toString();
    _selectedCategory = exercise.category;
    _selectedDifficulty = exercise.difficulty;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n!.editExercise),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _exerciseNameController,
                  decoration: InputDecoration(labelText: l10n.exerciseName),
                  validator: (value) => value!.isEmpty ? l10n.required : null,
                ),
                TextFormField(
                  controller: _caloriesController,
                  decoration: InputDecoration(labelText: l10n.calories),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? l10n.required : null,
                ),
                TextFormField(
                  controller: _durationController,
                  decoration: InputDecoration(labelText: '${l10n.duration} (mins)'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? l10n.required : null,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: ['Strength', 'Cardio', 'HIIT', 'Yoga', 'Mobility']
                      .map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedCategory = value!),
                  decoration: InputDecoration(labelText: l10n.category),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedDifficulty,
                  items: ['Beginner', 'Intermediate', 'Advanced']
                      .map((level) => DropdownMenuItem(
                    value: level,
                    child: Text(level),
                  ))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedDifficulty = value!),
                  decoration: InputDecoration(labelText: l10n.difficulty),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final index = _plannedExercises.indexOf(exercise);
                setState(() {
                  _plannedExercises[index] = Exercise(
                    id: exercise.id,
                    name: _exerciseNameController.text,
                    description: exercise.description,
                    imageUrl: exercise.imageUrl,
                    difficulty: _selectedDifficulty,
                    duration: int.parse(_durationController.text),
                    calories: int.parse(_caloriesController.text),
                    instructions: exercise.instructions,
                    targetMuscles: exercise.targetMuscles,
                    category: _selectedCategory,
                  );
                });
                _clearForm();
                Navigator.pop(context);
              }
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  void _deleteExercise(Exercise exercise) {
    setState(() {
      _plannedExercises.remove(exercise);
    });
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/profile_pics/cat.jpg'),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Profile", style: Theme.of(context).textTheme.titleLarge),
            Text("Fitness Enthusiast", style: Theme.of(context).textTheme.bodyMedium),
          ],
        )
      ],
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: _plannedExercises.isEmpty ? 0 : 0.5,
              semanticsLabel: 'Progress',
            ),
            const SizedBox(height: 8),
            Text(
              l10n!.workoutProgress,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              _plannedExercises.isEmpty
                  ? l10n.startAddingExercises
                  : "${_plannedExercises.length} ${l10n.exercisesPlanned}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations);
    int totalCalories = _plannedExercises.fold(0, (sum, e) => sum + e.calories);
    int totalDuration = _plannedExercises.fold(0, (sum, e) => sum + e.duration);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n!.yourStats, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("${l10n.totalExercises}: ${_plannedExercises.length}"),
            Text("${l10n.totalDuration}: $totalDuration mins"),
            Text("${l10n.totalCalories}: $totalCalories cal"),
          ],
        ),
      ),
    );
  }

  Widget _buildCardSection({required String title, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.myProfile),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExerciseDialog,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 16),
            _buildProgressSection(context),
            _buildStatsSection(context),
            _buildCardSection(
              title: l10n.plannedExercises,
              children: _plannedExercises.map(_buildExercisePlanCard).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExercisePlanCard(Exercise exercise) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.fitness_center),
        title: Text(exercise.name),
        subtitle: Text('${exercise.calories} cal • ${exercise.duration} mins • ${exercise.category}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editExercise(exercise),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteExercise(exercise),
            ),
          ],
        ),
      ),
    );
  }
}