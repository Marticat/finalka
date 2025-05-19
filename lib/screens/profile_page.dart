import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../models/plan_manager.dart';

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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Planned Exercise'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _exerciseNameController,
                  decoration: const InputDecoration(labelText: 'Exercise Name'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _caloriesController,
                  decoration: const InputDecoration(labelText: 'Calories'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _durationController,
                  decoration: const InputDecoration(labelText: 'Duration (mins)'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
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
                  decoration: const InputDecoration(labelText: 'Category'),
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
                  decoration: const InputDecoration(labelText: 'Difficulty'),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _addExercise,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editExercise(Exercise exercise) {
    _exerciseNameController.text = exercise.name;
    _caloriesController.text = exercise.calories.toString();
    _durationController.text = exercise.duration.toString();
    _selectedCategory = exercise.category;
    _selectedDifficulty = exercise.difficulty;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Exercise'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _exerciseNameController,
                  decoration: const InputDecoration(labelText: 'Exercise Name'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _caloriesController,
                  decoration: const InputDecoration(labelText: 'Calories'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _durationController,
                  decoration: const InputDecoration(labelText: 'Duration (mins)'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
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
                  decoration: const InputDecoration(labelText: 'Category'),
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
                  decoration: const InputDecoration(labelText: 'Difficulty'),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
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
            child: const Text('Save'),
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
              "Workout Progress",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              _plannedExercises.isEmpty
                  ? "Start adding exercises!"
                  : "${_plannedExercises.length} exercises planned",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    int totalCalories = _plannedExercises.fold(0, (sum, e) => sum + e.calories);
    int totalDuration = _plannedExercises.fold(0, (sum, e) => sum + e.duration);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your Stats", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Total Exercises: ${_plannedExercises.length}"),
            Text("Total Duration: $totalDuration mins"),
            Text("Total Calories: $totalCalories cal"),
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
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
              title: 'Planned Exercises',
              children: _plannedExercises.map(_buildExercisePlanCard).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExercisePlanCard(Exercise exercise) {
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
