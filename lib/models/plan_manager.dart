import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'workout_manager.dart';

class WorkoutPlan {
  final Set<int> selectedSegment;
  final TimeOfDay? selectedTime;
  final DateTime? selectedDate;
  final String name;
  final List<CartItem> items;

  WorkoutPlan({
    required this.selectedSegment,
    required this.selectedTime,
    required this.selectedDate,
    required this.name,
    required this.items,
  });

  String getFormattedSegment() {
    if (selectedSegment.contains(0)) {
      return 'Superset';
    } else if (selectedSegment.contains(1)) {
      return 'With Rest';
    } else {
      return 'Unknown'; // Handle any other cases as needed
    }
  }

  String getFormattedTime() {
    if (selectedTime == null) {
      return 'Unknown';
    }
    final hour = selectedTime!.hour.toString().padLeft(2, '0');
    final minute = selectedTime!.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String getFormattedDate() {
    if (selectedDate == null) {
      return 'Unknown';
    }
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(selectedDate!);
  }

  String getFormattedName() {
    if (name.isEmpty) {
      return 'Unknown';
    }
    return name;
  }

  String getFormattedOrderInfo() {
    final segmentString = getFormattedSegment();
    final name = getFormattedName();
    final timeString = getFormattedTime();
    final dateString = getFormattedDate();

    return '$name, Date: $dateString, Time: $timeString, $segmentString';
  }
}

class OrderManager {
  final List<WorkoutPlan> _orders = [];

  List<WorkoutPlan> get orders => _orders; // Getter to access the orders

  void addOrder(WorkoutPlan order) {
    _orders.add(order);
  }

  void removeOrder(WorkoutPlan order) {
    _orders.remove(order);
  }

  int get totalOrders => _orders.length;
}
