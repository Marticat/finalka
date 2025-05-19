import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';
import '../models/workout_manager.dart';
import '../models/gym.dart';
import 'cart_control.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ItemDetails extends StatefulWidget {
  final ExerciseItem item;
  final WorkoutManager workoutManager;
  final void Function() quantityUpdated;

  const ItemDetails({
    super.key,
    required this.item,
    required this.workoutManager,
    required this.quantityUpdated,
  });

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> with TickerProviderStateMixin {
  late AnimationController _enterController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  late AnimationController _addToCartController;
  bool _showSuccessAnimation = false;

  @override
  void initState() {
    super.initState();
    _enterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _enterController,
        curve: Curves.easeIn,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _enterController,
        curve: Curves.easeOut,
      ),
    );
    _addToCartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _enterController.forward();
  }

  @override
  void dispose() {
    _enterController.dispose();
    _addToCartController.dispose();
    super.dispose();
  }

  Future<void> _handleAddToCart(int number) async {
    await HapticFeedback.lightImpact();
    setState(() => _showSuccessAnimation = true);
    const uuid = Uuid();
    final uniqueId = uuid.v4();
    final cartItem = CartItem(
      id: uniqueId,
      name: widget.item.name,
      price: widget.item.price,
      quantity: number,
    );
    widget.workoutManager.addItem(cartItem);
    widget.quantityUpdated();
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return Stack(
      children: [
        SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.item.name,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Step 1 of 4',  // Fixed line
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.item.description,
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  Hero(
                    tag: 'item-${widget.item.name}',
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(widget.item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 0.95).animate(
                      CurvedAnimation(
                        parent: _addToCartController,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: CartControl(
                      addToCart: (number) {
                        _addToCartController.forward().then((_) {
                          _addToCartController.reverse();
                          _handleAddToCart(number);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_showSuccessAnimation)
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Lottie.asset(
                  'assets/animations/success.json',
                  width: 150,
                  height: 150,
                  repeat: false,
                ),
              ),
            ),
          ),
      ],
    );
  }
}