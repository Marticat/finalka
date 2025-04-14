import 'package:flutter/material.dart';

import '../models/plan_manager.dart';

class MyOrdersPage extends StatelessWidget {
  final OrderManager orderManager;

  const MyOrdersPage({
    super.key,
    required this.orderManager,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Planned exercises',
          style: textTheme.headlineMedium,
        ),
      ),
      body: ListView.builder(
        itemCount: orderManager.totalOrders,
        itemBuilder: (context, index) {
          return OrderTile(order: orderManager.orders[index]);
        },
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final WorkoutPlan order;

  const OrderTile({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/food/burger.png',
          width: 50.0,
          height: 50.0,
          fit: BoxFit.cover,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Scheduled',
            style: textTheme.bodyLarge,
          ),
          Text(order.getFormattedOrderInfo()),
          Text('Exercises: ${order.items.length}'),
        ],
      ),
    );
  }
}