import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/workout_manager.dart' show WorkoutManager, CartItem;
import '../models/plan_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutPage extends StatefulWidget {
  final WorkoutManager workoutManager;
  final Function() didUpdate;
  final Function(WorkoutPlan) onSubmit;

  const CheckoutPage({
    super.key,
    required this.workoutManager,
    required this.didUpdate,
    required this.onSubmit,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text('Superset'),
    1: Text('With Rest'),
  };
  Set<int> selectedSegment = {0};
  TimeOfDay? selectedTime;
  DateTime? selectedDate;
  final DateTime _firstDate = DateTime(DateTime.now().year - 2);
  final DateTime _lastDate = DateTime(DateTime.now().year + 1);
  final TextEditingController _nameController = TextEditingController();

  String formatDate(DateTime? dateTime) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    if (dateTime == null) {
      return l10n!.selectWorkoutDate;
    }
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  String formatTimeOfDay(TimeOfDay? timeOfDay) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    if (timeOfDay == null) {
      return l10n!.selectStartTime;
    }
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void onSegmentSelected(Set<int> segmentIndex) {
    setState(() {
      selectedSegment = segmentIndex;
    });
  }

  Widget _buildOrderSegmentedType() {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return SegmentedButton(
      showSelectedIcon: false,
      segments: [
        ButtonSegment(
          value: 0,
          label: Text(l10n!.superset),
          icon: const Icon(Icons.fitness_center),
        ),
        ButtonSegment(
          value: 1,
          label: Text(l10n.withRest),
          icon: const Icon(Icons.timer),
        ),
      ],
      selected: selectedSegment,
      onSelectionChanged: onSegmentSelected,
    );
  }

  Widget _buildTextField() {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: l10n!.workoutPlanName,
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Widget _buildOrderSummary(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    return Expanded(
      child: ListView.builder(
        itemCount: widget.workoutManager.items.length,
        itemBuilder: (context, index) {
          final item = widget.workoutManager.itemAt(index);

          return Dismissible(
            key: Key(item.id),
            direction: DismissDirection.endToStart,
            background: Container(),
            secondaryBackground: const SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete),
                ],
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                widget.workoutManager.removeItem(item.id);
              });
              widget.didUpdate();
            },
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(
                    color: colorTheme.primary,
                    width: 2.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Text('x${item.quantity}'),
                ),
              ),
              title: Text(item.name),
              subtitle: Text('Calories: '),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return ElevatedButton(
      onPressed: widget.workoutManager.isEmpty
          ? null
          : () {
        final selectedSegment = this.selectedSegment;
        final selectedTime = this.selectedTime;
        final selectedDate = this.selectedDate;
        final name = _nameController.text;
        final items = widget.workoutManager.items;
        final order = WorkoutPlan(
          selectedSegment: selectedSegment,
          selectedTime: selectedTime,
          selectedDate: selectedDate,
          name: name,
          items: items,
        );
        widget.workoutManager.resetCart();
        widget.onSubmit(order);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(l10n!.acceptPlan),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n!.workoutDetails,
              style: textTheme.headlineSmall,
            ),
            const SizedBox(height: 16.0),
            _buildOrderSegmentedType(),
            const SizedBox(height: 16.0),
            _buildTextField(),
            const SizedBox(height: 16.0),
            Row(
              children: [
                TextButton(
                  child: Text(formatDate(selectedDate)),
                  onPressed: () => _selectDate(context),
                ),
                TextButton(
                  child: Text(formatTimeOfDay(selectedTime)),
                  onPressed: () => _selectTime(context),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(l10n.exerciseSummary),
            _buildOrderSummary(context),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }
}